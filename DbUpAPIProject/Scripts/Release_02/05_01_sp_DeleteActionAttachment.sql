
/****** Object:  StoredProcedure [dbo].[sp_DeleteActionAttachment]    Script Date: 29-01-2021 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- sp_DeleteActionAttachment 
-- =============================================  
CREATE PROCEDURE [dbo].[sp_DeleteActionAttachment]  
(  
@actionattachmentId INT,
@applicationid INT
)  
AS  
BEGIN  
  
DECLARE @CurrentDate AS DATETIME      
SET @CurrentDate = GETDATE();     
  
BEGIN TRY  
 BEGIN TRAN  
  
 UPDATE application.ActionAttachments SET IsDeleted = 1, DeletedDate = @CurrentDate WHERE Id = @actionattachmentId  AND AppId = @applicationid
  
  
 SELECT @actionattachmentId AS Id, '200' AS Status, 'Success' as SuccessMessage;   
 COMMIT TRANSACTION  
END TRY  
  
BEGIN CATCH  
 ROLLBACK TRANSACTION  
 DECLARE @message VARCHAR(4000);  
 SELECT @message = ERROR_MESSAGE();  
 SELECT @actionattachmentId AS Id, 500 as Status,@message as ErrorMessage;  
END CATCH  
END  