  
ALTER VIEW [dbo].[vw_ApplicationStagesOrderBy]      
AS      
SELECT  Id, ApplicationId, UserId, StageId, CreatedOn, StageStatusId, PreviousAppStageId      
FROM            application.ApplicationStages   
ORDER BY Id DESC  
OFFSET 0 ROWS  