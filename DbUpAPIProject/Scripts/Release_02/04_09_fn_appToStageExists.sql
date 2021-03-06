
/****** Object:  UserDefinedFunction [dbo].[fn_appToStageExists]    Script Date: 10-02-2021 18:45:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_appToStageExists]
(
@stageActionId INT,
@stageid INT
)
RETURNS BIT
AS
BEGIN

	DECLARE @TostageId BIT = 0

	IF EXISTS        
        (        
            SELECT 1        
            FROM service.StageActions        
            WHERE Id = @stageActionId        
                  AND (ToStageID <> @stageid        
                  OR ToStageID IS NULL)      
        )        
            BEGIN        
                SET @TostageId = 1;        
        END;      

	RETURN @TostageId

END
