
/****** Object:  StoredProcedure [dbo].[sp_GetRoleId]    Script Date: 27-01-2021 16:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec sp_GetRoleId 'NAD Program Manager,Admin'
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetRoleId] @Role NVARCHAR(100)
AS
    BEGIN
	DECLARE @temp TABLE (Roles VARCHAR(100));
	INSERT INTO @temp(Roles) SELECT Item FROM SplitString(@Role, ',');
	
	 Return SELECT Id FROM [service].[Roles] WHERE [Name] IN (SELECT Roles FROM @temp);

    END;



