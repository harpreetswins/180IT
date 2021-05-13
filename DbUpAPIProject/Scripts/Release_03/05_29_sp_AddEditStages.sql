
ALTER PROCEDURE [admin].[sp_AddEditStages] @serviceid INT, 
                                           @stages    NVARCHAR(4000)
AS
    BEGIN
        DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @stageid AS INT, @translationkeyid AS INT= 12, @ordernumber AS INT= 0;
        BEGIN TRY
            BEGIN TRAN;
            CREATE TABLE #tempStages
            (StageId     INT, 
             Name        NVARCHAR(100), 
             LanguageId  INT, 
             StageTypeId INT
            );
            INSERT INTO #tempStages
            (StageId, 
             Name, 
             LanguageId, 
             StageTypeId
            )
                   SELECT StageId, 
                          Name, 
                          LanguageId, 
                          StageTypeId
                   FROM OPENJSON(@stages) WITH(StageId INT, Name NVARCHAR(100), LanguageId INT, StageTypeId INT);
                 

            SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1
            FROM service.Stages
            WHERE ServiceId = @serviceid
            ORDER BY OrderNumber DESC;

            MERGE service.Stages AS TARGET
            USING #tempStages AS SOURCE
            ON(TARGET.Id = SOURCE.StageId)
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid
                THEN UPDATE SET 
                                @stageid = TARGET.Id, 
                                TARGET.Name = SOURCE.Name, 
                                TARGET.StageTypeId = SOURCE.StageTypeId
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid
                THEN
                  INSERT(Name, 
                         OrderNumber, 
                         ServiceId, 
                         StageTypeId)
                  VALUES
            (Name, 
             @orderNumber, 
             @serviceId, 
             StageTypeId
            );

            SET @stageid = ISNULL(@stageid, SCOPE_IDENTITY());

            MERGE service.Translations AS TARGET
            USING #tempStages AS SOURCE
            ON(TARGET.ItemId = SOURCE.StageId
               AND TARGET.LanguageId = SOURCE.LanguageId
               AND TARGET.TranslationKeyId = @translationkeyid)
                WHEN MATCHED --AND TARGET.Value <> SOURCE.Name    
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
             @stageId, 
             LanguageId, 
             Name
            );

            SELECT @stageId AS Id, 
                   @ordernumber AS Name, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @stageId AS Id, 
                   @ordernumber AS Name, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
        END CATCH;
    END;