-- sp_GetChildEntityFieldLookups 71,1,null      
ALTER PROCEDURE [dbo].[sp_GetChildEntityFieldLookups] @formsectionparentid AS INT,     
                                                      @languageid AS          INT,     
                                                      @serviceid AS           INT    
AS    
    BEGIN    
        DECLARE @lookupTranslationKeyId INT= 8, @systemLookupTranslationKeyId INT= 18;    
        SELECT DISTINCT     
               SFSF.EntityFieldId,     
               SFSF.FormSectionId,     
               SEF.FieldTypeId,     
               SFT.Name AS FieldTypeName,      
                  
        (    
            SELECT SLV.Value AS lookupValueId,   
          SLV.Id AS lookupId,     
                   STS.Value AS lookupValue,     
                   SLV.Name AS lookupFieldValue,     
                   STS.ItemId AS LookupTranslationId,     
                   SEF.Id AS EntityFieldId    
            FROM system.LookupValues SLV    
                 INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id    
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId    
            WHERE STK.Id = @systemLookupTranslationKeyId    
                  AND STS.LanguageId = @languageid    
                  AND SLV.LookupTypeId =    
            (    
                SELECT CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT)    
                FROM service.EntityFields    
                WHERE id = SFSF.EntityFieldId    
            ) FOR JSON PATH    
        )  AS entityData    
        FROM service.FormSectionFields SFSF    
             INNER JOIN service.EntityFields SEF ON SEF.id = SFSF.EntityFieldId    
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId    
             LEFT JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SFSF.EntityFieldId    
        WHERE SFSF.FormSectionParentId = @formsectionparentid    
              AND SFSF.FormSectionId IS NULL;    
    END; 