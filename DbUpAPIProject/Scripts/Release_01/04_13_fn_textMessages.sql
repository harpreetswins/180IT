
/****** Object:  UserDefinedFunction [dbo].[fn_textMessages]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_textMessages]
(@Name VARCHAR(100)
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @textMessages AS NVARCHAR(MAX);
         SET @textMessages =
         (
             SELECT STRV.LanguageId AS langId, 
                    STRV.Value AS value
             FROM system.TextResourcesCategories STRC
                  INNER JOIN system.TextResourcesKeys STRK ON STRK.TextResourceCategoryId = STRC.Id
                  INNER JOIN system.TextResourceValues STRV ON STRV.TextResourcesKeyId = STRK.Id
             WHERE STRK.TextResourcesKeyName = @Name FOR JSON PATH
         );
         RETURN @textMessages;
     END;
GO