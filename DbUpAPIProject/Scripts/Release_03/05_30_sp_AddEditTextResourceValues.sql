ALTER PROCEDURE [admin].[sp_AddEditTextResourceValues] @category VARCHAR(200), 
                                                        @key      VARCHAR(200), 
                                                        @values   NVARCHAR(MAX)
AS
    BEGIN
        DECLARE @textResourceCategoryId INT, @textResourceKeyId INT, @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @resultresponse NVARCHAR(4000);
        BEGIN TRY
            BEGIN TRAN;
            CREATE TABLE #temp
            (Id         INT, 
             LanguageId INT, 
             Value      NVARCHAR(500)
            );
            INSERT INTO #temp
            (Id, 
             LanguageId, 
             Value
            )
                   SELECT Id, 
                          LanguageId, 
                          Value
                   FROM OPENJSON(@values) WITH(Id INT, LanguageId INT, Value NVARCHAR(500));
           
		    IF EXISTS
            (
                SELECT 1
                FROM [system].[TextResourcesCategories]
                WHERE TextResourceCategoryName = @category
            )
                BEGIN
                    SET @textResourceCategoryId =
                    (
                        SELECT Id
                        FROM [system].[TextResourcesCategories]
                        WHERE TextResourceCategoryName = @category
                    );
            END;
                ELSE
                BEGIN
                    INSERT INTO [system].[TextResourcesCategories](TextResourceCategoryName)
                VALUES(@category);
                    SET @textResourceCategoryId = SCOPE_IDENTITY();
            END;
          
		    IF EXISTS
            (
                SELECT 1
                FROM [system].[TextResourcesKeys]
                WHERE TextResourcesKeyName = @key
                      AND TextResourceCategoryId = @textResourceCategoryId
            )
                BEGIN
                    SET @textResourceKeyId =
                    (
                        SELECT Id
                        FROM [system].[TextResourcesKeys]
                        WHERE TextResourcesKeyName = @key
                              AND TextResourceCategoryId = @textResourceCategoryId
                    );
            END;
                ELSE
                BEGIN
                    INSERT INTO [system].[TextResourcesKeys]
                    (TextResourcesKeyName, 
                     TextResourceCategoryId
                    )
                    VALUES
                    (@key, 
                     @textResourceCategoryId
                    );
                    SET @textResourceKeyId = SCOPE_IDENTITY();
            END;
          
		  
		    MERGE [system].[TextResourceValues] AS TARGET
            USING #temp AS SOURCE
            ON(TARGET.TextResourcesKeyId = @textResourceKeyId
               AND TARGET.LanguageId = SOURCE.LanguageId)
                WHEN MATCHED AND TARGET.Value <> SOURCE.Value
                THEN UPDATE SET 
                                TARGET.Value = SOURCE.Value
                WHEN NOT MATCHED BY TARGET
                THEN
                  INSERT(TextResourcesKeyId, 
                         LanguageId, 
                         Value)
                  VALUES
            (@textResourceKeyId, 
             SOURCE.LanguageId, 
             SOURCE.Value
            );
            SELECT @textResourceCategoryId AS Id, 
            (
                SELECT Id, 
                       LanguageId, 
                       Value
                FROM [system].[TextResourceValues]
                WHERE VALUE IN
                (
                    SELECT Value
                    FROM #temp
                ) FOR JSON PATH
            ) AS NAME, 
                   200 AS STATUS, 
                   'Success' AS SuccessMessage;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @textResourceCategoryId AS Id, 
                   NULL AS Name, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END;