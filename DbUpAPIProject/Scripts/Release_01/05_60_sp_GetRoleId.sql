
/****** Object:  StoredProcedure [dbo].[sp_GetRoleId]    Script Date: 22-01-2021 21:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec sp_GetRoleId 'NAD Program Manager'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRoleId] @Role NVARCHAR(100)
AS
    BEGIN
        DECLARE @Id INT;
        SET @Id =
        (
            SELECT Id
            FROM [service].[Roles]
            WHERE [Name] = @Role
        );
        RETURN @Id;
    END;
