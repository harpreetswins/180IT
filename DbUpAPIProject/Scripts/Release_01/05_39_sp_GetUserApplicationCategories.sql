
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationCategories]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author: <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- exec sp_GetUserApplicationCategories '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0'    
-- =============================================    
ALTER PROCEDURE [dbo].[sp_GetUserApplicationCategories] @userId NVARCHAR(100)  
AS  
    BEGIN  
  
        -- EXEC sp_GetUserId @userId        
  
        DECLARE @uId INT, @serviceTranslationKeyId INT = 11, @stageTranslationKeyId INT = 12, @statusesTranslationKeyId INT = 13;  
        EXEC @uId = sp_GetUserId   
             @userId;  
        DECLARE @applicationCategories NVARCHAR(4000);  
        SET @applicationCategories =  
        (  
            SELECT S.Id AS serviceId,   
                   S.name,   
            (  
                SELECT ST.Value AS value,   
                       ST.LanguageId AS langId  
                FROM service.Translations ST  
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId  
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
                WHERE ST.ItemId = S.Id  
                      AND STK.Id = @serviceTranslationKeyId FOR JSON PATH  
            ) AS serviceName,   
            (  
                SELECT ss.id AS stageId,   
                       MAX(SS.Name) AS stageName,   
                (  
                    SELECT ST.Value AS value,   
                           ST.LanguageId AS langId  
                    FROM service.Translations ST  
                         INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId  
                         INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
                    WHERE ST.ItemId = ss.Id  
                          AND STK.Id = @stageTranslationKeyId FOR JSON PATH  
                ) AS stagesName,   
                (  
                    SELECT aass1.id AS stageStatusId,   
                           MAX(aass1.name) AS stageStatusName,   
                    --(  
                    --    SELECT ST.Value AS value,   
                    --           ST.LanguageId AS langId  
                    --    FROM service.Translations ST  
                    --         INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId  
                    --         INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
                    --    WHERE ST.ItemId = aass1.Id  
                    --          AND STK.Name = 'Statuses' FOR JSON PATH  
                    --) AS statusesName,   
     (      
             SELECT MAX(ST.Value) AS value,       
                    ST.LanguageId AS langId      
             FROM system.SystemTranslations ST      
                  INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId      
                  INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId      
             WHERE ST.ItemId = aass1.Id      
                   AND STK.Id = @statusesTranslationKeyId      
             GROUP BY ST.LanguageId   
    FOR JSON PATH      
         ) AS statusesName,  
                    (  
                        SELECT COUNT(DISTINCT(ASS6.Id))  
                        FROM application.Applications A6  
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId  
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id  
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId  
                        WHERE A6.CreatorId = @uId  
                              AND aass.id = aass1.Id  
                              AND ASS6.StageStatusId = aass1.Id  
                              AND A6.ServiceId = S.Id  
                              AND ASS6.StageId = ss.id  
                    ) AS StatusCount  
                    FROM lookups.StageStatuses aass1  
                    WHERE EXISTS  
                    (  
                        SELECT A2.id  
                        FROM application.Applications A2  
                             INNER JOIN application.ApplicationStages ASS2 ON A2.Id = ASS2.ApplicationId  
                        WHERE ass2.StageStatusId = aass1.id  
                              AND A2.CreatorId = @uId  
                              AND ASS2.StageId = ss.id  
                    )  
                    GROUP BY aass1.id  
                    HAVING  
                    (  
                        SELECT COUNT(DISTINCT(ASS6.Id))  
                        FROM application.Applications A6  
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId  
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id  
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId  
                        WHERE A6.CreatorId = @uId  
                              AND aass.id = aass1.Id  
                              AND ASS6.StageStatusId = aass1.Id  
                              AND A6.ServiceId = S.Id  
                              AND ASS6.StageId = ss.id  
                    ) > 0 FOR JSON PATH  
                ) AS stageStatuses  
                FROM service.Stages ss  
                     INNER JOIN application.ApplicationStages AAS7 ON AAS7.StageId = ss.Id  
                WHERE EXISTS  
                (  
                    SELECT A11.id  
                    FROM application.Applications A11  
                         INNER JOIN application.ApplicationStages AAS11 ON AAS11.ApplicationId = A11.Id  
                    WHERE A11.ServiceId = S.Id  
                          AND A11.CreatorId = @uId  
                )  
                GROUP BY ss.id  
     HAVING  
                    (  
                        SELECT COUNT(DISTINCT(ASS6.Id))  
                        FROM application.Applications A6  
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId  
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id  
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId  
                        WHERE A6.CreatorId = @uId  
                              AND A6.ServiceId = S.Id  
                              AND ASS6.StageId = ss.id  
                    ) > 0   
    FOR JSON PATH  
            ) AS stages  
            FROM service.Services S  
            WHERE EXISTS  
            (  
                SELECT A.id  
                FROM application.Applications A  
                WHERE A.ServiceId = S.Id  
                      AND A.CreatorId = @uId  
            ) FOR JSON PATH  
        );  
        SELECT '200' AS STATUS,   
               @applicationCategories AS ApplicationCategories;  
    END;  
GO