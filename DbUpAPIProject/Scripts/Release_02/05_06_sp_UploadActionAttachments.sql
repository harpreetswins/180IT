
/****** Object:  StoredProcedure [dbo].[sp_UploadActionAttachments]    Script Date: 29-01-2021 18:04:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UploadActionAttachments] @applicationId      INT,   
											@applicationStageId INT,
											@actionTypeId		INT,
											@appStageActionId   INT,  
											@creatorId          NVARCHAR(100), 
											@image              VARBINARY(MAX),
											@fileName           VARCHAR(100),  
											@extension          VARCHAR(20),   
											@size               DECIMAL(18, 0),
											@mimeType           VARCHAR(50),
											@itemIndex          INT


AS
BEGIN
	
	DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @creatorid;  
        DECLARE @actionAttachmentId INT;  
        DECLARE @currentDate DATETIME;  
        SET @currentDate = GETDATE();  
        BEGIN TRY  
            BEGIN TRAN;  
            INSERT INTO application.ActionAttachments  
            (AppId, AppStageId, ActionTypeId, AppStageActionId, CreatorId, CreatedOn, FileContents, FileName, Extension, Size, MimeType, ItemIndex)  
            VALUES  
            (@applicationId, @applicationStageId, @actionTypeId, null, @uId, @currentDate, @image, @fileName, @extension, @size, @mimeType, @itemIndex);  
            SET @actionAttachmentId = SCOPE_IDENTITY();  
		    SELECT @actionAttachmentId AS Id,   
                   '200' AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
		 BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @actionAttachmentId AS Id,   
                   '500' AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
END
