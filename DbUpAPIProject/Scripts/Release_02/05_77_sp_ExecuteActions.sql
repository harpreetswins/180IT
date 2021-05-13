ALTER PROCEDURE [dbo].[sp_ExecuteActions] @applicationId INT, 
                                           @stageActionId INT, 
                                           @userId        NVARCHAR(100), 
                                           @data          NVARCHAR(MAX), 
                                           @comments      NVARCHAR(400), 
                                           @creatorName   NVARCHAR(100), 
                                           @users         NVARCHAR(4000)
AS
    BEGIN

        -- Get userid from sp_GetUserId function by passing user authenticated token                                  
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @userId, 
             @creatorName;

        -- Declaration of stage, service, status, parentid, entityfield id's and main, child json variables                                  
        DECLARE @stageid AS INT, @serviceid AS INT, @statusId AS INT, @stagestatusid AS INT, @parentId AS INT, @entityFieldId AS INT, @value AS NVARCHAR(1000), @childrensJson AS NVARCHAR(MAX), @applicationstageid AS INT, @nextstageavailability AS BIT= 0, @appStageActionId INT, @attachmentActionId INT, @attachmentAppStageId INT, @actiontypeid INT, @TostageId BIT= 0, @applicationstatusid INT;

        -- Declaration of lookups    
        DECLARE @openstagestatusid AS INT= 1, @closestagestatusid AS INT= 2, @submitstageactiontypeid AS INT= 2, @rejectactiontypeid AS INT= 5, @returnactiontypeid AS INT= 6, @modificationstagestatusid AS INT= 5, @returnstagestatusid AS INT= 4, @rejectedstagestatusid AS INT= 3, @assigntouseractiontypeid AS INT= 8, @newstagestatusid AS INT;
        SELECT @actiontypeid = ActionTypeId
        FROM service.StageActions
        WHERE Id = @stageActionId;
        SELECT @attachmentAppStageId = AppStageId, 
               @attachmentActionId = ActionTypeId
        FROM application.ActionAttachments
        WHERE AppId = @applicationId;

        -- Initialize values in declared variables                                  
        SELECT TOP 1 @applicationstageid = AAS.Id, 
                     @stageid = AAS.StageId, 
                     @serviceid = AAA.ServiceId, 
                     @statusId = AAS.StageStatusId
        FROM vw_ApplicationStagesOrderBy AAS
             INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId
        WHERE AAS.ApplicationId = @applicationId;
        SET @nextstageavailability =
        (
            SELECT dbo.fn_appNextStageAvailability(@stageActionId, @stageid)
        );
        SET @TostageId =
        (
            SELECT dbo.fn_appToStageExists(@stageActionId, @stageid)
        );

        --CREATE temporary tablewith existence check                                  
        DROP TABLE IF EXISTS #temp;
        CREATE TABLE #temp
        (entityFieldId INT, 
         value         NVARCHAR(1000), 
         childrens     NVARCHAR(MAX)
        );
        BEGIN TRY
            BEGIN TRAN;
            IF(@statusId <> @closestagestatusid)
                BEGIN
                    INSERT INTO #temp
                    (entityFieldId, 
                     value, 
                     childrens
                    )
                           SELECT entityFieldId, 
                                  value, 
                                  childrens
                           FROM OPENJSON(@data) WITH(entityFieldId INT, value NVARCHAR(1000), childrens NVARCHAR(MAX) AS JSON);

                    -- Add update table Application Field Values data                  
                    MERGE application.ApplicationFieldValues AS TARGET
                    USING #temp AS SOURCE
                    ON(TARGET.EntityFieldId = SOURCE.entityFieldId
                       AND TARGET.ApplicationId = @applicationid)
                        WHEN MATCHED AND SOURCE.childrens IS NULL
                                         AND TARGET.Value <> SOURCE.value
                        THEN UPDATE SET 
                                        TARGET.Value = SOURCE.value
                        WHEN NOT MATCHED BY TARGET AND SOURCE.childrens IS NULL
                        THEN
                          INSERT([ApplicationId], 
                                 [EntityFieldId], 
                                 [Value], 
                                 [ParentId], 
                                 [ItemIndex])
                          VALUES
                    (@applicationId, 
                     entityFieldId, 
                     value, 
                     NULL, 
                     0
                    );
                    DECLARE @childTemp TABLE
                    ([ApplicationId] INT, 
                     [EntityFieldId] INT, 
                     [Value]         NVARCHAR(1000), 
                     [ParentId]      INT, 
                     [itemIndex]     INT
                    );

                    -- DECLARE THE CURSOR FOR A QUERY.                                        
                    DECLARE reference_form_cursor CURSOR READ_ONLY
                    FOR SELECT entityFieldId, 
                               value, 
                               childrens
                        FROM #temp
                        WHERE childrens IS NOT NULL;

                    --OPEN CURSOR.                                        
                    OPEN reference_form_cursor;

                    --FETCH THE RECORD INTO THE VARIABLES.                                        
                    FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;

                    --LOOP UNTIL RECORDS ARE AVAILABLE.                                       
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            INSERT INTO application.ApplicationFieldValues
                            ([ApplicationId], 
                             [EntityFieldId], 
                             [Value], 
                             [ParentId]
                            )
                                   SELECT @applicationId, 
                                          @entityFieldId, 
                                          @value, 
                                          NULL
                                   FROM #temp
                                   WHERE childrens IS NOT NULL;          
                            --Select @parentId          

                            SET @parentId = SCOPE_IDENTITY();
                            INSERT INTO @childTemp
                            ([ApplicationId], 
                             [EntityFieldId], 
                             [Value], 
                             [ParentId], 
                             [itemIndex]
                            )
                                   SELECT @applicationId, 
                                          entityFieldId, 
                                          value, 
                                          @parentId, 
                                          itemIndex
                                   FROM OPENJSON(@childrensJson) WITH(entityFieldId INT, value NVARCHAR(1000), itemIndex INT);
                            INSERT INTO application.ApplicationFieldValues
                            ([ApplicationId], 
                             [EntityFieldId], 
                             [Value], 
                             [ParentId], 
                             [itemIndex]
                            )
                                   SELECT @applicationId, 
                                          entityFieldId, 
                                          value, 
                                          @parentId, 
                                          itemIndex
                                   FROM OPENJSON(@childrensJson) WITH(entityFieldId INT, value NVARCHAR(1000), itemIndex INT);                  
                            --FETCH THE NEXT RECORD INTO THE VARIABLES.                                        
                            FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;
            END;

                    --CLOSE THE CURSOR.                                        
                    CLOSE reference_form_cursor;
                    DEALLOCATE reference_form_cursor;

                    -- testing purpose end                        
                    -- Add data to application stage action table in respect to performed action..                            

                    INSERT INTO application.ApplicationStageActions
                    ([ApplicationStageId], 
                     [StageActionId], 
                     [CreatedOn], 
                     [UserId], 
                     [Data], 
                     [Comments]
                    )
                    VALUES
                    (
                    (
                        SELECT TOP 1 Id
                        FROM vw_ApplicationStagesOrderBy
                        WHERE ApplicationId = @applicationid
                              AND StageStatusId = @openstagestatusid
                    ), 
                    @stageActionId, 
                    GETDATE(), 
                    @uId, 
                    @data, 
                    @comments
                    );
                    SET @appStageActionId = SCOPE_IDENTITY();
                    IF(
                    (
                        SELECT ActionTypeId
                        FROM service.StageActions
                        WHERE Id = @stageactionid
                    ) = @assigntouseractiontypeid)
                        BEGIN
                            DECLARE @tempUser TABLE(UserId NVARCHAR(500));
                            INSERT INTO @tempUser(UserId)
                                   SELECT Item
                                   FROM SplitString(@users, ',');
                            INSERT INTO application.ActionAssignedUsers
                            ([ApplicationStageActionId], 
                             [UserId]
                            )
                                   SELECT @appStageActionId, 
                                          AU.Id
                                   FROM @tempUser temp
                                        INNER JOIN application.Users AU ON AU.ExternalId = temp.UserId;
                    END;
                    IF(@stageid = @attachmentAppStageId
                       AND @actiontypeid = @attachmentActionId)
                        BEGIN
                            UPDATE application.ActionAttachments
                              SET 
                                  AppStageActionId = @appStageActionId
                            WHERE AppStageId = @attachmentAppStageId
                                  AND ActionTypeId = @attachmentActionId;
                    END;

                    -- Updation of application stage and its status based on action type                                  
                    IF EXISTS
                    (
                        SELECT TOP 1 1
                        FROM vw_ApplicationStagesOrderBy AAS
                        WHERE ApplicationId = @applicationid
                              AND AAS.StageStatusId = @openstagestatusid
                    )
                        BEGIN
                            IF(@TostageId = 1)
                                BEGIN
                                    SELECT @applicationstatusid = (CASE
                                                                       WHEN SSA11.ActionTypeId = @rejectactiontypeid
                                                                       THEN @rejectedstagestatusid
                                                                       WHEN SSA11.ActionTypeId = @returnactiontypeid
                                                                       THEN @returnstagestatusid
                                                                       ELSE @closestagestatusid
                                                                   END), 
                                           @newstagestatusid = (CASE
                                                                    WHEN SSA11.ActionTypeId = @returnactiontypeid
                                                                    THEN @modificationstagestatusid
                                                                    ELSE @openstagestatusid
                                                                END)
                                    FROM service.StageActions SSA11
                                         INNER JOIN lookups.ActionTypes LAT ON LAT.Id = SSA11.ActionTypeId
                                    WHERE SSA11.Id = @stageActionId;
                                    UPDATE AAS2
                                      SET 
                                          AAS2.StageStatusId = @applicationstatusid
                                    FROM application.ApplicationStages AAS2
                                    WHERE AAS2.ApplicationId = @applicationId
                                          AND AAS2.StageStatusId = @openstagestatusid
                                          AND AAS2.Id = @applicationstageid;
                            END;
                            IF(@nextstageavailability = 1)
                                BEGIN
                                    INSERT INTO application.ApplicationStages
                                    ([ApplicationId], 
                                     [UserId], 
                                     [StageId], 
                                     [CreatedOn], 
                                     [StageStatusId], 
                                     [PreviousStageId]
                                    )
                                           SELECT TOP 1 ApplicationId, 
                                                        UserId, 
                                           (
                                               SELECT ToStageId
                                               FROM service.StageActions
                                               WHERE Id = @stageActionId
                                                     AND ToStageID <> @stageid
                                                     AND ToStageID IS NOT NULL
                                           ) AS StageId, 
                                                        GETDATE() AS CreatedOn, 
                                                        @newstagestatusid AS StageStatusId, 
                                                        StageId AS PreviousStageId
                                           FROM vw_ApplicationStagesOrderBy
                                           WHERE ApplicationId = @applicationId;
                            END;
                    END;
                    SELECT @stageActionId AS Id, 
                           200 AS STATUS, 
                           'Success' AS SuccessMessage;
            END;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @stageActionId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END;