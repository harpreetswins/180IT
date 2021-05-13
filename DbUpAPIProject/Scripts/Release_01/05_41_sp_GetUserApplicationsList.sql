
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsList]    Script Date: 21-01-2021 18:39:41 ******/
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
  
ALTER PROCEDURE [dbo].[sp_GetUserApplicationsList] @creatorid AS        NVARCHAR(100),             
                                                   @serviceid AS     INT,             
                                                   @stageid AS       INT,             
                                                   @stagestatusid AS INT,             
                                                   @pagenumber AS        INT,             
                                                   @pagesize AS      INT,       
												   @start  AS DATETIME,        
												   @end AS DATETIME,        
												   @search AS Varchar(100) = null          
AS            
          
DECLARE  @uId int , @statusTranslationKeyId INT = 13, @stageTranslationKeyId INT = 12;           
EXEC @uId= sp_GetUserId @creatorid           
    BEGIN           
           
 WITH CTE_Results AS              
 (            
        SELECT AAS.Id AS applicationStageId,             
              
               AAS.ApplicationId AS applicationId,            
			  AA.ApplicationNumber AS applicationNumber,             
			  --ASS.Name StatusName,  
			  (    
             SELECT MAX(ST.Value) AS value,     
                    ST.LanguageId AS langId    
             FROM system.SystemTranslations ST    
                  INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId    
                  INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId    
             WHERE ST.ItemId = ASS.Id    
                   AND STK.Id = @statusTranslationKeyId   
             GROUP BY ST.LanguageId 
			 FOR JSON PATH    
         ) AS StatusName,
			  JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName,   
			  --SS.Name AS stageName,            
               AAS.CreatedOn AS createdOn,             
               AAS.UserId AS createdBy,             
               null AS assignedTo ,          
				AAS.StageId AS StageId          
			FROM application.ApplicationStages AAS            
             INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId            
			INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS.StageStatusId           
			INNER JOIN service.Stages SS ON SS.Id = AAS.StageId            
				WHERE AAS.UserId = @uId            
			   AND (@serviceid IS NULL OR AA.ServiceId = @serviceid)            
			   AND (@stagestatusid IS NULL OR AAS.StageStatusId = @stagestatusid)            
			   AND (@stageid IS NULL OR AAS.StageId = @stageid) 
			   
        ORDER BY AAS.ApplicationId            
   OFFSET @pageSize * (@pageNumber - 1) ROWS            
    FETCH NEXT @pageSize ROWS ONLY            
 ),            
 CTE_TotalRows AS              
 (            
  SELECT Count(AAS.Id) AS TotalRows FROM application.ApplicationStages AAS             
    INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId            
        WHERE AAS.UserId = @uId            
   AND (@serviceid IS NULL OR AA.ServiceId = @serviceid)            
   AND (@stagestatusid IS NULL OR AAS.StageStatusId = @stagestatusid)            
   AND (@stageid IS NULL OR AAS.StageId = @stageid)   
   AND (@start is null or (@start is not null and  convert(date,AAS.createdOn)>=@start))
   AND (@end is null or (@end is not null and convert(date,AAS.createdOn)<=@end))
 )            
             
 SELECT * FROM CTE_Results  temp   
 , CTE_TotalRows      
 WHERE  
 --  ((ISNULL(CAST(@start AS DATE), '1900-01-01') IS NULL OR CAST(temp.createdOn AS DATE) >= ISNULL(CAST(@start AS DATE), '1900-01-01')) AND (ISNULL(CAST(@end AS DATE), '2099-12-31') IS NULL OR CAST(temp.createdOn AS DATE) <= ISNULL(CAST(@end AS DATE), '2099-12-31')))  
   (@start is null or (@start is not null and  convert(date,temp.createdOn)>=@start))
   AND (@end is null or (@end is not null and convert(date,temp.createdOn)<=@end))
   AND
   ((@search Is NUll Or temp.stageName like '%'+isnull(@search,'')+'%') OR (@search Is NUll Or temp.StatusName like '%'+ISNULL(@search,'')+'%') OR (@search Is NUll Or temp.applicationNumber like '%'+ISNULL(@search,'')+'%'))        
            
 OPTION (RECOMPILE)  

    END;
GO