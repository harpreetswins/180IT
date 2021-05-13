-- =============================================              
-- Author:  <Author,,Name>              
-- Create date: <Create Date,,>              
-- Description: <Description,,>              
-- [admin].[sp_AddEditEntityFields] 130,'[{"Id":130,"Name":"phone number","FieldTypeId":2,"FormSectionId":21,"EntityId":14,"Constraints":[{"ConstraintTypeId":1,"ConstraintName":"Required","Settings":"{''Required'':{''ControlBy'':[56],''Values'':''true''}}"}],"LanguageId":1,"IsPromoted":false},{"Id":130,"Name":"??? ????????","FieldTypeId":2,"FormSectionId":21,"EntityId":14,"Constraints":[{"ConstraintTypeId":1,"ConstraintName":"Required","Settings":"{''Required'':{''ControlBy'':[56],''Values'':''true''}}"}],"LanguageId":2,"IsPromoted":false}]'
-- =============================================              
ALTER PROCEDURE [admin].[sp_AddEditEntityFields] @id           INT,         
                                                  @entityFields NVARCHAR(4000)        
AS        
    BEGIN        
        BEGIN TRY        
            BEGIN TRAN;        
            DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @entityFieldid AS INT, @translationkeyid AS INT= 1, @ordernumber AS INT= 0, @formsectionfieldid AS INT, @constraintsettings NVARCHAR(MAX);        
            CREATE TABLE #tempEntityField        
            (Id               INT,         
             Name             NVARCHAR(200),         
             FieldTypeId      INT,         
             FormSectionId    INT,         
             EntityId         INT,          
		     Constraints      NVARCHAR(MAX),   
             LanguageId       INT,                 
             IsPromoted       BIT        
            );        
            INSERT INTO #tempEntityField        
            (Id,         
             Name,         
             FieldTypeId,         
             FormSectionId,         
             EntityId,     
			Constraints,         
             LanguageId,          
             IsPromoted        
            )        
                   SELECT Id,         
                          Name,         
                          FieldTypeId,         
                          FormSectionId,         
                          EntityId,      
							Constraints,       
                          LanguageId,          
                          IsPromoted        
                   FROM OPENJSON(@entityFields) WITH(Id INT, Name NVARCHAR(200), FieldTypeId INT, FormSectionId INT, EntityId INT, Constraints NVARCHAR(MAX) AS JSON, LanguageId INT,  IsPromoted BIT);        
        
		  
      SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1        
            FROM service.FormSectionFields        
            WHERE FormSectionId =        
            (        
                SELECT FormSectionId        
                FROM #tempEntityField        
                WHERE LanguageId = @enlanguageid        
            )        
            ORDER BY OrderNumber DESC;        
             
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
                  INSERT(Name,         
                         FieldTypeId,         
                         EntityId,         
                         IsPromoted)        
                  VALUES        
            (Name,         
             FieldTypeId,         
             EntityId,         
             IsPromoted        
            );        
        
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
                  INSERT(TranslationKeyId,         
                         LanguageId,         
                         ItemId,         
                         Value)        
                  VALUES        
            (@translationkeyid,         
             LanguageId,         
             @entityFieldid,         
             SOURCE.Name        
            );        
  
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
                  INSERT(FormSectionId,         
                         OrderNumber,         
                         EntityFieldId)        
                  VALUES        
            (FormSectionId,         
             @ordernumber,         
             @entityFieldId        
            );        
            SET @formsectionfieldid = ISNULL(@formsectionfieldid, SCOPE_IDENTITY());        
        
            -- Constraint ADD   
   IF EXISTS(Select Constraints From #tempEntityField)  
  BEGIN  
  SET @constraintsettings = (Select Constraints From #tempEntityField Where LanguageId = @enlanguageid)
   CREATE TABLE #tempFormFieldConstraints(  
   ConstraintTypeId INT,  
   ConstraintName NVARCHAR(100),  
   Settings NVARCHAR(4000)  
   )   
   SELECT ConstraintTypeId,  
   ConstraintName,  
   Settings       
                   FROM OPENJSON(@constraintsettings) WITH(ConstraintTypeId INT,  
   ConstraintName NVARCHAR(100),  
   Settings NVARCHAR(4000));             
               
    MERGE service.FormFieldConstraints AS TARGET        
            USING #tempFormFieldConstraints AS SOURCE        
            ON(TARGET.FormSectionFieldId = @formsectionfieldid        
               AND ISNULL(TARGET.FieldConstraintTypeId, 0) = SOURCE.ConstraintTypeId)        
                WHEN MATCHED         
                THEN UPDATE SET          
                                TARGET.FieldConstraintTypeId = SOURCE.ConstraintTypeId,    
        TARGET.Settings = SOURCE.Settings       
                WHEN NOT MATCHED BY TARGET         
                THEN        
                  INSERT(FormSectionFieldId,         
                         FieldConstraintTypeId,         
                         Settings)        
                  VALUES        
            (@formsectionfieldid,         
             CASE WHEN SOURCE.ConstraintTypeId = 0 THEN null ELSE SOURCE.ConstraintTypeId END,         
             SOURCE.Settings        
            );      
   END   
    --WHEN NOT MATCHED BY SOURCE AND TARGET.FormSectionFieldId = SOURCE.FormSectionFieldId      
    --                    THEN DELETE;        
        
        
            SELECT @entityFieldid AS Id,     
          @formsectionfieldid AS Name,        
                   200 AS STATUS,         
                   'Success' AS Message;        
            COMMIT TRANSACTION;        
        END TRY        
        BEGIN CATCH        
            SELECT @entityFieldid AS Id,     
          @formsectionfieldid AS Name,        
                   500 AS STATUS,         
                   ERROR_MESSAGE() AS Message;        
            ROLLBACK TRANSACTION;        
        END CATCH;        
    END;   