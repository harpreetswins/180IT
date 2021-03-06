
/****** Object:  StoredProcedure [admin].[sp_GetLookupFieldTypes]    Script Date: 04-02-2021 15:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [admin].[sp_GetLookupFieldTypes]
-- =============================================
CREATE PROCEDURE [admin].[sp_GetLookupFieldTypes]

AS
BEGIN
	DECLARE @fieldType NVARCHAR(800), @attachmentType NVARCHAR(800)
	SET @fieldType = (SELECT Id, [Name] FROM lookups.FieldTypes FOR JSON PATH)
	SET @attachmentType = (SELECT Id,[Name] FROM lookups.AttachmentTypes FOR JSON PATH)
	SELECT @fieldType AS FieldTypes, @attachmentType AS AttachmentTypes
END
