-- sp_GetApplicationActivityLogs 142, '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0', 'Sanjay'  
ALTER PROCEDURE [dbo].[sp_GetApplicationActivityLogs] @ApplicationId INT,             
                                                       @UserId        NVARCHAR(100),    
                                                       @creatorName   NVARCHAR(100)            
AS            
    BEGIN            
        DECLARE @uId INT;            
        EXEC @uId = sp_GetUserId             
             @UserId,@creatorName;            
        DECLARE @serviceTranslationKeyId INT= 11, @stageTranslationKeyId INT= 12, @statusesTranslationKeyId INT= 13, @stageActionsTranslationKeyId INT= 7;            
        DECLARE @ActivityLogs NVARCHAR(MAX);            
        SET @ActivityLogs =            
        (            
            SELECT DISTINCT             
                   AA.Id AS ApplicationId,             
                   AA.ApplicationNumber AS ApplicationNumber,             
                   SS.Name AS ServiceName,             
                   JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS ServicesName,             
            (            
                SELECT AAS1.StageId,             
                       SSS.Name AS StageName,
					   SSS.StageTypeId,             
                       JSON_QUERY(dbo.fn_multiLingualName(SSS.Id, @stageTranslationKeyId)) AS StagesName,             
                       ASS.Name AS StatusName,             
                       JSON_QUERY(dbo.fn_multiLingualName(ASS.Id, @statusesTranslationKeyId)) AS StatusesName,             
                (            
                    SELECT DISTINCT AASA.Id,        
                           AASA.CreatedOn AS PerformedDate,           
                           AU.UserName AS CreatedBy,     
                           SSA.Name AS ActionName,             
                           JSON_QUERY(dbo.fn_multiLingualName(SSA.Id, @stageActionsTranslationKeyId)) AS StagesActionName,             
                           SAT.Name AS ActionTypeName,             
                           AASA.Comments,             
                    (            
                        SELECT AAAS.Id,             
                               AAAS.Extension,             
                               AAAS.Size,             
                               AAAS.FileName            
                        FROM application.ActionAttachments AAAS            
                        WHERE AAAS.AppId = @ApplicationId            
                              AND AAAS.AppStageActionId = AASA.Id            
                              AND AAAS.IsDeleted = 0 FOR JSON PATH            
                    ) AS ActionAttachment,            
      (            
                        SELECT APTS.OrderNumber,            
         APTS.OrderId,            
         APTS.CreatedDateTime,        
       CASE WHEN APTS.Paid IS NULL THEN 'Pending' WHEN APTS.Paid = 0 THEN 'Failed' ELSE 'Paid' END PaymentStatus            
                        FROM application.PaymentTransactions APTS          
      WHERE APTS.ApplicationStageId = AASA.ApplicationStageId        
      AND CAST(APTS.OrderId AS VARCHAR(10)) = CAST(JSON_VALUE(AASA.Data, '$[0].OrderId')  AS VARCHAR(10))        
                         ORDER BY APTS.CreatedDateTime DESC FOR JSON PATH            
                    ) AS TransactionDetail            
                    FROM application.ApplicationStageActions AASA                     
                         INNER JOIN service.StageActions SSA ON SSA.Id = AASA.StageActionId            
                         INNER JOIN lookups.ActionTypes SAT ON SAT.Id = SSA.ActionTypeId      
       INNER JOIN application.Users AU ON AU.Id = AASA.UserId    
                    WHERE AASA.ApplicationStageId = AAS1.Id          
                    ORDER BY AASA.CreatedOn ASC FOR JSON PATH            
                ) AS Actions            
                FROM service.Stages SSS            
                     INNER JOIN application.ApplicationStages AAS1 ON AAS1.StageId = SSS.Id      
                     INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS1.StageStatusId            
                WHERE SSS.ServiceId = AA.ServiceId            
                      AND AAS1.ApplicationId = AAS.ApplicationId FOR JSON PATH   
       --ORDER BY SSS.Id ASC FOR JSON PATH            
            ) AS Stages            
            --FROM application.ApplicationStages AAS       
            FROM vw_ApplicationStagesOrderBy AAS     
                 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId            
                 INNER JOIN service.Services SS ON SS.Id = AA.ServiceId            
            WHERE AAS.ApplicationId = @ApplicationId FOR JSON PATH            
        );            
        SELECT @ActivityLogs AS ActivityLogs;            
    END;  