
/****** Object:  StoredProcedure [admin].[sp_AdminGetFormSectionsByFormId]    Script Date: 04-02-2021 19:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- admin.sp_AdminGetFormSectionsByFormId 7,6
ALTER PROCEDURE [admin].[sp_AdminGetFormSectionsByFormId] @formid INT, @entityid INT
AS
    BEGIN
        DECLARE @formsectionTranslationKeyId INT= 3, @entityfieldtranslationkeyid INT = 1;
        SELECT Id, 
               Name, 
               dbo.fn_multiLingualName(Id, @formsectionTranslationKeyId) AS FormSectionName,
			   (Select SFSF.Id AS FormSectionFieldId,
			   SFSF.EntityFieldId AS EntityFieldId,
			   SEF.Name AS EntityFieldName,
			   SEF.FieldTypeId AS FieldTypeId,
			   dbo.fn_multiLingualName(SFSF.EntityFieldId, @entityfieldtranslationkeyid) AS EntityFieldNames 
			   from service.FormSectionFields SFSF
			   INNER JOIN service.EntityFields SEF ON SEF.Id = SFSF.EntityFieldId
			   Where SFSF.FormSectionId = sf.Id AND SEF.EntityId = @entityid
			   FOR JSON PATH) AS FormSectionFields,
			   (SELECT Id, Name FROM service.EntityFields WHERE EntityId = @entityid FOR JSON PATH) AS EntityFields,
			   (SELECT SA.Id, SA.Name FROM service.FormSections FS 
			   INNER JOIN service.FormSectionAttachments FSA ON FSA.FormSectionId = FS.Id
			   INNER JOIN service.Attachments SA ON SA.Id = FSA.AttachmentId
			   WHERE FSA.FormSectionId = sf.Id FOR JSON PATH) AS FormSectionAttachments
        FROM service.FormSections sf
        WHERE sf.FormId = @formid;
    END;




