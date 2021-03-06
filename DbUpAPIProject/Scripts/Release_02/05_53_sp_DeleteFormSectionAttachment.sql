
/****** Object:  StoredProcedure [admin].[sp_DeleteFormSectionAttachment]    Script Date: 08-02-2021 16:24:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [admin].[sp_DeleteFormSectionAttachment]
@attachmentId INT,
@formSectionId INT

AS
BEGIN

BEGIN TRY
BEGIN TRAN

DECLARE @formSectionAttachmentTranslationKeyId INT = 6, @formSectionAttachmentsId INT;

SET @formSectionAttachmentsId = (SELECT Id FROM [service].[FormSectionAttachments] WHERE FormSectionId = @formSectionId AND AttachmentId = @attachmentId)

DELETE FROM [service].[Translations] WHERE TranslationKeyId = @formSectionAttachmentTranslationKeyId AND ItemId = @attachmentId

DELETE FROM [service].[FormSectionAttachments] WHERE FormSectionId = @formSectionId AND AttachmentId = @attachmentId

Update [service].[FormSectionAttachments] SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From [service].[FormSectionAttachments] Where Id = @formSectionAttachmentsId) 

DELETE FROM [service].[Attachments] WHERE Id = @attachmentId;

SELECT @attachmentId AS Id,
		200 AS STATUS, 
        'Success' AS Message;

COMMIT TRANSACTION
END TRY

BEGIN CATCH
SELECT @attachmentId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
END CATCH


END
