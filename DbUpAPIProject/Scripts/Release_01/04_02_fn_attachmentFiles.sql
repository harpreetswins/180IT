/****** Object:  UserDefinedFunction [dbo].[fn_attachmentFiles]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_attachmentFiles]
(@attachmentId  INT, 
 @applicationid INT
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @AttachmentFiles AS NVARCHAR(MAX);
         SET @AttachmentFiles =
         (
             SELECT AAAA.Id AS id, 
                    AAAA.AttachmentId AS AttachmentId, 
                    AAAA.CreatorId AS CreatorId, 
                    AAAA.[FileName] AS [FileName], 
                    AAAA.Extension AS Extension, 
                    AAAA.Size AS Size, 
                    AAAA.MimeType AS MimeType
             FROM application.ApplicationAttachments AAAA
                  INNER JOIN service.Attachments ASAS ON ASAS.Id = AAAA.AttachmentId
             WHERE AAAA.AttachmentId = @attachmentId
                   AND AAAA.AppId = @applicationid
                   AND AAAA.IsDeleted = 0 FOR JSON PATH
         );
         RETURN @AttachmentFiles;
     END;
GO