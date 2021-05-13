
/****** Object:  StoredProcedure [dbo].[sp_GetAttachmentById]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_GetAttchmentById 47
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetAttachmentById] @attachmentId INT
AS
    BEGIN
        SELECT AppId AS ApplicationId, 
               AppStageId AS ApplicationStageId, 
               AttachmentId, 
               FileContents AS FileName, 
               FileName AS Name, 
               Extension
        FROM application.ApplicationAttachments
        WHERE Id = @attachmentId
              AND IsDeleted = 0;
    END;
GO