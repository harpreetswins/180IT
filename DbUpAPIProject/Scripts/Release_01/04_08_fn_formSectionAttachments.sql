
/****** Object:  UserDefinedFunction [dbo].[fn_formSectionAttachments]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date, ,>  
-- Description: <Description, ,>  
-- =============================================  
ALTER FUNCTION [dbo].[fn_formSectionAttachments]   
(@Id INT,  
@applicationid INT  
)  
RETURNS NVARCHAR(MAX)  
AS  
     BEGIN  
         DECLARE @FormSectionAttachments AS NVARCHAR(MAX), @attachmentConstraintTypesTranslationKeyId INT = 9, @AttachmentsTranslationKeyId INT = 6;  
         SET @FormSectionAttachments =  
         (  
             SELECT SFSA.Id AS FormSectionAttachmentId,   
                    SFSA.OrderNumber AS FormSectionAttachmentOrderNumber,   
                    SFSA.AttachmentId AS AttachmentId,   
                    SAT.Id AS AttachmentTypeId,   
                   JSON_QUERY(dbo.fn_attachmentFiles(SFSA.AttachmentId, @applicationid)) AS AttachmentFiles,   
                    JSON_QUERY(dbo.fn_attachmentConstraints(SFSA.Id,@attachmentConstraintTypesTranslationKeyId)) AS constraints,   
                    JSON_QUERY(dbo.fn_multiLingualName(SA.Id,@AttachmentsTranslationKeyId)) AS attachmentName  
             FROM service.FormSectionAttachments SFSA  
                  INNER JOIN service.Attachments SA ON SA.Id = SFSA.AttachmentId  
                  INNER JOIN lookups.AttachmentTypes SAT ON SAT.Id = SA.AttachmentTypeId  
             WHERE SFSA.FormSectionId = @Id FOR JSON PATH  
         );  
         RETURN @FormSectionAttachments;  
     END;
GO