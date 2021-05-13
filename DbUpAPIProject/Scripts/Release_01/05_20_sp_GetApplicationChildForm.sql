
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationChildForm]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetApplicationChildForm] @applicationid AS      INT,       
                                                   @entityid AS           INT,       
                                                   @formsectionfieldid AS INT      
AS      
    BEGIN      
	DECLARE @instructionsTranslationKeyId INT = 4, @FieldTranslationKeyId INT = 1, @formsectionfiledConstraintTranslationKeyId INT = 10;
      Declare @constraints NVARCHAR(MAX)  
  Set @constraints = (SELECT FSF.Id AS id,       
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
  ORDER BY SAFV.ItemIndex ASC FOR JSON PATH)  
  
  SELECT @constraints AS Constraints  
  
    END;
GO