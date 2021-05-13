/****** Object:  StoredProcedure [dbo].[sp_UploadAttachments]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UploadAttachments] @applicationId      INT, 
                                             @applicationStageId INT, 
                                             @attachmentTypeId   INT, 
                                             @attachmentId       INT, 
                                             @creatorId          NVARCHAR(100), 
                                             @image              VARBINARY(MAX), 
                                             @fileName           VARCHAR(100), 
                                             @extension          VARCHAR(20), 
                                             @size               DECIMAL(18, 0), 
                                             @mimeType           VARCHAR(50)
AS
    BEGIN
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @creatorid;
        DECLARE @applicationattachmentId INT;
        DECLARE @currentDate DATETIME;
        SET @currentDate = GETDATE();
        BEGIN TRY
            BEGIN TRAN;
            INSERT INTO application.ApplicationAttachments
            (AppId, 
             AppStageId, 
             AttachmentId, 
             CreatorId, 
             CreatedOn, 
             FileContents, 
             FileName, 
             Extension, 
             Size, 
             MimeType
            )
            VALUES
            (@applicationId, 
             @applicationStageId, 
             @attachmentId, 
             @uId, 
             @currentDate, 
             @image, 
             @fileName, 
             @extension, 
             @size, 
             @mimeType
            );
            SET @applicationattachmentId = SCOPE_IDENTITY();
            SELECT @applicationattachmentId AS Id, 
                   '200' AS STATUS, 
                   'Success' AS SuccessMessage;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            DECLARE @message VARCHAR(4000);
            SELECT @message = ERROR_MESSAGE();
            SELECT @applicationattachmentId AS Id, 
                   500 AS STATUS, 
                   @message AS ErrorMessage;
        END CATCH;
    END;
GO
