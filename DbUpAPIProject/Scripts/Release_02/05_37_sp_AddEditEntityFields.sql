
/****** Object:  StoredProcedure [admin].[AddEditEntityFields]    Script Date: 04-02-2021 15:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [admin].[sp_AddEditEntityFields] @id INT,
											   @entityFields NVARCHAR(4000)
AS
BEGIN

	BEGIN TRY
		BEGIN TRAN

		DECLARE @enlanguageid AS INT = 1, @aralanguageid AS INT = 2, @entityFieldid AS INT, @translationkeyid AS INT = 1, @ordernumber AS INT= 0;   
		
		CREATE TABLE #tempEntityField
		(Id INT,
		Name NVARCHAR(200),
		FieldTypeId INT,
		FormSectionId INT,
		EntityId INT,
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
		LanguageId,
		Settings,
		IsPromoted
		)
		SELECT Id,
		Name,
		FieldTypeId,
		FormSectionId,
		EntityId,
		LanguageId,
		Settings,
		IsPromoted FROM OPENJSON(@entityFields) WITH(Id INT,Name NVARCHAR(200),FieldTypeId INT,FormSectionId INT,EntityId INT,LanguageId INT,Settings NVARCHAR(MAX),IsPromoted BIT);

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
								TARGET.OrderNumber = @ordernumber,
								TARGET.EntityFieldId = @entityFieldid 
								
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid
                THEN      
                  INSERT(FormSectionId, OrderNumber, EntityFieldId)      
                  VALUES(FormSectionId, @ordernumber, @entityFieldId);  
				
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
