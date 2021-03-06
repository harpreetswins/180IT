
/****** Object:  StoredProcedure [dbo].[sp_ExecuteActions]    Script Date: 25-01-2021 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_ExecuteActions] @applicationId INT,   
                                           @stageActionId INT,   
                                           @userId        NVARCHAR(100),   
                                           @data          NVARCHAR(4000)  
AS  
    BEGIN  
  
        -- Get userid from sp_GetUserId function by passing user authenticated token                  
        DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @userId;  
  
        -- Declaration of stage, service, status, parentid, entityfield id's and main, child json variables                  
        DECLARE @stageid AS INT, @serviceid AS INT, @statusId AS INT, @stagestatusid AS INT, @openstagestatusid AS INT= 1, @closestagestatusid AS INT= 2, @submitstageactiontypeid AS INT= 2, @parentId AS INT, @entityFieldId AS INT, @value AS NVARCHAR(1000)
, @childrensJson AS NVARCHAR(MAX), @applicationstageid AS INT, @nextstageavailability AS BIT= 0;  
  
        -- Initialize values in declared variables                  
        SELECT TOP 1 @applicationstageid = AAS.Id,   
                     @stageid = AAS.StageId,   
                     @serviceid = AAA.ServiceId,   
                     @statusId = AAS.StageStatusId  
        FROM application.ApplicationStages AAS  
             INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId  
        WHERE AAS.ApplicationId = @applicationId  
        ORDER BY AAS.Id DESC;  
        IF EXISTS  
        (  
            SELECT 1  
            FROM service.StageActions  
            WHERE Id = @stageActionId  
                  AND ToStageID <> @stageid  
                  AND ToStageID IS NOT NULL  
        )  
            BEGIN  
                SET @nextstageavailability = 1;  
        END;  
  
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
                            SET @parentId = SCOPE_IDENTITY();  
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
                     [Data]  
                    )  
                    VALUES  
                    (  
                    (  
                        SELECT TOP 1 Id  
                        FROM application.ApplicationStages  
                        WHERE ApplicationId = @applicationid  
                              AND StageStatusId = @openstagestatusid  
                        ORDER BY 1 DESC  
                    ),   
                    @stageActionId,   
                    GETDATE(),   
                    @uId,   
                    @data  
                    );  
  
                    -- Updation of application stage and its status based on action type                  
                    IF EXISTS  
                    (  
                        SELECT TOP 1 1  
                        FROM application.ApplicationStages AAS  
                        WHERE ApplicationId = @applicationid  
                                AND AAS.StageStatusId = @openstagestatusid  
                        ORDER BY AAS.Id DESC  
                    )  
                        BEGIN  
                            UPDATE AAS2  
                                SET   
                                    AAS2.StageStatusId = @closestagestatusid  
                            FROM application.ApplicationStages AAS2  
                            WHERE AAS2.ApplicationId = @applicationId  
                                    AND AAS2.StageStatusId = @openstagestatusid  
                                    AND AAS2.Id = @applicationstageid;  
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
                                                        @openstagestatusid AS StageStatusId,   
                                                        StageId AS PreviousStageId  
                                            FROM application.ApplicationStages  
                                            WHERE ApplicationId = @applicationId  
                                            ORDER BY ID DESC;  
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