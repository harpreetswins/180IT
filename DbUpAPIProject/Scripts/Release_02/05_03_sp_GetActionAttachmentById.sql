
/****** Object:  StoredProcedure [dbo].[sp_GetActionAttachmentById]    Script Date: 29-01-2021 18:01:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- sp_GetActionAttachmentById 47  
-- =============================================  
CREATE PROCEDURE [dbo].[sp_GetActionAttachmentById] @actionattachmentId INT, @applicationid INT  
AS  
    BEGIN  
        SELECT AppId AS ApplicationId,   
               AppStageId AS ApplicationStageId, 
               FileContents AS FileName,   
               FileName AS Name,   
               Extension  
        FROM application.ActionAttachments  
        WHERE Id = @actionattachmentId AND 
		      AppId = @applicationid AND 
              IsDeleted = 0;  
    END;  