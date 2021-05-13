-- =============================================                                
-- Author:  <Author,,Name>                                
-- Create date: <Create Date,,>                                
-- Description: <Description,,>                                
-- sp_GetSearchRelatedRecords 125,null,'09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','Sanjay'                               
-- =============================================                                
CREATE PROCEDURE [dbo].[sp_GetSearchRelatedRecords] @FormSectionFieldId INT,                        
             @CreatorId    NVARCHAR(100),                        
             @creatorName   NVARCHAR(100)                        
AS                        
    BEGIN                        
        DECLARE @serviceId INT, @uId INT, @serviceTranslationKeyId INT= 11, @fieldTranslationKeyId INT= 1, @closeStatusTranslationKeyId INT= 2, @systemLookupTranslationKeyId INT = 18, @lookupsTranslationKeyId INT = 8, @lookupFieldTypeId int = 5;          
  
    
              
        EXEC @uId = sp_GetUserId                         
             @CreatorId,@creatorName;                        
        DECLARE @RelatedData NVARCHAR(MAX);       
        
  select @serviceId = (CAST(JSON_VALUE(Settings, '$.serviceIds[0]') AS INT)) From service.FormSectionFields Where Id = @FormSectionFieldId      
                         
        SET @RelatedData =                        
        (                        
            SELECT DISTINCT                           
                   JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS serviceName,                         
            (                        
                SELECT SST.Id,                         
                (                        
                    SELECT AAS.ApplicationId,                         
                           AAS.StageId,                         
                    (                        
                        SELECT SFSF.EntityFieldId,                         
                               EF.FieldTypeId,    
          CASE      
                           WHEN ISNULL(SFSF.ShowOnMainForm, 0) = 0      
                           THEN 'Hide'      
                           ELSE 'Show'      
                       END AS showOnMainForm,                 
            (SELECT STS.Value AS value,                         
              STS.LanguageId AS langId                            
            FROM service.LookupValues SLV                                       
            INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id                                      
            INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId                                        
           WHERE SLV.Value = CAST(SAFV.Value AS INT) AND STK.Id = @systemLookupTranslationKeyId AND                            
           SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)        
     AND EF.FieldTypeId = @lookupFieldTypeId                       
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
 WHERE SFSF.FormSectionParentId IS NOT NULL                      
         GROUP BY SFSF.EntityFieldId,                         
      EF.FieldTypeId,                         
            SAFV.Value,                         
            SFSF.OrderNumber,SFSF.ShowOnMainForm                        
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
                    GROUP BY AAS.ApplicationId,                         
                             AAS.StageId FOR JSON PATH                        
                ) AS applications                        
                FROM service.Stages SST                        
                WHERE SST.ServiceId = SS.Id FOR JSON PATH                        
            ) AS stages                        
            FROM service.Services SS                        
            WHERE SS.Id = @ServiceId                        
                  AND SS.IsDeleted = 0 FOR JSON PATH                        
        );                        
        SELECT @RelatedData AS RelatedData;                        
    END; 