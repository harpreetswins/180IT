 
 
  
CREATE FUNCTION [dbo].[fn_MyApplicationDetails](@userId INT, @serviceId INT)  
RETURNS @Statistics TABLE(AppId int, StageId int, StageStatusId int, StageStatusName nvarchar(50))  
AS  
Begin   

DECLARE @stagestatusid INT = 2;
 INSERT INTO @Statistics  
 SELECT Apps.Id AS AppId, App_Stg.StageId, App_Stg.StageStatusId, Stg_Status.Name StageStatusName   
 FROM application.Applications Apps      
   INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId      
   INNER JOIN lookups.StageStatuses Stg_Status ON Stg_Status.Id = App_Stg.StageStatusId     
   INNER JOIN service.Services Svc ON Svc.Id = Apps.ServiceId  
 WHERE App_Stg.Id IN   
 (  
  select Max(App_Stg.Id)  
  FROM application.Applications Apps      
   INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId   
  WHERE Apps.CreatorId = @userId AND Apps.ServiceId = @serviceId AND App_Stg.StageStatusId = @stagestatusid      
  GROUP BY Apps.Id  
 )  
 GROUP BY Apps.Id, App_Stg.StageId, App_Stg.StageStatusId, Stg_Status.Name;  
  
 RETURN  
END  