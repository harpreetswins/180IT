
/****** Object:  StoredProcedure [dbo].[sp_GetAllLanguages]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetAllLanguages] 
AS
    BEGIN
        SELECT L.Id AS 'Id', 
               L.Name AS 'LanguageName',
			   L.Direction AS 'Direction'
        FROM system.Languages AS L
    END;
GO