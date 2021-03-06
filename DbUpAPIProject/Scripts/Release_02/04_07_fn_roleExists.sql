
/****** Object:  UserDefinedFunction [dbo].[fn_roleExists]    Script Date: 10-02-2021 18:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- SELECT 
-- =============================================
CREATE FUNCTION [dbo].[fn_roleExists] 
(
@currentStageId INT,
@role NVARCHAR(4000)
)
RETURNS BIT
AS
BEGIN

	DECLARE @yes AS BIT = 0
	DECLARE @Roles TABLE(Id VARCHAR(100));
	INSERT INTO @Roles(Id)
                SELECT Id
                FROM dbo.fn_GetRoleIds(@role);
	 IF EXISTS    
        (    
            SELECT SAR.RoleId    
            FROM service.StageActionRoles SAR    
                 INNER JOIN service.StageActions SA ON SA.Id = SAR.StageActionId    
            WHERE EXISTS    
            (    
                 SELECT Id FROM @Roles
            )    
                  AND SA.StageId = @currentStageId    
        )    
            BEGIN    
                SET @yes = 1;    
        END;    

	RETURN @yes

END
