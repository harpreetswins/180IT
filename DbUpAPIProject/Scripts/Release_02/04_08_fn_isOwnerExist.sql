
/****** Object:  UserDefinedFunction [dbo].[fn_isOwnerExist]    Script Date: 10-02-2021 18:44:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_isOwnerExist]
(
@applicationid INT,
@uId INT
)
RETURNS BIT
AS
BEGIN

	DECLARE @isOwner BIT = 0

	IF(    
        (    
            SELECT TOP 1 CreatorId    
            FROM application.Applications    
            WHERE Id = @applicationid    
        ) = @uId)    
            BEGIN    
                SET @isOwner = 1;    
			END;   

	RETURN @isOwner

END
