


-- sp_GetCascadedLookupValues 85,1247,1        
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
               Frm_Sction_Fld.EntityFieldId, 
               Frm_Sction_Fld.FormSectionId, 
               Ent_Fld.FieldTypeId, 
               Fld_Typ.Name AS FieldTypeName, 
               (CASE
                    WHEN Ent_Fld.Settings IS NULL
                    THEN
						(
							SELECT Ent_Fld_Lkup_Val.Value AS lookupId, 
								   Vw_Trans.Value AS lookupValue, 
								   Vw_Trans.ItemId AS LookupTranslationId, 
								   Ent_Fld_Lkup_Val.EntityFieldId AS EntityFieldId
							FROM service.EntityFieldLookups Ent_Fld_Lkup_Val
								 INNER JOIN [dbo].[vw_Translations] Vw_Trans ON Vw_Trans.ItemId = Ent_Fld_Lkup_Val.id
								 INNER JOIN system.TranslationKeys Trans_Key ON Trans_Key.Id = Vw_Trans.TranslationKeyId
							WHERE Trans_Key.Id = @lookupsTranslationKeyId
								  AND Vw_Trans.LanguageId = @LanguageId
								  AND Ent_Fld_Lkup_Val.ParentId = @ParentId FOR JSON PATH
						)
                    ELSE
						(
							SELECT Sys_Lookup.Id AS lookupId, 
								   Sys_Trans.Value AS lookupValue, 
								   Sys_Lookup.Name AS lookupFieldValue, 
								   Sys_Trans.ItemId AS LookupTranslationId, 
								   Ent_Fld.Id AS EntityFieldId
							FROM system.LookupValues Sys_Lookup
								 INNER JOIN [dbo].[vw_Translations] Sys_Trans ON Sys_Trans.ItemId = Sys_Lookup.id
								 INNER JOIN system.TranslationKeys Sys_Trans_Key ON Sys_Trans_Key.Id = Sys_Trans.TranslationKeyId
							WHERE Sys_Lookup.ParentId = CAST(@Value AS INT)
								  AND Sys_Trans_Key.Id = @systemLookupTranslationKeyId
								  AND Sys_Trans.LanguageId = @languageid
								  AND Sys_Lookup.LookupTypeId =
										(
											SELECT CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT)
											FROM service.EntityFields
											WHERE id = @EntityFieldId
										) FOR JSON PATH
						)
                END) AS entityData
			FROM service.EntityFields Ent_Fld
             INNER JOIN lookups.FieldTypes Fld_Typ ON Fld_Typ.Id = Ent_Fld.FieldTypeId
             INNER JOIN service.FormSectionFields Frm_Sction_Fld ON Frm_Sction_Fld.EntityFieldId = Ent_Fld.Id
             LEFT JOIN service.EntityFieldLookups Ent_Fld_Lkups ON Ent_Fld_Lkups.EntityFieldId = Ent_Fld.Id
                                                           AND Ent_Fld_Lkups.ParentId IS NOT NULL
			WHERE Ent_Fld.Id = @EntityFieldId;
    END;