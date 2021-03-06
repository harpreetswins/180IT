
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsDetail]    Script Date: 03-02-2021 15:14:50 ******/
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
@userId AS NVARCHAR(100),
@creatorName   NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int , @serviceTranslationKeyId INT= 11, @stageTranslationKeyId INT= 12, @statusesTranslationKeyId INT= 13  
EXEC @uId= sp_GetUserId @userId,@creatorName;  

        SELECT TOP 1 AA.ApplicationNumber AS ApplicationNumber, 
					 JSON_QUERY(dbo.fn_multiLingualName(SST.Id, @stageTranslationKeyId)) AS StageName, 
                     AA.ServiceId AS ServiceId, 
					 JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS ServiceName,
					 JSON_QUERY(dbo.fn_multiLingualName(ASS.Id, @statusesTranslationKeyId)) AS ApplicationStatus,
					 Null AS AssignedTo,
                     Null AS Notes,
                     Null AS Instructions
        FROM vw_ApplicationStagesOrderBy APS
             INNER JOIN application.Applications AA ON AA.Id = APS.ApplicationId
             INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
             INNER JOIN service.Stages SST ON SST.Id = APS.StageId
             INNER JOIN lookups.StageStatuses ASS ON ASS.Id = APS.StageStatusId
        WHERE APS.ApplicationId = @applicationid and APS.UserId = @uId;
        --ORDER BY APS.Id DESC;
    END;