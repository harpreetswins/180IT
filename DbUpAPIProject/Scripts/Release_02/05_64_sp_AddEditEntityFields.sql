
/****** Object:  StoredProcedure [admin].[sp_AddEditEntityFields]    Script Date: 09-02-2021 16:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- [admin].[sp_AddEditEntityFields] 0,'[{"Id": 116,"Name": "new field","FieldTypeId": 1,"FormSectionId": 21,"EntityId": 6,"ConstraintTypeId": "4,6,8","LanguageId": 1,"Settings": null,"IsPromoted": false}, {"Id": 116,"Name": "حقل جديد","FieldTypeId": 1,"FormSectionId": 21,"EntityId": 6,"ConstraintTypeId": "4,6,8","LanguageId": 2,"Settings": null,"IsPromoted": false}]'
-- =============================================    
ALTER PROCEDURE [admin].[sp_AddEditEntityFields] @id INT,    
              @entityFields NVARCHAR(4000)    
AS    
BEGIN    
    
 BEGIN TRY    
  BEGIN TRAN    
    
  DECLARE @enlanguageid AS INT = 1, @aralanguageid AS INT = 2, @entityFieldid AS INT, @translationkeyid AS INT = 1, @ordernumber AS INT= 0, @formsectionfieldid AS INT;       
      
  CREATE TABLE #tempEntityField    
  (Id INT,    
  Name NVARCHAR(200),    
  FieldTypeId INT,    
  FormSectionId INT,    
  EntityId INT,  
  ConstraintTypeId NVARCHAR(400),    
  LanguageId INT,    
  Settings NVARCHAR(MAX),    
  IsPromoted BIT    
  )    
  INSERT INTO #tempEntityField    
  (Id,    
  Name,    
  FieldTypeId,    
  FormSectionId,    
  EntityId,   
  ConstraintTypeId,   
  LanguageId,    
  Settings,    
  IsPromoted    
  )    
  SELECT Id,    
  Name,    
  FieldTypeId,    
  FormSectionId,    
  EntityId,  
  constraintTypeId,    
  LanguageId,    
  Settings,    
  IsPromoted FROM OPENJSON(@entityFields) WITH(Id INT,Name NVARCHAR(200),FieldTypeId INT,FormSectionId INT,EntityId INT, ConstraintTypeId NVARCHAR(400),LanguageId INT,Settings NVARCHAR(MAX),IsPromoted BIT);    
    
  SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1 FROM service.FormSectionFields WHERE FormSectionId = (SELECT FormSectionId FROM #tempEntityField WHERE LanguageId = @enlanguageid) ORDER BY OrderNumber DESC;      
    
     MERGE service.EntityFields AS TARGET          
            USING #tempEntityField AS SOURCE          
            ON(TARGET.Id = SOURCE.Id)          
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid          
                THEN UPDATE SET           
                                @entityFieldid = TARGET.Id,           
                                TARGET.Name = SOURCE.Name,           
                                TARGET.EntityId = SOURCE.EntityId          
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid          
                THEN          
                  INSERT(Name, FieldTypeId, EntityId, Settings, IsPromoted)          
                  VALUES(Name, FieldTypeId, EntityId, Settings, IsPromoted);    
    
    --WHEN NOT MATCHED BY SOURCE      
    --            THEN DELETE;     
    
      SET @entityFieldid = ISNULL(@entityFieldid, SCOPE_IDENTITY());          

   MERGE service.Translations AS TARGET          
            USING #tempEntityField AS SOURCE          
            ON(TARGET.ItemId = @entityFieldid         
               AND TARGET.LanguageId = SOURCE.LanguageId          
               AND TARGET.TranslationKeyId = @translationkeyid)          
                WHEN MATCHED AND TARGET.Value <> SOURCE.Name          
                THEN UPDATE SET           
                                TARGET.Value = SOURCE.Name          
                WHEN NOT MATCHED BY TARGET          
                THEN          
                  INSERT(TranslationKeyId, LanguageId, ItemId, Value)          
                  VALUES(@translationkeyid, LanguageId, @entityFieldid, SOURCE.Name);        
    
   MERGE service.FormSectionFields AS TARGET          
            USING #tempEntityField AS SOURCE          
            ON(TARGET.FormSectionId = SOURCE.FormSectionId    
      AND TARGET.EntityFieldId = @entityFieldid)          
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid    
                THEN UPDATE SET   
    @formsectionfieldid = TARGET.Id,     
        TARGET.OrderNumber = @ordernumber,    
        TARGET.EntityFieldId = @entityFieldid     
            
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid    
                THEN          
                  INSERT(FormSectionId, OrderNumber, EntityFieldId)          
                  VALUES(FormSectionId, @ordernumber, @entityFieldId);   
  
      SET @formsectionfieldid = ISNULL(@formsectionfieldid, SCOPE_IDENTITY());  
    
  -- Constraint ADD 


   DECLARE @constraintTypeId NVARCHAR(400)
   SET @constraintTypeId = (SELECT ConstraintTypeId FROM #tempEntityField WHERE LanguageId = @enlanguageid)

   DECLARE @Target_Table TABLE (ConstraintTypeId INT);        
   INSERT INTO @Target_Table SELECT value FROM STRING_SPLIT(@constraintTypeId,',');    
	
	IF EXISTS(SELECT 1 FROM service.FormFieldConstraints WHERE FormSectionFieldId = @formsectionfieldid)
	BEGIN
	DELETE FROM service.FormFieldConstraints WHERE FormSectionFieldId = @formsectionfieldid AND FieldConstraintTypeId NOT IN (SELECT ConstraintTypeId FROM @Target_Table);
	INSERT INTO service.FormFieldConstraints (FormSectionFieldId, FieldConstraintTypeId, Settings) SELECT @formsectionfieldid, CASE WHEN ISNULL(ConstraintTypeId,0) = 0 THEN null ELSE ConstraintTypeId END,null FROM @Target_Table
	WHERE constraintTypeId NOT IN (SELECT FieldConstraintTypeId FROM service.FormFieldConstraints WHERE FormSectionFieldId = @formsectionfieldid);
	END
	ELSE
	BEGIN
	INSERT INTO service.FormFieldConstraints(FormSectionFieldId, FieldConstraintTypeId,Settings)
	SELECT @formsectionfieldid,CASE WHEN ISNULL(ConstraintTypeId,0) = 0 THEN null ELSE ConstraintTypeId END,null FROM @Target_Table;
	END

    SELECT @entityFieldid AS Id,       
                           200 AS STATUS,       
                           'Success' AS Message;      
    
  COMMIT TRANSACTION    
 END TRY    
  BEGIN CATCH        
            SELECT @entityFieldid AS Id,         
                   500 AS STATUS,         
                   ERROR_MESSAGE() AS Message;        
            ROLLBACK TRANSACTION;        
        END CATCH;        
END    
  
    
  
  
    
  
  