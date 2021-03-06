
/****** Object:  UserDefinedFunction [dbo].[fn_ApplicationStageActionExist]    Script Date: 04-02-2021 19:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_ApplicationStageActionExist]
(
@applicationstageid INT,
@currentstageid INT,
@approveactiontype INT,
@rejectactiontype INT,
@rejectstatusid INT,
@completestatusid INT
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @exist BIT = 0

	IF EXISTS
        (
            SELECT 1
            FROM application.ApplicationStageActions AASA1
                 INNER JOIN service.StageActions SSA1 ON SSA1.Id = AASA1.StageActionId
                 INNER JOIN lookups.ActionTypes LAT ON LAT.Id = SSA1.ActionTypeId
            WHERE ApplicationStageId = @applicationstageid
                  AND StageId = @currentstageid
                  AND LAT.Id IN(@approveactiontype, @rejectactiontype)
				  
        )
		BEGIN
		SET @exist = 1
		END
		
		IF EXISTS
        (
            SELECT 1
            FROM application.ApplicationStages AAS2 Where AAS2.Id = @applicationstageid
                  AND AAS2.StageStatusId IN (@rejectstatusid, @completestatusid)
				  
        )
		BEGIN
		SET @exist = 1
		END
	-- Return the result of the function
	RETURN @exist

END
