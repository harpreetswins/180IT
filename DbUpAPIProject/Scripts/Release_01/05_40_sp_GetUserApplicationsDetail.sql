
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsDetail]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  Neeraj  
-- Create date: 02 Dec,2020   
-- Description: Get User Applications   
-- exec sp_GetUserApplicationsDetail 16,
-- =============================================    

ALTER PROCEDURE [dbo].[sp_GetUserApplicationsDetail] @applicationid AS INT,
@userId AS NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int  
EXEC @uId= sp_GetUserId @userId  
--SELECT @uId;
--PRINT @uId
        SELECT TOP 1 AA.ApplicationNumber AS ApplicationNumber, 
                     SST.Name AS StageName, 
                     AA.ServiceId AS ServiceId, 
                     SS.Name AS ServiceName, 
                     ASS.Name AS ApplicationStatus,
					 Null AS AssignedTo,
                     Null AS Notes,
                     Null AS Instructions
        FROM application.ApplicationStages APS
             INNER JOIN application.Applications AA ON AA.Id = APS.ApplicationId
             INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
             INNER JOIN service.Stages SST ON SST.Id = APS.StageId
             INNER JOIN lookups.StageStatuses ASS ON ASS.Id = APS.StageStatusId
        WHERE APS.ApplicationId = @applicationid and APS.UserId = @uId
        ORDER BY APS.Id DESC;
    END;
GO