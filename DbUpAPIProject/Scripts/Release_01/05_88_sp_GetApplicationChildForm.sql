
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationChildForm]    Script Date: 28-01-2021 19:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetApplicationChildForm 64,null,71  
ALTER PROCEDURE [dbo].[sp_GetApplicationChildForm] @applicationid AS      INT, 
                                                    @entityid AS           INT, 
                                                    @formsectionfieldid AS INT
AS
    BEGIN
        DECLARE @instructionsTranslationKeyId INT= 4, @FieldTranslationKeyId INT= 1, @formsectionfiledConstraintTranslationKeyId INT= 10, @attachmentConstraintTypesTranslationKeyId INT= 9, @AttachmentsTranslationKeyId INT= 6, @currentstageid INT;
        SELECT TOP 1 @currentstageid = StageId
        FROM application.ApplicationStages
        WHERE ApplicationId = @applicationid
        ORDER BY 1 DESC;
        DECLARE @constraints NVARCHAR(MAX);
        SET @constraints =
        (
            SELECT
            (
                SELECT FSF.Id AS id, 
                       FSF.EntityFieldId AS entityFieldId,
                       CASE
                           WHEN ISNULL(FSF.ShowOnMainForm, 0) = 0
                           THEN 'Hide'
                           ELSE 'Show'
                       END AS showOnMainForm, 
                       MAX(EF.Name) AS formSectionFieldNameKey, 
                       JSON_QUERY(dbo.fn_entityRelationships(EF.Id)) AS entityRelationships, 
                       JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @instructionsTranslationKeyId)) AS instructions, 
                       (CASE
                            WHEN MAX(SAFV.Value) IS NULL
                            THEN ''
                            ELSE MAX(SAFV.Value)
                        END) AS formSectionFieldValue, 
                       SAFV.ItemIndex AS itemIndex, 
                       FT.Id AS fieldTypeId,               
            --MAX(EF.Name) AS formSectionFieldNameKey,               
                       JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @FieldTranslationKeyId)) AS formSectionFieldName, 
                       JSON_QUERY(dbo.fn_formSectionFieldConstraints(FSF.Id, @formsectionfiledConstraintTranslationKeyId)) AS constraints
                FROM service.FormSectionFields FSF
                     INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId
                     INNER JOIN lookups.FieldTypes FT ON FT.Id = EF.FieldTypeId
                     LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = FSF.EntityFieldId
                                                                          AND SAFV.ApplicationId = @applicationid
                     LEFT JOIN service.EntityRelationships SER ON SER.EntityFieldId = EF.Id
                WHERE FSF.FormSectionParentId = @formsectionfieldid
                      AND FSF.FormSectionParentId IS NOT NULL
                GROUP BY FSF.Id, 
                         FSF.EntityFieldId, 
                         FSF.OrderNumber, 
                         FT.Id, 
                         EF.Id, 
                         FSF.FormSectionId, 
                         FSF.ShowOnMainForm, 
                         SAFV.ItemIndex
                ORDER BY SAFV.ItemIndex ASC FOR JSON PATH
            ) AS Fields, 
            (
                SELECT SFSA.Id AS FormSectionAttachmentId, 
                       SFSA.OrderNumber AS FormSectionAttachmentOrderNumber, 
                       SFSA.AttachmentId AS AttachmentId, 
                       SAT.Id AS AttachmentTypeId, 
                       JSON_QUERY(dbo.fn_attachmentFiles(SFSA.AttachmentId, @applicationid)) AS AttachmentFiles, 
                       JSON_QUERY(dbo.fn_attachmentConstraints(SFSA.Id, @attachmentConstraintTypesTranslationKeyId)) AS constraints, 
                       JSON_QUERY(dbo.fn_multiLingualName(SA.Id, @AttachmentsTranslationKeyId)) AS attachmentName, 
                (
                    SELECT AAA.FileContents, 
                           AAA.FileName, 
                           AAA.Extension,
						   AAA.ItemIndex
                    FROM application.ApplicationAttachments AAA
                    WHERE AAA.AppId = @applicationid
                          AND AAA.AttachmentId = SFSA.AttachmentId
                          AND AAA.AppStageId = @currentstageid
						  AND AAA.IsDeleted = 0 FOR JSON PATH
                ) AS applicationAttachment
                FROM service.FormSectionAttachments SFSA
                     INNER JOIN service.Attachments SA ON SA.Id = SFSA.AttachmentId
                     INNER JOIN lookups.AttachmentTypes SAT ON SAT.Id = SA.AttachmentTypeId
                WHERE SFSA.FormSectionFieldId = @formsectionfieldid FOR JSON PATH
            ) AS FormSectionAttachments FOR JSON PATH
        );
        SELECT @constraints AS Constraints;
    END;