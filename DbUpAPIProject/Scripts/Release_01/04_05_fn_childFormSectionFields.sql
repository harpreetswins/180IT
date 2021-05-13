/****** Object:  UserDefinedFunction [dbo].[fn_childFormSectionFields]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_childFormSectionFields]
(@Id            INT, 
 @applicationid INT
)
RETURNS NVARCHAR(4000)
AS
     BEGIN
          DECLARE @FormSectionFields AS NVARCHAR(4000), @instructionTranslationKeyId INT = 4, @fieldTranslationKeyId INT = 1, @formSectionFieldConstraintTranslationKeyId INT = 10;
         SET @FormSectionFields =
         (
             SELECT DISTINCT 
                    FSF.Id AS formSectionFieldid, 
                    FSF.OrderNumber AS formSectionFieldOrder, 
                    (CASE
                         WHEN MAX(SAFV.Value) IS NULL
                         THEN ''
                         ELSE MAX(SAFV.Value)
                     END) AS formSectionFieldValue, 
                    MAX(EF.Name) AS formSectionFieldNameKey, 
                    dbo.fn_entityRelationships(EF.Id) AS entityRelationships, 
                    dbo.fn_multiLingualName(EF.Id, @instructionTranslationKeyId) AS instructions, 
                    FT.Id AS fieldTypeId, 
                    MAX(FT.Name) AS formSectionFieldTypeName, 
                    EF.Id AS entityFieldId, 
                    dbo.fn_multiLingualName(EF.Id, @fieldTranslationKeyId) AS formSectionFieldName, 
                    dbo.fn_formSectionFieldConstraints(FSF.Id, @formSectionFieldConstraintTranslationKeyId) AS constraints
             FROM service.FormSectionFields FSF
                  INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId
                  INNER JOIN service.Translations ST ON ST.ItemId = EF.Id
                  INNER JOIN lookups.FieldTypes FT ON FT.Id = EF.FieldTypeId
                  LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = FSF.EntityFieldId
                                                                         AND SAFV.ApplicationId = @applicationid
                  LEFT JOIN service.EntityRelationships SER ON SER.EntityFieldId = EF.Id
             WHERE FSF.FormSectionParentId = @Id
                   AND FSF.ShowOnMainForm = 1
                   AND FSF.FormSectionParentId IS NOT NULL
             GROUP BY FSF.Id, 
                      FSF.OrderNumber, 
                      FT.Id, 
                      EF.Id FOR JSON PATH
         );
         RETURN @FormSectionFields;
     END;
GO