-- =============================================          
-- Author:  <Author,,Name>          
-- Create date: <Create Date, ,>          
-- Description: <Description, ,>          
-- =============================================          
ALTER FUNCTION [dbo].[fn_formSectionFields]
(@Id            INT, 
 @applicationid INT
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @FormSectionFields AS NVARCHAR(MAX), @fieldTranslationKeyId INT= 1, @instructionTranslationKeyId INT= 4, @formSectionFieldConstraintTranslationKeyId INT= 10, @formid INT, @relationTypeFieldTypeId INT= 7;
         SELECT @formid = FormId
         FROM service.FormSections
         WHERE Id = @Id;
         SET @FormSectionFields =
         (
             SELECT DISTINCT 
                    EF.Id AS EntityFieldId, 
                    EF.Settings, 
                    FSF.Id AS formSectionFieldid, 
                    FSF.OrderNumber AS formSectionFieldOrder, 
						(CASE
							 WHEN EF.FieldTypeId = @relationTypeFieldTypeId
							 THEN(dbo.fn_FormFieldEntityExist(@formid, EF.Id))
							 ELSE NULL
						 END) AS relationType, 
						(CASE
							 WHEN MAX(SAFV.Value) IS NULL
							 THEN ''
							 ELSE MAX(SAFV.Value)
						 END) AS formSectionFieldValue, 
                    MAX(EF.Name) AS formSectionFieldNameKey, 
                    JSON_QUERY(dbo.fn_entityRelationships(EF.Id)) AS entityRelationships, 
                    JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @instructionTranslationKeyId)) AS instructions, 
                    FT.Id AS fieldTypeId, 
                    MAX(FT.Name) AS formSectionFieldTypeName, 
                    EF.Id AS entityFieldId, 
                    JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @fieldTranslationKeyId)) AS formSectionFieldName, 
                    JSON_QUERY(dbo.fn_formSectionFieldConstraints(FSF.Id, @formSectionFieldConstraintTranslationKeyId)) AS constraints,
					MAX(FSF.Settings) AS formSectionFieldSettings
             FROM service.FormSectionFields FSF
                  INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId
                  INNER JOIN service.Translations ST ON ST.ItemId = EF.Id
                  INNER JOIN lookups.FieldTypes FT ON FT.Id = EF.FieldTypeId
                  LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = FSF.EntityFieldId
                                                                       AND SAFV.ApplicationId = @applicationid
                  LEFT JOIN service.EntityRelationships SER ON SER.EntityFieldId = EF.Id
             WHERE FSF.FormSectionId = @Id
             GROUP BY FSF.Id, 
                      FSF.OrderNumber, 
                      FT.Id, 
                      EF.Id, 
                      EF.FieldTypeId, 
                      EF.Settings
             ORDER BY FSF.OrderNumber ASC FOR JSON PATH
         );
         RETURN @FormSectionFields;
     END;