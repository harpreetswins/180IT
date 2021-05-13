
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationActivityLogs]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetApplicationActivityLogs] @ApplicationId INT,     
                                                      @UserId        NVARCHAR(100)    
AS    
    BEGIN    
        DECLARE @uId INT;    
        EXEC @uId = sp_GetUserId     
             @UserId;    
		DECLARE @serviceTranslationKeyId INT = 11, @stageTranslationKeyId INT = 12, @statusesTranslationKeyId INT = 13, @stageActionsTranslationKeyId INT = 7;
        DECLARE @ActivityLogs NVARCHAR(MAX);    
        SET @ActivityLogs =    
        (    
            SELECT DISTINCT AA.Id AS ApplicationId,     
                   AA.ApplicationNumber AS ApplicationNumber,     
                   SS.Name AS ServiceName,     
                   JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS ServicesName,     
            (    
                SELECT AAS1.StageId,     
                       SSS.Name AS StageName,     
                       JSON_QUERY(dbo.fn_multiLingualName(SSS.Id, @stageTranslationKeyId)) AS StagesName,     
                       ASS.Name AS StatusName,     
                       JSON_QUERY(dbo.fn_multiLingualName(ASS.Id, @statusesTranslationKeyId)) AS StatusesName,     
                (    
                    SELECT AASA.CreatedOn AS PerformedDate,    
         AASA.UserId AS CreatedBy,    
                           SSA.Name AS ActionName,     
                           JSON_QUERY(dbo.fn_multiLingualName(SSA.Id, @stageActionsTranslationKeyId)) AS StagesActionName,     
                           SAT.Name AS ActionTypeName    
                    FROM application.ApplicationStageActions AASA     
                         --INNER JOIN [application.ApplicationStages] AAS3 ON AAS3.Id = AASA.ApplicationStageId    
                         INNER JOIN service.StageActions SSA ON SSA.Id = AASA.StageActionId    
                         INNER JOIN lookups.ActionTypes SAT ON SAT.Id = SSA.ActionTypeId    
                    WHERE AASA.ApplicationStageId = AAS1.Id FOR JSON PATH    
                ) AS Actions    
                FROM service.Stages SSS    
                     INNER JOIN application.ApplicationStages AAS1 ON AAS1.StageId = SSS.Id    
                     INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS1.StageStatusId    
                WHERE SSS.ServiceId = AA.ServiceId    
                      AND AAS1.ApplicationId = AAS.ApplicationId FOR JSON PATH    
            ) AS Stages    
            FROM application.ApplicationStages AAS    
                 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId    
                 INNER JOIN service.Services SS ON SS.Id = AA.ServiceId    
            WHERE AAS.ApplicationId = @ApplicationId  
    FOR JSON PATH    
        );    
        SELECT @ActivityLogs AS ActivityLogs;    
    END;
GO