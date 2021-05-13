
/****** Object:  UserDefinedFunction [dbo].[fn_formSection]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date, ,>    
-- Description: <Description, ,>    
-- =============================================    
ALTER FUNCTION [dbo].[fn_formSection]    
(@formId INT,    
@applicationid INT    
)    
RETURNS NVARCHAR(MAX)    
AS    
     BEGIN    
         DECLARE @formSection AS NVARCHAR(MAX), @formsectionTranslationKeyId INT = 3;    
         SET @formSection =    
         (    
             SELECT FS.OrderNumber AS formSectionOrder,     
                    'False' AS multipleRecords,     
                    JSON_QUERY(dbo.fn_multiLingualName(FS.Id, @formsectionTranslationKeyId)) AS formSectionName,     
                    JSON_QUERY(dbo.fn_formSectionFields(FS.Id, @applicationid)) AS formSectionFields,     
                    JSON_QUERY(dbo.fn_formSectionAttachments(FS.Id, @applicationid)) AS FormSectionAttachments    
             FROM service.FormSections FS    
             WHERE FS.Formid = @formId
			 ORDER BY FS.OrderNumber ASC FOR JSON PATH    
         );    
         RETURN @formSection;    
     END;
GO