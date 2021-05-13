
/****** Object:  StoredProcedure [dbo].[sp_ExecuteActions]    Script Date: 21-01-2021 18:39:41 ******/
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
        DECLARE @stageid AS INT, @serviceid AS INT, @statusId AS INT, @stagestatusid AS INT, @openstagestatusid AS INT = 1, @closestagestatusid AS INT = 2, @submitstageactiontypeid AS INT = 2, @parentId AS INT,
		 @entityFieldId AS INT, @value AS NVARCHAR(1000), @childrensJson AS NVARCHAR(MAX);  
  
        -- Initialize open and status from stage statuses into vaiables      
        --SELECT @openstagestatusid = Id  
        --FROM lookups.StageStatuses  
        --WHERE Name = 'Open';  
        --SELECT @closestagestatusid = Id  
        --FROM lookups.StageStatuses  
        --WHERE Name = 'Close';  
        --SELECT @submitstageactiontypeid = Id  
        --FROM lookups.ActionTypes  
        --WHERE Name = 'Submit';  
  
        -- Initialize values in declared variables              
        SELECT TOP 1 @stageid = AAS.StageId,   
                     @serviceid = AAA.ServiceId,   
                     @statusId = AAS.StageStatusId  
        FROM application.ApplicationStages AAS  
             INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId  
        WHERE ApplicationId = @applicationId  
        ORDER BY AAS.Id DESC;  
  
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
  
                    --                 --DECLARE THE CURSOR FOR A QUERY.                    
           --                 DECLARE reference_form_cursor CURSOR READ_ONLY      
                    --                 FOR SELECT entityFieldId,       
                    --                            value,       
                    --                            childrens      
                    --                  FROM #temp      
                    --                     WHERE childrens IS NOT NULL;      
                    --                 --OPEN CURSOR.                    
                    --                 OPEN reference_form_cursor;      
                    --                 --FETCH THE RECORD INTO THE VARIABLES.                    
                    --                 FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;      
                    --                 --LOOP UNTIL RECORDS ARE AVAILABLE.                   
                    --                 WHILE @@FETCH_STATUS = 0      
                    --                     BEGIN      
                    --            MERGE application.ApplicationFieldValues AS TARGET       
                    -- USING #temp AS SOURCE       
                    -- ON (TARGET.EntityFieldId = SOURCE.entityFieldId AND TARGET.ApplicationId = @applicationid)       
                    -- WHEN MATCHED AND SOURCE.childrens IS NOT NULL       
                    --      AND TARGET.Value <> SOURCE.value        
                    --THEN UPDATE       
                    --      SET       
                    -- @parentid = TARGET.Id,      
                    --TARGET.Value = SOURCE.value      
                    -- WHEN NOT MATCHED BY TARGET AND SOURCE.childrens IS NOT NULL       
                    -- THEN       
                    --                         INSERT       
                    --                         ([ApplicationId],       
                    --                          [EntityFieldId],       
                    --                          [Value],       
                    --                          [ParentId]      
                    --                         )      
                    --                                VALUES( @applicationId,       
                    --                                       @entityFieldId,       
                    --                                       @value,       
                    --                                       NULL);      
                    --                       SET @parentId = ISNULL(@parentId, SCOPE_IDENTITY());      
                    --     DROP TABLE IF EXISTS #temp;      
                    --     CREATE TABLE #tempChild      
                    --     ([ApplicationId] INT,       
                    --                          [EntityFieldId] INT,       
                    --                          [Value] NVARCHAR(1000),       
                    --                          [ParentId] INT,       
                    --                          [itemIndex] INT)      
                    --      INSERT INTO #tempChild      
                    --                         ([ApplicationId],       
                    --                          [EntityFieldId],       
                    --                          [Value],       
                    --                          [ParentId],       
                    --                          [itemIndex]      
                    --                         )      
                    --     SELECT @applicationId,       
                    --                                       entityFieldId,       
                    --                                       value,       
                    --                                       @parentId,       
                    --                                       itemIndex      
                    --                                FROM OPENJSON(@childrensJson) WITH(entityFieldId INT, value NVARCHAR(1000), itemIndex INT);      
                    --     MERGE application.ApplicationFieldValues AS TARGET       
                    -- USING #tempChild AS SOURCE       
                    -- ON (TARGET.EntityFieldId = SOURCE.entityFieldId AND TARGET.ApplicationId = @applicationid AND TARGET.ParentId = @parentid)       
                    -- WHEN MATCHED        
                    --      AND TARGET.Value <> SOURCE.value        
                    --THEN UPDATE       
                    --      SET TARGET.Value = SOURCE.value      
                    -- WHEN NOT MATCHED BY TARGET        
                    -- THEN       
                    --                         INSERT (      
                    --                          [ApplicationId],       
                    --                          [EntityFieldId],       
                    --                          [Value],       
                    --                          [ParentId],       
                    --                          [itemIndex]      
                    --                         )      
                    --                                Values( @applicationId,       
                    --                                       entityFieldId,       
                    --                                       value,       
                    --                                       @parentId,       
                    --                                       itemIndex);      
                    --                         --FETCH THE NEXT RECORD INTO THE VARIABLES.                    
                    --                         FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;      
                    --         END;      
                    --                 --CLOSE THE CURSOR.                    
                    --                 CLOSE reference_form_cursor;      
                    --                 DEALLOCATE reference_form_cursor;      
                    -- testing purpose start    
                    --DECLARE THE CURSOR FOR A QUERY.                    
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
                    IF(  
                    (  
                        SELECT TOP 1 SSA1.Id  
                        FROM service.StageActions SSA1  
                        WHERE SSA1.ActionTypeId = @submitstageactiontypeid  
                              AND SSA1.StageId = @stageid  
                    ) = @stageActionId)  
                        BEGIN  
                            IF EXISTS  
                            (  
                                SELECT TOP 1 1  
                                FROM application.ApplicationStages AAS  
                                WHERE ApplicationId = @applicationid  
                                      AND AAS.StageStatusId = @openstagestatusid  
                                ORDER BY AAS.Id DESC  
                            )  
                                BEGIN  
                                    UPDATE application.ApplicationStages  
                                      SET   
                                          StageStatusId = @closestagestatusid  
                                    WHERE ApplicationId = @applicationId  
                                          AND StageStatusId = @openstagestatusid;  
                                    IF EXISTS  
                                    (  
                                        SELECT 1  
                                        FROM service.Stages  
                                        WHERE ServiceId = @serviceId  
                                              AND id > @stageId  
                                    )  
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
                                                       SELECT MIN(id)  
                                          FROM service.Stages  
                                                       WHERE ServiceId = @serviceid  
                                                             AND id > @stageid  
                                                   ) AS StageId,   
                                                                GETDATE() AS CreatedOn,   
                                                                @openstagestatusid AS StageStatusId,   
                                                                StageId AS PreviousStageId  
                                                   FROM application.ApplicationStages  
                                                   WHERE ApplicationId = @applicationId  
                                                   ORDER BY ID DESC;  
                                    END;  
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



