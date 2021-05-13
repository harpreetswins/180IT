
/****** Object:  StoredProcedure [dbo].[sp_CheckCurrentApplicationStatus]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,> 
-- exec [sp_CheckCurrentApplicationStatus] 1,1
-- =============================================
ALTER PROCEDURE [dbo].[sp_CheckCurrentApplicationStatus] @applicationid INT, @userid AS NVARCHAR(100)
AS
    BEGIN

	DECLARE  @uId int  
    EXEC @uId= sp_GetUserId @userId 

        SELECT TOP 1 ASS.Name AS statusName
        FROM application.ApplicationStages AAS
		INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
             INNER JOIN application.StageStatuses ASS ON ASS.Id = AAS.StageStatusId
        WHERE AAS.ApplicationId = @applicationid AND AA.CreatorId = @uId
        ORDER BY AAS.Id DESC;
    END;
GO