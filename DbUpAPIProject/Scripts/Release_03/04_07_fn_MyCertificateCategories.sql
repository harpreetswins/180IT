  
CREATE FUNCTION [dbo].[fn_MyCertificateCategories](@userId INT)  
RETURNS @Statistics TABLE(StageId int, StageStatusId int, ApplicationCertificateId int, CertificateNumber nvarchar(50), CertificateId int, CertificateCount int)  
AS  
Begin   
 INSERT INTO @Statistics  
 SELECT App_Stg.StageId, App_Stg.StageStatusId, App_Certificates.Id, App_Certificates.CertificateNumber, App_Certificates.CertificateId, COUNT(DISTINCT(App_Certificates.Id)) CertificateCount   
 FROM application.ApplicationCertificates App_Certificates
   INNER JOIN application.Applications Apps ON App_Certificates.ApplicationId = Apps.Id      
   INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId      
   INNER JOIN lookups.StageStatuses Stg_Status ON Stg_Status.Id = App_Stg.StageStatusId     
   INNER JOIN service.Services Svc ON Svc.Id = Apps.ServiceId  
 WHERE App_Stg.Id IN   
 (  
  select Max(App_Stg.Id)  
  FROM application.Applications Apps      
   INNER JOIN application.ApplicationStages App_Stg ON Apps.Id = App_Stg.ApplicationId   
  WHERE Apps.CreatorId = @userId      
  GROUP BY Apps.Id  
 )  
 GROUP BY App_Stg.StageId, App_Stg.StageStatusId, App_Certificates.Id, App_Certificates.CertificateNumber, App_Certificates.CertificateId ;  
  
 RETURN  
END  