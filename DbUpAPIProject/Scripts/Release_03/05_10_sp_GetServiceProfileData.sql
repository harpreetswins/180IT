-- =============================================                      
-- Author:  <Author,,Name>                      
-- Create date: <Create Date,,>                      
-- Description: <Description,,>                      
-- sp_GetServiceProfileData 2,null,'ab911a3d-36c4-4180-ac10-792041433e48','sanjay'                     
-- =============================================                      
ALTER PROCEDURE [dbo].[sp_GetServiceProfileData] @ServiceId    INT,               
                                                 @ProfileAppId INT,               
                                                 @CreatorId    NVARCHAR(100),              
             @creatorName   NVARCHAR(100)              
AS              
    BEGIN              
        DECLARE @uId INT, @serviceTranslationKeyId INT= 11, @fieldTranslationKeyId INT= 1, @closeStatusTranslationKeyId INT= 2, @systemLookupTranslationKeyId INT = 18, @lookupsTranslationKeyId INT = 8;              
        EXEC @uId = sp_GetUserId               
             @CreatorId,@creatorName;              
        DECLARE @ProfileData NVARCHAR(MAX);              
        SET @ProfileData =              
        (              
            SELECT DISTINCT               
                   SSP.ProfileServiceId,               
                   JSON_QUERY(dbo.fn_multiLingualName(SSP.ProfileServiceId, @serviceTranslationKeyId)) AS serviceName,               
            (              
                SELECT SST.Id,               
                (              
                    SELECT AAS.ApplicationId,               
                           AAS.StageId,               
                    (              
                        SELECT SFSF.EntityFieldId,               
                               EF.FieldTypeId,       
            (SELECT STS.Value AS value,               
              STS.LanguageId AS langId                  
            FROM service.LookupValues SLV                             
            INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id                            
            INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId                              
           WHERE SLV.Value = CAST(SAFV.Value AS INT) AND STK.Id = @systemLookupTranslationKeyId AND                  
           SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)             
           FOR JSON PATH) AS lookupValues,            
                  
           (CASE              
            WHEN MAX(SAFV.Value) IS NULL              
            THEN ''              
            ELSE MAX(SAFV.Value)              
           END) AS formSectionFieldValue,               
             JSON_QUERY(dbo.fn_multiLingualName(SFSF.EntityFieldId, @fieldTranslationKeyId)) AS formSectionFieldName              
         FROM service.FormSectionFields SFSF              
           INNER JOIN service.EntityFields EF ON EF.Id = SFSF.EntityFieldId              
           LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = SFSF.EntityFieldId              
                         AND SAFV.ApplicationId = AAS.ApplicationId              
         WHERE EF.IsPromoted = 1              
         GROUP BY SFSF.EntityFieldId,               
            EF.FieldTypeId,               
            SAFV.Value,               
            SFSF.OrderNumber              
         ORDER BY SFSF.OrderNumber ASC FOR JSON PATH              
        ) AS Fields              
                    FROM vw_ApplicationStagesOrderBy AAS              
                         INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId              
                         INNER JOIN service.StageForms SSF ON SSF.StageId = AAS.StageId              
                         INNER JOIN service.Forms SF ON SF.Id = SSF.FormId              
                         INNER JOIN service.FormSections SFS ON SFS.FormId = SF.Id              
                    INNER JOIN service.FormSectionFields FSF ON FSF.FormSectionId = SFS.Id              
       INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId              
                    WHERE aas.StageId = SST.Id              
                          AND AA.CreatorId = @uId              
                          AND AAS.StageStatusId = @closeStatusTranslationKeyId              
                          AND (@ProfileAppId IS NULL              
                               OR AA.Id = @ProfileAppId)              
                    GROUP BY AAS.ApplicationId,               
                             AAS.StageId FOR JSON PATH              
                ) AS applications              
                FROM service.Stages SST              
                WHERE SST.ServiceId = SSP.ProfileServiceId FOR JSON PATH              
            ) AS stages              
            FROM service.ServiceProfiles SSP              
                 INNER JOIN service.Services SS ON SSP.ServiceId = SS.Id              
            WHERE SS.Id = @ServiceId              
                  AND SS.IsDeleted = 0 FOR JSON PATH              
        );              
        SELECT @ProfileData AS ProfileData;              
    END;  