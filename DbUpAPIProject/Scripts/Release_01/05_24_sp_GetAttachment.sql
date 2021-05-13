
/****** Object:  StoredProcedure [dbo].[sp_GetAttachment]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetAttachment] @applicationId      INT, 
                                         @applicationStageId INT, 
                                         @attachmentId       INT
AS
    BEGIN
        SELECT AppId AS ApplicationId, 
               AppStageId AS ApplicationStageId, 
               AttachmentId, 
               FileContents AS FileName, 
               FileName AS Name, 
               Extension
        FROM application.ApplicationAttachments
        WHERE AppId = @applicationId
              AND AppStageId = @applicationStageId
              AND AttachmentId = @attachmentId
              AND IsDeleted = 0;
    END;
GO