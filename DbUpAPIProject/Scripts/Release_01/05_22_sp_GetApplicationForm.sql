
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationForm]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetApplicationForm] @applicationid AS INT,           
                                           @stageid AS       INT          
AS          
    BEGIN          
 DECLARE @stageTranslationKeyId INT = 12, @formTranslationKeyId INT = 2, @serviceTranslationKeyId INT = 11;  
        SELECT DISTINCT TOP 1 AAS.StageId,       
         AA.ApplicationNumber,          
                              SS.Name,       
                              SS.OrderNumber,     
         AA.CreatedOn AS CreatedDate,    
         AA.CreatorId,    
                              JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName,           
        --  dbo.fn_forms(@applicationid, @stageid, AA.ServiceId) AS Forms,          
        (          
            SELECT F.id AS formId,           
                   F.Name AS formNameKey,           
                   SSs.Id AS formMode,           
                   SF.OrderNumber AS formOrder,           
                   SE.Id AS EntityId,           
                   JSON_QUERY(dbo.fn_multiLingualName(F.Id, @formTranslationKeyId)) AS formName,           
                   JSON_QUERY(dbo.fn_formSection(SF.FormId, @applicationid)) AS formSection          
            FROM service.StageForms SF          
                 INNER JOIN service.Forms F ON F.Id = SF.FormId          
                 INNER JOIN service.Entities SE ON SE.Id = F.EntityId          
                 INNER JOIN lookups.StageStatuses SSs ON SSs.Id = AAS.StageStatusId          
                 INNER JOIN service.Stages SS1 ON SS1.Id = SF.StageId          
            WHERE SF.StageId = AAS.StageId          
                  AND SS1.ServiceId = AA.ServiceId FOR JSON PATH          
        ) AS Forms,       
  JSON_QUERY(dbo.fn_multiLingualName(S.Id, @serviceTranslationKeyId)) AS ServiceName,      
                              JSON_QUERY(dbo.fn_stageActions(AAS.StageId)) AS Actions          
        FROM application.ApplicationStages AAS          
             INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId          
             INNER JOIN service.Stages SS ON SS.Id = AAS.StageId       
    INNER JOIN service.Services S ON S.Id = AA.ServiceId      
        WHERE aas.ApplicationId = @applicationid          
    -- AND AA.ProfileAppId IS NULL      
              AND (@stageid IS NULL          
                   OR aas.StageId = @stageid)          
        ORDER BY 1 DESC;          
    END; 
GO