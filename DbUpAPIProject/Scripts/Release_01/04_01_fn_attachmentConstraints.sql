/****** Object:  UserDefinedFunction [dbo].[fn_attachmentConstraints]    Script Date: 21-01-2021 18:39:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date, ,>      
-- Description: <Description, ,>      
-- =============================================      
ALTER FUNCTION [dbo].[fn_attachmentConstraints]       
(@Id INT,      
@attachmentConstraintTypeTranslationKeyId VARCHAR(50)      
)      
RETURNS NVARCHAR(MAX)      
AS      
     BEGIN      
         DECLARE @constraints AS NVARCHAR(MAX);      
         SET @constraints =      
         (      
             SELECT SACT.Id AS constraintTypeId,       
                    SACT.Name AS typeName,       
                    SAC.Settings AS Settings,       
                    JSON_QUERY(dbo.fn_textMessages(SACT.Name)) AS textMessages,       
                    JSON_QUERY(dbo.fn_multiLingualName(SACT.Id,@attachmentConstraintTypeTranslationKeyId)) AS attachmentLabels      
             FROM service.AttachmentConstraints SAC      
                  INNER JOIN lookups.AttachmentConstraintTypes SACT ON SACT.Id = SAC.AttachmentConstraintTypeId      
             WHERE SAC.FormSectionAttachmentId = @Id FOR JSON PATH      
         );      
         RETURN @constraints;      
     END;  
GO
