
/****** Object:  UserDefinedFunction [dbo].[fn_appNextStageAvailability]    Script Date: 10-02-2021 18:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_appNextStageAvailability]
(
@stageActionId INT,
@stageid INT
)
RETURNS BIT
AS
BEGIN

	DECLARE @nextstageavailability BIT = 0

	IF EXISTS        
        (        
            SELECT 1        
            FROM service.StageActions        
            WHERE Id = @stageActionId        
                  AND ToStageID <> @stageid        
                  AND ToStageID IS NOT NULL        
        )        
            BEGIN        
                SET @nextstageavailability = 1;        
        END; 


	RETURN @nextstageavailability

END
