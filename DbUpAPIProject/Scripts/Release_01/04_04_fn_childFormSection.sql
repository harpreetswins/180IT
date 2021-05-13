/****** Object:  UserDefinedFunction [dbo].[fn_childFormSection]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_childFormSection]
(@formId        INT, 
 @applicationid INT
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
		 DECLARE @formSectionTranslationKeyId INT = 3;
         DECLARE @formSection AS NVARCHAR(MAX);
         SET @formSection =
         (
             SELECT FS.OrderNumber AS formSectionOrder, 
                    'False' AS multipleRecords, 
                    dbo.fn_multiLingualName(FS.Id, @formSectionTranslationKeyId) AS formSectionName, 
                    dbo.fn_childFormSectionFields(FS.Id, @applicationid) AS formSectionFields, 
                    dbo.fn_formSectionAttachments(FS.Id, @applicationid) AS FormSectionAttachments
             FROM service.FormSections FS
             WHERE FS.Formid = @formId FOR JSON PATH
         );
         RETURN @formSection;
     END;
GO