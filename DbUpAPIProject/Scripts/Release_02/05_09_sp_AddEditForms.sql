
/****** Object:  StoredProcedure [dbo].[sp_AddEditForms]    Script Date: 29-01-2021 18:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddEditForms] @stageid INT,   
                                         @forms   NVARCHAR(4000)  
AS  
    BEGIN  
        DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @formid AS INT, @translationkeyid AS INT= 2, @ordernumber AS INT= 0;  
        BEGIN TRY  
            BEGIN TRAN;  
            CREATE TABLE #tempForms  
            (FormId     INT,   
             Name       NVARCHAR(100),   
             LanguageId INT,   
             EntityId   INT  
            );  
            INSERT INTO #tempForms  
            (FormId,   
             Name,   
             LanguageId,   
             EntityId  
            )  
                   SELECT FormId,   
                          Name,   
                          LanguageId,   
                          EntityId  
                   FROM OPENJSON(@forms) WITH(FormId INT, Name NVARCHAR(100), LanguageId INT, EntityId INT);           
            -- select * from #tempForms        
            MERGE service.Forms AS TARGET  
            USING #tempForms AS SOURCE  
            ON(TARGET.Id = SOURCE.FormId)  
                WHEN MATCHED --AND TARGET.Name <> SOURCE.Name  
                                 AND SOURCE.LanguageId = @enlanguageid      --TARGET.EntityId <> SOURCE.EntityId OR    
                THEN UPDATE SET   
                                @formid = TARGET.Id,   
                                TARGET.Name = SOURCE.Name,   
                                TARGET.EntityId = SOURCE.EntityId  
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid  
                THEN  
                  INSERT(Name,   
                         EntityId)  
                  VALUES  
            (Name,   
             EntityId  
            );  
            SET @formid = ISNULL(@formid, SCOPE_IDENTITY());  
            MERGE service.Translations AS TARGET  
            USING #tempForms AS SOURCE  
            ON(TARGET.ItemId = SOURCE.FormId  
               AND TARGET.LanguageId = SOURCE.LanguageId  
               AND TARGET.TranslationKeyId = @translationkeyid)  
                WHEN MATCHED AND TARGET.Value <> SOURCE.Name  
                THEN UPDATE SET   
                                TARGET.Value = SOURCE.Name  
                WHEN NOT MATCHED BY TARGET  
                THEN  
                  INSERT(TranslationKeyId,   
                         ItemId,   
                         LanguageId,   
                         Value)  
                  VALUES  
            (@translationkeyid,   
             @formid,   
             LanguageId,   
             Name  
            );  
            IF(ISNULL(@stageid, 0) > 0)  
                BEGIN  
                    SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1  
                    FROM service.StageForms  
                    WHERE StageId = @stageid  
                    ORDER BY FormId DESC;  
                    IF(  
                    (  
                        SELECT ISNULL(FormId, 0)  
                        FROM #tempForms  
                        WHERE Languageid = @enlanguageid  
                    ) < 1)  
                        BEGIN  
                            INSERT INTO service.StageForms  
                            (StageId,   
                             FormId,   
                             OrderNumber  
                            )  
                            VALUES  
                            (@stageid,   
                             @formid,   
                             @ordernumber  
                            );  
                    END;  
            END;  
            SELECT @formid AS Id,   
                   200 AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @formid AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END;