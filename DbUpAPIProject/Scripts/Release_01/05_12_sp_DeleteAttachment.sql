
/****** Object:  StoredProcedure [dbo].[sp_DeleteAttachment]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeleteAttachment]
(
@attachmentId INT
)
AS
BEGIN

DECLARE @CurrentDate AS DATETIME    
SET @CurrentDate = GETDATE();   

BEGIN TRY
	BEGIN TRAN

	UPDATE application.ApplicationAttachments SET IsDeleted = 1, DeletedDate = @CurrentDate WHERE Id = @attachmentId


	SELECT @attachmentId AS Id, '200' AS Status, 'Success' as SuccessMessage; 
	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @message VARCHAR(4000);
	SELECT @message = ERROR_MESSAGE();
	SELECT @attachmentId AS Id, 500 as Status,@message as ErrorMessage;
END CATCH
END
GO