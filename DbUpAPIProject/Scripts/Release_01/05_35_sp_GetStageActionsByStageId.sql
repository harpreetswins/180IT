
/****** Object:  StoredProcedure [dbo].[sp_GetStageActionsByStageId]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- sp_AddGroups       
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetStageActionsByStageId] @stageId INT
AS
    BEGIN
        SELECT SSA.ID AS StageActionId, 
               SSA.Name AS StageActionName, 
               SSA.OrderNumber AS OrderNumber, 
               SS.Name AS StageName, 
               SS1.Name AS DestinationStageName
        FROM service.StageActions SSA
             INNER JOIN service.Stages SS ON SS.Id = SSA.StageId
             LEFT JOIN service.Stages SS1 ON SS1.Id = SSA.ToStageId
        WHERE SSA.StageId = @stageid;
    END;
GO