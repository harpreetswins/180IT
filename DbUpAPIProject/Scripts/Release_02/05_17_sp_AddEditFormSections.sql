
/****** Object:  StoredProcedure [admin].[sp_AddEditFormSections]    Script Date: 03-02-2021 15:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [admin].[sp_AddEditFormSections] @Id      INT,     
                                       @FormSection NVARCHAR(4000)    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
      DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @formsectionid AS INT, @translationkeyid AS INT= 3, @ordernumber AS INT= 0;          
   SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1      
                    FROM service.FormSections      
                    WHERE Id = @Id      
                    ORDER BY FormId DESC;   
            CREATE TABLE #tempformsection    
            (Id INT,     
             Name NVARCHAR(200),     
             FormId INT,    
			 Settings NVARCHAR(MAX),  
			 LanguageId INT    
            );    
            INSERT INTO #tempformsection    
            (Id,     
             Name,     
             FormId,     
			 Settings,  
			 LanguageId    
            )    
                   SELECT Id,     
             Name,     
             FormId,     
			 Settings,  
			 LanguageId    
                   FROM OPENJSON(@FormSection) WITH(Id INT,     
             Name NVARCHAR(200),     
             FormId INT,  
			 Settings NVARCHAR(MAX),  
			 LanguageId INT );   
  
  
   MERGE service.FormSections AS TARGET      
            USING #tempformsection AS SOURCE      
            ON(TARGET.Id = SOURCE.Id)      
                WHEN MATCHED --AND TARGET.Name <> SOURCE.Name      
                                 AND SOURCE.LanguageId = @enlanguageid      --TARGET.EntityId <> SOURCE.EntityId OR        
                THEN UPDATE SET       
                                @formsectionid = TARGET.Id,       
                                TARGET.Name = SOURCE.Name,       
                                TARGET.FormId = SOURCE.FormId      
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid      
                THEN      
                  INSERT(Name,       
                         FormId,  
						 OrderNumber)      
                  VALUES      
            (Name,       
             FormId,  
			 @ordernumber     
            );      
            SET @formsectionid = ISNULL(@formsectionid, SCOPE_IDENTITY());      
            MERGE service.Translations AS TARGET      
            USING #tempformsection AS SOURCE      
            ON(TARGET.ItemId = @formsectionid     
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
             @formsectionid,     
             SOURCE.Name      
            );    
        SELECT @formsectionid AS Id,  
                           200 AS STATUS,     
                           'Success' AS Message;    
              
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            SELECT @formsectionid AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
            ROLLBACK TRANSACTION;    
        END CATCH;    
    END;