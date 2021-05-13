
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- admin.sp_AdminGetFormSectionsByFormId 9,9      
ALTER PROCEDURE [admin].[sp_AdminGetFormSectionsByFormId] @formid   INT, 
                                                          @entityid INT
AS
    BEGIN
        DECLARE @formsectionTranslationKeyId INT= 3, @entityfieldtranslationkeyid INT= 1, @attachmenttranslationkeyid INT= 6, @attachmentdescriptiontranslationkeyid INT= 21;
        SELECT Id, 
               Name, 
               dbo.fn_multiLingualName(Id, @formsectionTranslationKeyId) AS FormSectionName, 
						(
							SELECT SFSF.Id AS FormSectionFieldId, 
								   SFSF.EntityFieldId AS EntityFieldId, 
								   SEF.Name AS EntityFieldName, 
								   SEF.FieldTypeId AS FieldTypeId, 
								   dbo.fn_multiLingualName(SFSF.EntityFieldId, @entityfieldtranslationkeyid) AS EntityFieldNames, 
										(
											SELECT FFC.FieldConstraintTypeId, 
												   LFCT.Name AS Name, 
												   FFC.Settings
											FROM service.FormFieldConstraints FFC
												 INNER JOIN lookups.FieldConstraintTypes LFCT ON FFC.FieldConstraintTypeId = LFCT.Id
											WHERE FFC.FormSectionFieldId = SFSF.Id FOR JSON PATH
										) AS FormFieldConstraints
							FROM service.FormSectionFields SFSF
								 INNER JOIN service.EntityFields SEF ON SEF.Id = SFSF.EntityFieldId
							WHERE SFSF.FormSectionId = sf.Id
								  AND SEF.EntityId = @entityid FOR JSON PATH
						) AS FormSectionFields, 
						(
							SELECT EF.Id, 
								   dbo.fn_multiLingualName(EF.Id, @entityfieldtranslationkeyid) AS EntityFields
							FROM service.EntityFields EF FOR JSON PATH
						) AS EntityFields, 
						(
							SELECT SA.Id, 
								   SA.Name, 
								   SA.AttachmentTypeId, 
								   dbo.fn_multiLingualName(SA.Id, @attachmenttranslationkeyid) AS AttachmentNames, 
								   dbo.fn_multiLingualName(SA.Id, @attachmentdescriptiontranslationkeyid) AS AttachmentDescription
							FROM service.FormSections FS
								 INNER JOIN service.FormSectionAttachments FSA ON FSA.FormSectionId = FS.Id
								 INNER JOIN service.Attachments SA ON SA.Id = FSA.AttachmentId
							WHERE FSA.FormSectionId = sf.Id FOR JSON PATH
						) AS FormSectionAttachments
        FROM service.FormSections sf
        WHERE sf.FormId = @formid;
    END;