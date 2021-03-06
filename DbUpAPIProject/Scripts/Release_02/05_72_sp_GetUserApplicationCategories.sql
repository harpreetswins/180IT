
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationCategories]    Script Date: 10-02-2021 15:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
ALTER PROCEDURE [dbo].[sp_GetUserApplicationCategories]   
  @userId NVARCHAR(100),  
  @creatorName   NVARCHAR(100),
  @mode nvarchar(50),
  @role AS NVARCHAR(100)
           
AS      
    BEGIN      
     DECLARE @serviceTranslationKeyId INT = 11, @stageTranslationKeyId INT = 12, @statusesTranslationKeyId INT = 13;      
  
  DECLARE @uId int;  
  
        EXEC @uId = sp_GetUserId  @userId,@creatorName;    
    
  --DECLARE @mode nvarchar(50);--MyApplications, OtherApplications, MyTasks, AssignedToMe  
  --SET @mode='MyApplications';  
  
  --declare @role AS NVARCHAR(100)='NAD Program Manager,NAD Section Head';  
  
  DECLARE @Statistics TABLE(StageId int, StageStatusId int, StageStatusName nvarchar(50), StatusCount int)  
  IF @mode='MyApplications'  
   INSERT INTO @Statistics   
   SELECT * FROM dbo.fn_MyApplicationCategories(@uId);  
  
  IF @mode='OtherApplications'  
   INSERT INTO @Statistics   
   SELECT * FROM dbo.fn_OtherApplicationCategories(@uId, @role) AS ApplicationCategories;   
  
  IF @mode='AssignedToMe'  
   INSERT INTO @Statistics   
   SELECT * FROM dbo.fn_AssignedToMeApplicationCategories(@uId) AS ApplicationCategories;   
    
  IF @mode = 'MyTasks' 	     
  INSERT INTO @Statistics  
  SELECT * FROM dbo.fn_MyTasksApplicationCategories(@uId, @role) AS ApplicationCategories;  
 
  DECLARE @applicationCategories NVARCHAR(MAX);      
  SET @applicationCategories =      
  (    
   SELECT * FROM  
   (  
    SELECT Svc.Id AS serviceId,       
      Svc.name,       
      dbo.fn_multiLingualName(Svc.Id, @serviceTranslationKeyId) AS serviceName,  
      (   
       SELECT * From  
       (  
        SELECT Stg.id AS stageId,       
          Stg.Name AS stageName,     
          dbo.fn_multiLingualName(Stg.Id, @stageTranslationKeyId) AS stagesName,  
          (     
           SELECT StageStatusId stageStatusId,   
             StageStatusName stageStatusName,    
             dbo.fn_multiLingualName(StageStatusId, @statusesTranslationKeyId) AS statusesName,  
             StatusCount  
           From @Statistics  
           WHERE StageId=Stg.Id  
           FOR JSON PATH      
          ) AS stageStatuses      
        FROM service.Stages Stg      
        WHERE Stg.ServiceId = Svc.Id     
       ) Stg  
       WHERE Stg.stageStatuses is not null  
       FOR JSON PATH      
      ) AS stages      
    FROM service.Services Svc    
   ) Svc  
   WHERE stages is not null   
   FOR JSON PATH      
  );      
  
    
  SELECT '200' AS STATUS, @applicationCategories AS ApplicationCategories;   
    END;