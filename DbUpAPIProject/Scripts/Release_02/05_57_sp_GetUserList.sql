
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 09-02-2021 11:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_GetUserList
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserList] 

AS
BEGIN
	
	SELECT Id, ExternalId, UserName FROM application.Users WHERE UserName IS NOT NULL

END
