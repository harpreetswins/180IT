
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationCurrentStage]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Neeraj Saini
-- Create date: 01 Dec, 2020
-- Description:	Get current application stage status.
-- =============================================

-- sp_GetApplicationCurrentStage 16

ALTER PROCEDURE [dbo].[sp_GetApplicationCurrentStage] @applicationid INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        SELECT TOP 1 ASS.Id, 
                     ASS.StageStatusId, 
                     ASA.StageActionId
        FROM application.ApplicationStages ASS
             LEFT JOIN application.ApplicationStageActions ASA ON ASA.ApplicationStageId = ASS.Id
        WHERE ASS.ApplicationId = @applicationid
        GROUP BY ASS.Id, 
                 ASS.StageStatusId, 
                 ASA.StageActionId
        ORDER BY ASS.Id DESC;
    END;
GO