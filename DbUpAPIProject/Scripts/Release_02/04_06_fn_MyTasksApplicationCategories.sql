
/****** Object:  UserDefinedFunction [dbo].[fn_MyTasksApplicationCategories]    Script Date: 10-02-2021 16:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_MyTasksApplicationCategories]
(@userId INT, 
 @role   NVARCHAR(2000)
)
RETURNS @Statistics TABLE
(StageId         INT, 
 StageStatusId   INT, 
 StageStatusName NVARCHAR(50), 
 StatusCount     INT
)
AS
     BEGIN
         DECLARE @rejectedStageStatusId INT= 3, @completedStageStatusId INT= 2;
         DECLARE @Roles TABLE(Id VARCHAR(100));
         INSERT INTO @Roles(Id)
                SELECT Id
                FROM dbo.fn_GetRoleIds(@role);
         INSERT INTO @Statistics
                SELECT App_Stg.StageId, 
                       App_Stg.StageStatusId, 
                       Stg_Status.Name StageStatusName, 
                       COUNT(DISTINCT(App_Stg.Id)) StatusCount
                FROM application.Applications Apps
                     INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId
                     INNER JOIN lookups.StageStatuses Stg_Status ON Stg_Status.Id = App_Stg.StageStatusId
                     INNER JOIN service.Services Svc ON Svc.Id = Apps.ServiceId
                WHERE App_Stg.Id IN
                (
                    SELECT MAX(App_Stg.Id)
                    FROM application.Applications Apps
                         INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId
                    WHERE App_Stg.StageId IN
                    (
                        SELECT StageId
                        FROM service.StageActions Stg_Act
                             INNER JOIN service.StageActionRoles Stg_Act_Rol ON Stg_Act.Id = Stg_Act_Rol.StageActionId
                        WHERE RoleId IN
                        (
                            SELECT Id
                            FROM @Roles
                        )
                    )
                    GROUP BY Apps.Id
                )
                    AND App_Stg.StageStatusId NOT IN(@rejectedStageStatusId, @completedStageStatusId)
					AND Apps.CreatorId = @userId
                GROUP BY App_Stg.StageId, 
                         App_Stg.StageStatusId, 
                         Stg_Status.Name;
         RETURN;
     END;