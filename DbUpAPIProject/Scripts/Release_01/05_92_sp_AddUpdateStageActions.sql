
/****** Object:  StoredProcedure [dbo].[sp_AddUpdateStageActions]    Script Date: 28-01-2021 19:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                                
-- Author:  Neeraj Saini                                
-- Create date: 14 Jan,2021                                
-- Description: create stage actions with translations.       
-- =============================================                                
ALTER PROCEDURE [dbo].[sp_AddUpdateStageActions] @stageid       INT, 
                                                 @stageactionid INT, 
                                                 @stageaction   NVARCHAR(4000)
AS
    BEGIN

        -- Declare variable for order number                  
        DECLARE @ordernumber AS INT= 0, @enLanguageId INT= 1, @arLanguageId INT= 2, @stageActionTranslationKeyId INT= 7, @stageactionroles AS NVARCHAR(4000);
        BEGIN TRY
            BEGIN TRAN;

            -- Create temporary stage actions                   
            CREATE TABLE #tempStages
            (StageActionName    NVARCHAR(100), 
             ActionTypeId       INT, 
             StageId            INT, 
             DestinationStageId INT, 
             LanguageId         INT, 
             [Description]      NVARCHAR(400), 
             Roles              NVARCHAR(1000)
            );
            INSERT INTO #tempStages
            (StageActionName, 
             ActionTypeId, 
             StageId, 
             DestinationStageId, 
             LanguageId, 
             [Description], 
             Roles
            )
                   SELECT StageActionName, 
                          ActionTypeId, 
                          StageId,
                          CASE
                              WHEN DestinationStageId = 0
                              THEN NULL
                              ELSE DestinationStageId
                          END, 
                          LanguageId, 
                          [Description], 
                          Roles
                   FROM OPENJSON(@stageaction) WITH(StageActionName NVARCHAR(100), ActionTypeId INT, StageId INT, DestinationStageId INT, LanguageId INT, [Description] NVARCHAR(400), Roles NVARCHAR(1000));

            -- Initialize greatest order number if stage action type already exists for this stage                  
            SET @ordernumber = ISNULL(
            (
                SELECT TOP 1 OrderNumber
                FROM service.StageActions
                WHERE StageId = @stageid
                ORDER BY OrderNumber DESC
            ), 0);

            -- Case :- create new stage action                  
            IF(@stageactionid < 1)
                BEGIN
                    INSERT INTO service.StageActions
                    ([Name], 
                     ActionTypeId, 
                     OrderNumber, 
                     StageId, 
                     ToStageId
                    )
                           SELECT StageActionName, 
                                  ActionTypeId, 
                                  @ordernumber + 1, 
                                  StageId, 
                                  DestinationStageId
                           FROM #tempStages
                           WHERE LanguageId = @enLanguageId;
                    SET @stageactionid = SCOPE_IDENTITY();
                    INSERT INTO service.Translations
                    (TranslationKeyId, 
                     LanguageId, 
                     ItemId, 
                     Value
                    )
                           SELECT @stageActionTranslationKeyId, 
                                  tempSt.LanguageId, 
                                  @stageactionid, 
                                  tempSt.StageActionName
                           FROM #tempStages tempSt
                           WHERE tempSt.LanguageId = @enLanguageId;
                    INSERT INTO service.Translations
                    (TranslationKeyId, 
                     LanguageId, 
                     ItemId, 
                     Value
                    )
                           SELECT @stageActionTranslationKeyId, 
                                  tempS.LanguageId, 
                                  @stageactionid, 
                                  tempS.StageActionName
                           FROM #tempStages tempS
                           WHERE tempS.LanguageId = @arLanguageId;
                    SELECT @stageactionid AS Id, 
                           200 AS STATUS, 
                           'Success' AS Message;
            END;
                ELSE
                BEGIN

                    -- Case :  update case for existing stage action                  
                    UPDATE [service].[StageActions]
                      SET 
                          [Name] = temp.StageActionName, 
                          ActionTypeId = temp.ActionTypeId, 
                          StageId = temp.StageId, 
                          ToStageID = temp.DestinationStageId
                    FROM #tempStages temp
                    WHERE [service].[StageActions].Id = @stageactionid
                          AND temp.LanguageId = @enLanguageId;
                    UPDATE service.Translations
                      SET 
                          service.Translations.Value = te.StageActionName
                    FROM service.Translations t
                         INNER JOIN #tempStages te ON te.LanguageId = t.LanguageId
                    WHERE t.ItemId = @stageactionid
                          AND t.TranslationKeyId = @stageActionTranslationKeyId
                          AND t.LanguageId = te.LanguageId;
            END;
            SELECT TOP 1 @stageactionroles = t.Roles
            FROM #tempStages t
            WHERE t.LanguageId = @enLanguageId;
            DECLARE @Target_Table TABLE
            (RoleId        INT, 
             StageActionId INT
            );
            INSERT INTO @Target_Table
                   SELECT value, 
                          @stageactionid
                   FROM STRING_SPLIT(@stageactionroles, ',');
            IF EXISTS
            (
                SELECT 1
                FROM @Target_Table SAR
                WHERE SAR.RoleId IS NOT NULL
            )
                BEGIN
                    IF EXISTS
                    (
                        SELECT 1
                        FROM service.StageActionRoles
                        WHERE StageActionId = @stageactionid
                    )
                        BEGIN
                            DELETE FROM service.StageActionRoles
                            WHERE StageActionId = @stageactionid
                                  AND RoleId NOT IN
                            (
                                SELECT RoleId
                                FROM @Target_Table
                            );
                            INSERT INTO service.StageActionRoles
                            (StageActionId, 
                             RoleId
                            )
                                   SELECT StageActionId, 
                                          RoleId
                                   FROM @Target_Table
                                   WHERE RoleId NOT IN
                                   (
                                       SELECT RoleId
                                       FROM service.StageActionRoles
                                       WHERE StageActionId = @stageactionid
                                   );
                    END;
                        ELSE
                        BEGIN
                            INSERT INTO service.StageActionRoles
                            (StageActionId, 
                             RoleId
                            )
                                   SELECT StageActionId, 
                                          RoleId
                                   FROM @Target_Table;
                    END;
            END;

            /* END OF MERGE */

            -- Return status, message and stageactionid                  
            SELECT @stageactionid AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @stageactionid AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
        END CATCH;
    END;