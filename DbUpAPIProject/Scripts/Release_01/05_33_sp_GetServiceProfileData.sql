
/****** Object:  StoredProcedure [dbo].[sp_GetServiceProfileData]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- sp_GetServiceProfileData 5051,'cfc09c82-8647-4771-b881-2fdef2912c03'     
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetServiceProfileData] @ServiceId INT,    
             @CreatorId NVARCHAR(100)    
AS      
    BEGIN      
      
   DECLARE @uId INT, @serviceTranslationKeyId INT = 11, @fieldTranslationKeyId INT = 1, @closeStatusTranslationKeyId INT = 2;    
        EXEC @uId = sp_GetUserId     
             @CreatorId;    
    
 DECLARE @ProfileData NVARCHAR(MAX);          
        SET @ProfileData =       
        (SELECT DISTINCT         
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
       (Select STS.Value AS value, STS.LanguageId AS langId from service.EntityFieldLookups LEFLS    
       INNER JOIN application.ApplicationFieldValues SAFVS ON SAFVS.EntityFieldId = LEFLS.EntityFieldId        
                             INNER JOIN service.Translations   STS  ON STS.ItemId =  LEFLs.id            
       INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId                                                        
       Where  SAFVS.ApplicationId = AAS.ApplicationId AND LEFLS.EntityFieldId = SFSF.EntityFieldId AND LEFLS.Value = SAFV.Value    
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
                    GROUP BY SFSF.EntityFieldId, EF.FieldTypeId, SAFV.Value, SFSF.OrderNumber  
     ORDER BY SFSF.OrderNumber ASC   
     FOR JSON PATH        
                ) AS Fields        
                FROM application.ApplicationStages AAS        
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
                         AAS.StageId       
    ORDER BY AAS.ApplicationId DESC      
       FOR JSON PATH        
            ) AS applications       
            FROM service.Stages SST        
            WHERE SST.ServiceId = SSP.ProfileServiceId FOR JSON PATH        
        ) AS stages        
        FROM service.ServiceProfiles SSP        
             INNER JOIN service.Services SS ON SSP.ServiceId = SS.Id        
        WHERE SS.Id = @ServiceId AND SS.IsDeleted = 0 FOR JSON PATH);      
  SELECT @ProfileData AS ProfileData;        
    END;  
GO