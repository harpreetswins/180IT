
/****** Object:  View [dbo].[vw_ApplicationStagesOrderBy]    Script Date: 05-02-2021 19:43:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vw_ApplicationStagesOrderBy]    
AS    
SELECT  Id, ApplicationId, UserId, StageId, CreatedOn, StageStatusId, PreviousStageId    
FROM            application.ApplicationStages 
ORDER BY Id DESC
OFFSET 0 ROWS
GO


