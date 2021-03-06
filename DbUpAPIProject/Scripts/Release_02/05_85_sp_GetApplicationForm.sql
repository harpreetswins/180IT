
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationForm]    Script Date: 11-02-2021 15:24:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetApplicationForm 113,null,'NAD Program Manager','06af3268-d501-4c43-92ef-6f71249dccdc','محمد راتب'          
ALTER PROCEDURE [dbo].[sp_GetApplicationForm] @applicationid AS INT, 
                                               @stageid AS       INT, 
                                               @role AS          NVARCHAR(100), 
                                               @creatorId AS     NVARCHAR(100), 
                                               @creatorName AS   NVARCHAR(100)
AS
    BEGIN
        DECLARE @roleId INT, @uId INT, @stageTranslationKeyId INT= 12, @formTranslationKeyId INT= 2, @serviceTranslationKeyId INT= 11, @stageStatusTranslationKeyId INT= 13, @isOwner BIT= 0, @IsPermission INT= 1, @stageactionapplicationstatus BIT= 0, @applicationstageid INT, @currentstageid INT, @currentapplicationstatusid INT, @approveactiontype INT= 4, @rejectactiontype INT= 5, @readonlymodeid INT= 2, @rejectstatusid INT= 3, @completestatusid INT= 2, @userRoleExist AS BIT= 0;
					
					SELECT TOP 1 @applicationstageid = Id, 
								 @currentstageid = StageId, 
								 @currentapplicationstatusid = StageStatusId
					FROM vw_ApplicationStagesOrderBy
					WHERE ApplicationId = @applicationid;
		
		EXEC @uId = sp_GetUserId 
             @creatorId,@creatorName;
		SET @stageactionapplicationstatus = (SELECT dbo.fn_ApplicationStageActionExist(@applicationstageid, @currentstageid, @approveactiontype, @rejectactiontype, @rejectstatusid, @completestatusid));
        SET @isOwner = (SELECT dbo.fn_isOwnerExist(@applicationid, @uId));
		SET @userRoleExist = (SELECT dbo.fn_roleExists(@currentStageId, @role));

        
		IF(@userRoleExist = 1 OR @isOwner = 1)
            BEGIN
                SELECT DISTINCT TOP 1 AAS.StageId, 
                                      AA.ApplicationNumber, 
                                      SS.Name, 
                                      SS.OrderNumber, 
                                      AA.CreatedOn AS CreatedDate, 
                                      AA.CreatorId, 
                                      JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName, 
                                      AA.ProfileAppId AS ProfileAppId, 
									  AAS.StageStatusId AS CurrentStatusId,
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
                                      (CASE
                                           WHEN AAS.StageStatusId NOT IN(@rejectstatusid, @completestatusid)
                                           THEN JSON_QUERY(dbo.fn_stageActions(AAS.StageId, @role, @isOwner))
                                           ELSE NULL
                                       END) AS Actions, 
                                      @IsPermission AS IsPermission
                FROM vw_ApplicationStagesOrderBy AAS
                     INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                     INNER JOIN service.Stages SS ON SS.Id = AAS.StageId
                     INNER JOIN service.Services S ON S.Id = AA.ServiceId
                WHERE aas.ApplicationId = @applicationid
                      AND aas.Id = @applicationstageid
                      AND (@stageid IS NULL
                           OR aas.StageId = @stageid)
                ORDER BY 1 DESC;
        END;
            ELSE
            BEGIN
                SET @IsPermission = 0;
                SELECT @IsPermission AS IsPermission;
        END;
    END;