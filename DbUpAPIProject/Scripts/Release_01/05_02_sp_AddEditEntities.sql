
/****** Object:  StoredProcedure [dbo].[sp_AddEditEntities]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddEditEntities] @entities NVARCHAR(4000)      
AS      
    BEGIN      
 DECLARE @enlanguageid AS INT = 1, @aralanguageid AS INT = 2, @entityid AS INT, @translationkeyid AS INT = 17;  
 --Select @enlanguageid = id From system.Languages Where Name = 'English';  
 --Select @aralanguageid = id From system.Languages Where Name = 'Arabic';  
 --Select @translationkeyid = Id from system.TranslationKeys Where Name = 'Entity';  
          
  BEGIN TRY      
            BEGIN TRAN;      
                  
            CREATE TABLE #tempForms      
            (EntityId INT,  
   Name        NVARCHAR(100),    
    LanguageId INT   
            );      
            INSERT INTO #tempForms      
            (EntityId,  
   Name,  
    LanguageId  
         
            )      
                   SELECT EntityId,   
              Name,      
                          LanguageId      
                   FROM OPENJSON(@entities) WITH(EntityId INT, Name NVARCHAR(100), LanguageId INT);   
         
          MERGE service.Entities AS TARGET  
                            USING #tempForms AS SOURCE  
                            ON(TARGET.Id = SOURCE.EntityId)  
                                WHEN MATCHED AND TARGET.Name <> SOURCE.Name AND SOURCE.LanguageId = @enlanguageid  
                                THEN UPDATE SET    
                                                @entityid = TARGET.Id,  
                                                TARGET.Name = SOURCE.Name  
                                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid  
                                THEN  
                                  INSERT(  
       Name  
       )  
                                  VALUES  
                            (Name  
                            );  
       SET @entityid = ISNULL(@entityid, SCOPE_IDENTITY());  
  
        MERGE service.Translations AS TARGET  
                            USING #tempForms AS SOURCE  
                            ON(TARGET.ItemId = SOURCE.EntityId AND TARGET.LanguageId = SOURCE.LanguageId AND TARGET.TranslationKeyId = @translationkeyid)  
                                WHEN MATCHED AND TARGET.Value <> SOURCE.Name   
                                THEN UPDATE SET    
                                                TARGET.Value = SOURCE.Name  
                                WHEN NOT MATCHED BY TARGET   
                                THEN  
                                  INSERT(  
       TranslationKeyId,  
       ItemId,  
       LanguageId,  
       Value  
       )  
                                  VALUES  
                            (@translationkeyid,   
                             @entityId,  
        LanguageId,  
        Name  
                            );  
         SELECT @entityid AS Id,   
                           200 AS STATUS,   
                           'Success' AS SuccessMessage;  
              
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @entityid AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END
GO