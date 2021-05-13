/****** Object:  UserDefinedFunction [dbo].[fn_attachmentLabels]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_attachmentLabels]
(@Id   INT, 
 @translationKeyId INT
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @attachmentLabels AS NVARCHAR(MAX);
         SET @attachmentLabels =
         (
             SELECT ST.Value AS value, 
                    ST.LanguageId AS langId
             FROM service.Translations ST
                  INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId
                  INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId
             WHERE ST.ItemId = @Id
                   AND STK.Id = @translationKeyId FOR JSON PATH
         );
         RETURN @attachmentLabels;
     END;
GO