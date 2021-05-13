
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationForm]    Script Date: 09-02-2021 15:21:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetApplicationForm 91,null,'NAD Program Manager','09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','Sanjay'        
ALTER PROCEDURE [dbo].[sp_GetApplicationForm] @applicationid AS INT,     
                                               @stageid AS       INT,     
                                               @role AS          NVARCHAR(100),     
                                               @creatorId AS     NVARCHAR(100),    
                                               @creatorName AS     NVARCHAR(100)    
    
AS    
    BEGIN    
        DECLARE @roleId INT, @uId INT, @stageTranslationKeyId INT= 12, @formTranslationKeyId INT= 2, @serviceTranslationKeyId INT= 11, @stageStatusTranslationKeyId INT= 13, @isOwner BIT= 0, @IsPermission INT= 1, @stageactionapplicationstatus BIT= 0,     
  @applicationstageid INT, @currentstageid INT, @currentapplicationstatusid INT, @approveactiontype INT= 4, @rejectactiontype INT= 5, @readonlymodeid INT= 2, @rejectstatusid INT = 3, @completestatusid INT = 2;    
        SELECT TOP 1 @applicationstageid = Id,     
                     @currentstageid = StageId,    
      @currentapplicationstatusid = StageStatusId    
        FROM vw_ApplicationStagesOrderBy    
        WHERE ApplicationId = @applicationid ;     
  
  SET @stageactionapplicationstatus = (SELECT dbo.fn_ApplicationStageActionExist(@applicationstageid,@currentstageid,@approveactiontype, @rejectactiontype,@rejectstatusid,@completestatusid))    
    
        CREATE TABLE #temp(Id INT);    
        INSERT INTO #temp    
        EXEC sp_GetRoleId     
             @role;    
        EXEC @uId = sp_GetUserId     
             @creatorId,@creatorName;    
        IF(    
        (    
            SELECT TOP 1 CreatorId    
            FROM application.Applications    
            WHERE Id = @applicationid    
        ) = @uId)    
            BEGIN    
                SET @isOwner = 1;    
        END;      
    
        SELECT TOP 1 @currentStageId = StageId    
        FROM vw_ApplicationStagesOrderBy AAS    
        WHERE ApplicationId = @applicationid;          
    
        DECLARE @yes AS BIT= 0;    
        IF EXISTS    
        (    
            SELECT SAR.RoleId    
            FROM service.StageActionRoles SAR    
                 INNER JOIN service.StageActions SA ON SA.Id = SAR.StageActionId    
            WHERE EXISTS    
            (    
                SELECT Id    
                FROM #temp    
            )    
                  AND SA.StageId = @currentStageId    
        )    
            BEGIN    
                SET @yes = 1;    
        END;    
        IF(@yes = 1    
           OR @isOwner = 1)    
            BEGIN    
                SELECT DISTINCT TOP 1 AAS.StageId,     
                                      AA.ApplicationNumber,     
                                      SS.Name,     
                                      SS.OrderNumber,     
                                      AA.CreatedOn AS CreatedDate,     
                                      AA.CreatorId,     
                                      JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName,     
                                      AA.ProfileAppId AS ProfileAppId,     
                         JSON_QUERY(dbo.fn_multiLingualName(AAS.StageStatusId, @stageStatusTranslationKeyId)) AS CurrentStatusName,     
                (    
                    SELECT F.id AS formId,     
                           F.Name AS formNameKey,       
                           CASE    
                               WHEN @stageactionapplicationstatus = 0    
                               THEN SF.FormModeId    
                               ELSE @readonlymodeid    
                           END AS formMode,      
                           SF.OrderNumber AS formOrder,     
                           SE.Id AS EntityId,     
                           JSON_QUERY(dbo.fn_multiLingualName(F.Id, @formTranslationKeyId)) AS formName,     
                           JSON_QUERY(dbo.fn_formSection(SF.FormId, @applicationid)) AS formSection    
                    FROM service.StageForms SF    
                         INNER JOIN service.Forms F ON F.Id = SF.FormId    
                         INNER JOIN service.Entities SE ON SE.Id = F.EntityId            
                         INNER JOIN service.Stages SS1 ON SS1.Id = SF.StageId    
                    WHERE SF.StageId = AAS.StageId    
                          AND SS1.ServiceId = AA.ServiceId    
                    ORDER BY SF.OrderNumber ASC FOR JSON PATH    
                ) AS Forms,     
                                      S.Id AS ServiceId,     
                                      JSON_QUERY(dbo.fn_multiLingualName(S.Id, @serviceTranslationKeyId)) AS ServiceName,     
           (CASE WHEN AAS.StageStatusId NOT IN (@rejectstatusid, @completestatusid) THEN    
                                      JSON_QUERY(dbo.fn_stageActions(AAS.StageId, @role, @isOwner))     
           ELSE null END) AS Actions,    
                                      @IsPermission AS IsPermission    
                FROM vw_ApplicationStagesOrderBy AAS    
                     INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId    
                     INNER JOIN service.Stages SS ON SS.Id = AAS.StageId    
                     INNER JOIN service.Services S ON S.Id = AA.ServiceId    
                WHERE aas.ApplicationId = @applicationid
				AND aas.Id = @applicationstageid                        
                      -- AND AA.ProfileAppId IS NULL                    
                      AND (@stageid IS NULL    
                           OR aas.StageId = @stageid) ORDER BY 1 DESC;    
        END;    
            ELSE    
            BEGIN    
                SET @IsPermission = 0;    
                SELECT @IsPermission AS IsPermission;    
        END;    
    END; 