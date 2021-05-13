--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- sp_GetCascadedLookupValues 56,91,1      
ALTER PROCEDURE [dbo].[sp_GetCascadedLookupValues] @EntityFieldId INT, 
                                                   @Value         INT, 
                                                   @LanguageId    INT
AS
    BEGIN
        DECLARE @ParentId AS INT, @lookupsTranslationKeyId INT= 8, @systemLookupTranslationKeyId INT= 18;
        SET @ParentId =
        (
            SELECT Id
            FROM service.EntityFieldLookups
            WHERE Value = @Value
                  AND EntityFieldId = @EntityFieldId
        );
        SELECT DISTINCT 
               SFSF.EntityFieldId, 
               SFSF.FormSectionId, 
               SEF.FieldTypeId, 
               SFT.Name AS FieldTypeName, 
               (CASE
                    WHEN SEF.Settings IS NULL
                    THEN
        (
            SELECT LEFL.Value AS lookupId, 
                   STS.Value AS lookupValue, 
                   STS.ItemId AS LookupTranslationId, 
                   LEFL.EntityFieldId AS EntityFieldId
            FROM service.EntityFieldLookups LEFL
                 INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = LEFL.id
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId
            WHERE STK.Id = @lookupsTranslationKeyId
                  AND STS.LanguageId = @LanguageId
                  AND LEFL.ParentId = @ParentId FOR JSON PATH
        )
                    ELSE
        (
            SELECT SLV.Id AS lookupId, 
                   STS.Value AS lookupValue, 
                   SLV.Name AS lookupFieldValue, 
                   STS.ItemId AS LookupTranslationId, 
                   SEF.Id AS EntityFieldId
            FROM system.LookupValues SLV
                 INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId
            WHERE SLV.ParentId = @Value
                  AND STK.Id = @systemLookupTranslationKeyId
                  AND STS.LanguageId = @languageid
                  AND SLV.LookupTypeId =
            (
                SELECT CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT)
                FROM service.EntityFields
                WHERE id = @EntityFieldId
            ) FOR JSON PATH
        )
                END) AS entityData
        FROM service.EntityFields SEF
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId
             INNER JOIN service.FormSectionFields SFSF ON SFSF.EntityFieldId = SEF.Id
             LEFT JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SEF.Id
                                                           AND LEFLS.ParentId IS NOT NULL
        WHERE SEF.Id = @EntityFieldId;
    END;