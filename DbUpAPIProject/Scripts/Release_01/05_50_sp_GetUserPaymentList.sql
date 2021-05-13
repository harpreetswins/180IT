-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- sp_GetUserPaymentList '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0',1,100,null,null,null    
-- sp_GetUserPaymentList '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0',1,100,'2021-01-15','2021-01-17',null     
-- =============================================    
ALTER PROCEDURE [dbo].[sp_GetUserPaymentList] @creatorid AS        NVARCHAR(100),              
            @pagenumber AS        INT,                 
            @pagesize AS      INT,           
            @start  AS DATETIME,            
            @end AS DATETIME,            
            @search AS Varchar(100) = null             
    
AS    
    
DECLARE  @uId int, @serviceTranslationKeyId INT = 11;                
EXEC @uId= sp_GetUserId @creatorid               
    BEGIN       
    
  WITH CTE_Results AS                  
 (                
        SELECT AA.ApplicationNumber AS ApplicationNumber,     
      PT.OrderNumber,    
      PT.CreatedDateTime AS Date,    
      PT.TotalAmount AS Amount,    
     CASE WHEN PT.Paid IS NULL     
     THEN 'Pending'    
     WHEN PT.Paid = 0    
     Then 'Failed'    
     ELSE     
     'Paid' END    
     AS Status,   
  --SS.Name AS ServiceName,   
   dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId) AS ServiceName,
      PT.URN AS PaymentType         
   FROM application.PaymentTransactions PT    
   INNER JOIN application.ApplicationStages AAS ON AAS.Id = PT.ApplicationStageId    
   INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId       
   INNER JOIN service.Services SS ON SS.Id = AA.ServiceId                
      WHERE PT.CreatedBy = @uId          
          
        ORDER BY AA.ApplicationNumber                
   OFFSET @pageSize * (@pageNumber - 1) ROWS                
    FETCH NEXT @pageSize ROWS ONLY                
 ),           
  CTE_TotalRows AS                  
 (                
  SELECT Count(AA.ApplicationNumber) AS TotalRows FROM application.PaymentTransactions PT    
   INNER JOIN application.ApplicationStages AAS ON AAS.Id = PT.ApplicationStageId    
   INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId                     
      WHERE PT.CreatedBy = @uId       
   AND (@start is null or (@start is not null and  convert(date,PT.CreatedDateTime)>=@start))    
   AND (@end is null or (@end is not null and convert(date,PT.CreatedDateTime)<=@end))    
 )    
    
 SELECT * FROM CTE_Results  temp       
 , CTE_TotalRows          
 WHERE      
   (@start is null or (@start is not null and  convert(date,temp.date)>=@start))    
   AND (@end is null or (@end is not null and convert(date,temp.date)<=@end))    
   AND    
   ((@search Is NUll Or temp.applicationNumber like '%'+isnull(@search,'')+'%') OR (@search Is NUll Or temp.OrderNumber like '%'+ISNULL(@search,'')+'%'))            
                
 OPTION (RECOMPILE)      
    
  END 