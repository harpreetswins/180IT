
/****** Object:  StoredProcedure [dbo].[sp_AddGroups]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddGroups] @Id     INT,     
                                      @Groups NVARCHAR(4000)    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
            DECLARE @GroupId INT;    
            DECLARE @LanguageId AS INT;    
            SET @LanguageId = 1;    
            DECLARE @ParentId AS INT;    
            DECLARE @OrderNo AS INT;    
            DECLARE @GroupTranslationKey AS INT = 14;    
            DECLARE @DescTranslationkey AS INT = 15;    
            --SELECT @DescTranslationkey = Id    
            --FROM system.TranslationKeys    
            --WHERE [Name] = 'Group Description';    
            --SELECT @GroupTranslationKey = Id    
            --FROM system.TranslationKeys    
            --WHERE [Name] = 'Groups';    
            CREATE TABLE #temp    
            (Name        NVARCHAR(100),     
             ParentId    INT,     
             OrderNumber INT,     
             LanguageId  INT,     
             Description NVARCHAR(400)    
            );    
            INSERT INTO #temp    
            (Name,     
             ParentId,     
             OrderNumber,     
             LanguageId,     
             Description    
            )    
                   SELECT GroupName,     
                          ParentGroupId,     
                          OrderNumber,     
                          LanguageId,     
                          [Description]    
                   FROM OPENJSON(@Groups) WITH(GroupName NVARCHAR(100), ParentGroupId INT, OrderNumber INT, LanguageId INT, [Description] NVARCHAR(400));    
            DECLARE @Name NVARCHAR(100);    
            DECLARE @Description NVARCHAR(400);    
            SELECT @Name = Name,     
                   @Description = Description,     
                   @ParentId = ParentId    
            FROM #temp    
            WHERE LanguageId = @LanguageId;    
            SET @OrderNo =    
            (    
                SELECT MAX(SG.OrderNumber) + 1    
                FROM service.Groups SG    
                WHERE SG.ParentId = @ParentId    
                      AND SG.IsDeleted = 0    
            );    
            IF EXISTS    
            (    
                SELECT 1    
                FROM service.Groups    
                WHERE Id = @Id    
            )    
                BEGIN    
                    UPDATE service.Groups    
                      SET     
                          Name = @Name,     
                          Description = @Description    
                    WHERE Id = @Id;    
            END;    
                ELSE    
                BEGIN    
                    IF(@ParentId IS NOT NULL)    
                        BEGIN    
                            IF(@OrderNo IS NULL)    
                                BEGIN    
                                    INSERT INTO service.Groups    
                                    (Name,     
                                     ParentId,     
                                     OrderNumber,     
                                     Description    
                                    )    
                                           SELECT Name,     
                                                  ParentId,     
                                                  0,     
                                                  T.Description    
                                           FROM #temp T    
                                           WHERE T.LanguageId = @LanguageId;    
                                    SET @GroupId = SCOPE_IDENTITY();    
                            END;    
                                ELSE    
                                BEGIN    
                                    INSERT INTO service.Groups    
                                    (Name,     
                       ParentId,     
                                     OrderNumber,     
                                     Description    
                                    )    
                           SELECT Name,     
                                                  ParentId,     
                                                  @OrderNo,     
                                                  T.Description    
                                           FROM #temp T    
                                           WHERE T.LanguageId = @LanguageId;    
                                    SET @GroupId = SCOPE_IDENTITY();    
                            END;    
                    END;    
                        ELSE    
                        BEGIN    
                            INSERT INTO service.Groups    
                            (Name,     
                             ParentId,     
                             OrderNumber,     
                             Description    
                            )    
                                   SELECT Name,     
                                          ParentId,     
                                   (    
                                       SELECT MAX(SG.OrderNumber) + 1    
                                       FROM service.Groups SG    
                                       WHERE SG.IsDeleted = 0    
                                   ),     
                                          T.Description    
                                   FROM #temp T    
                                   WHERE T.LanguageId = @LanguageId;    
                            SET @GroupId = SCOPE_IDENTITY();    
                    END;    
            END;    
            IF @GroupId > 0    
                BEGIN    
                    INSERT INTO service.Translations    
                    (TranslationKeyId,     
                     LanguageId,     
                     ItemId,     
                     Value    
                    )    
                           SELECT @GroupTranslationKey,     
                                  T.LanguageId,     
                                  @GroupId,     
                                  T.Name    
                           FROM #Temp T;    
                    INSERT INTO service.Translations    
                    (TranslationKeyId,     
                     LanguageId,     
                     ItemId,     
                     Value    
                    )    
                           SELECT @DescTranslationkey,     
                                  T.LanguageId,     
                                  @GroupId,     
                                  T.Description    
                           FROM #Temp T;    
                    SELECT @GroupId AS Id,  
     (Select OrderNumber from service.Groups Where id = @GroupId)  AS OrderNumber,   
                           200 AS STATUS,     
                           'Success' AS Message;    
            END;    
            IF EXISTS    
            (    
                SELECT 1    
                FROM service.Groups    
                WHERE Id = @Id    
            )    
                BEGIN    
                    UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.Description    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                    WHERE t.ItemId = @Id    
                          AND t.TranslationKeyId = @DescTranslationkey;   
                    --(    
                    --    SELECT Id    
                    --    FROM system.Translationkeys    
                    --    WHERE [Name] = 'Group Description'    
                    --);    
                    UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.Name    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                    WHERE t.ItemId = @Id    
                          AND t.TranslationKeyId =  @GroupTranslationKey;
                    --(    
                    --    SELECT Id    
                    --    FROM system.Translationkeys    
                    --    WHERE [Name] = 'Groups'    
                    --);    
                    SELECT @Id AS Id,   
     (Select OrderNumber from service.Groups Where id = @Id)  AS OrderNumber,    
                           200 AS STATUS,     
                           'Success' AS Message;    
           END;    
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            SELECT @GroupId AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
            ROLLBACK TRANSACTION;    
        END CATCH;    
    END;
GO