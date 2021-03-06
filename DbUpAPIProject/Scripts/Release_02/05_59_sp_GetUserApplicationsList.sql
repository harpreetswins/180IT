
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsList]    Script Date: 09-02-2021 15:12:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
-- Author:  Neeraj        
-- Create date: 02 Dec,2020         
-- Description: Get User Applications Result Detail       
-- exec sp_GetUserApplicationsList '52761bd1-bb91-40be-b713-44ca5c32e089',16,16,2,1,100,'2020-12-16','2020-12-17',null     
-- exec sp_GetUserApplicationsList '52761bd1-bb91-40be-b713-44ca5c32e089',16,16,2,1,100,null,null,null     
-- =============================================          
  
ALTER PROCEDURE [dbo].[sp_GetUserApplicationsList] @creatorid AS     NVARCHAR(100),  
             @creatorName   NVARCHAR(100),   
                                                    @serviceid AS     INT,   
                                                    @stageid AS       INT,   
                                                    @stagestatusid AS INT,   
                                                    @pagenumber AS    INT,   
                                                    @pagesize AS      INT,   
                                                    @start AS         DATETIME,   
                                                    @end AS           DATETIME,   
                                                    @search AS        VARCHAR(100)  = NULL  
AS  
     DECLARE @uId INT, @statusTranslationKeyId INT= 13, @stageTranslationKeyId INT= 12;  
     EXEC @uId = sp_GetUserId   
          @creatorid,@creatorName;  
    BEGIN  
        WITH CTE_Results  
             AS (SELECT DISTINCT AAS.Id AS applicationStageId,   
                        AAS.ApplicationId AS applicationId,   
                        AA.ApplicationNumber AS applicationNumber,                 
                 (  
                     SELECT MAX(ST.Value) AS value,   
                            ST.LanguageId AS langId  
                     FROM [dbo].[vw_Translations] ST  
                          INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId  
                          INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
                     WHERE ST.ItemId = ASS.Id  
                           AND STK.Id = @statusTranslationKeyId  
                     GROUP BY ST.LanguageId FOR JSON PATH  
                 ) AS StatusName,   
                        JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName,              
                        AAS.CreatedOn AS createdOn,   
                        --AAS.UserId AS createdBy,   
                        AU.UserName AS createdBy,  
                        (Select AU.Id AS UserId, AU.UserName, AU.ExternalId from application.ActionAssignedUsers AAAU
						INNER JOIN application.ApplicationStageActions AASA ON AASA.Id = AAAU.ApplicationStageActionId
						INNER JOIN  application.Users AU ON AU.Id = AAAU.UserId
						Where AASA.ApplicationStageId = AAS.Id FOR JSON PATH) AS assignedTo,   
                        AAS.StageId AS StageId  
                 FROM application.ApplicationStages AAS  
                      INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId  
                      INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS.StageStatusId  
                      INNER JOIN service.Stages SS ON SS.Id = AAS.StageId  
       INNER JOIN application.Users AU ON AU.Id = AAS.UserId  
                 WHERE AAS.UserId = @uId  
                       AND (@serviceid IS NULL  
                            OR AA.ServiceId = @serviceid)  
                       AND (@stagestatusid IS NULL  
                            OR AAS.StageStatusId = @stagestatusid)  
                       AND (@stageid IS NULL  
                            OR AAS.StageId = @stageid)  
                 ORDER BY AAS.ApplicationId  
                 OFFSET @pageSize * (@pageNumber - 1) ROWS FETCH NEXT @pageSize ROWS ONLY),  
             CTE_TotalRows  
             AS (SELECT COUNT(AAS.Id) AS TotalRows  
                 FROM application.ApplicationStages AAS  
                      INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId  
                 WHERE AAS.UserId = @uId  
                       AND (@serviceid IS NULL  
                            OR AA.ServiceId = @serviceid)  
                       AND (@stagestatusid IS NULL  
                            OR AAS.StageStatusId = @stagestatusid)  
                       AND (@stageid IS NULL  
                            OR AAS.StageId = @stageid)  
                       AND (@start IS NULL  
                            OR (@start IS NOT NULL  
                                AND CONVERT(DATE, AAS.createdOn) >= @start))  
                       AND (@end IS NULL  
                            OR (@end IS NOT NULL  
                                AND CONVERT(DATE, AAS.createdOn) <= @end)))  
             SELECT *  
             FROM CTE_Results temp,   
                  CTE_TotalRows  
             WHERE(@start IS NULL  
                   OR (@start IS NOT NULL  
                       AND CONVERT(DATE, temp.createdOn) >= @start))  
                  AND (@end IS NULL  
                       OR (@end IS NOT NULL  
                           AND CONVERT(DATE, temp.createdOn) <= @end))  
                  AND ((@search IS NULL  
                        OR temp.stageName LIKE '%' + ISNULL(@search, '') + '%')  
                       OR (@search IS NULL  
                           OR temp.StatusName LIKE '%' + ISNULL(@search, '') + '%')  
                       OR (@search IS NULL  
                           OR temp.applicationNumber LIKE '%' + ISNULL(@search, '') + '%')) OPTION(RECOMPILE);  
    END;  