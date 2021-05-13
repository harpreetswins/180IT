-- sp_GetCascadedLookupValues 57,1,1                    
ALTER PROCEDURE [dbo].[sp_GetCascadedLookupValues] @EntityFieldId INT,             
                                                    @Value         INT,             
                                                    @LanguageId    INT,      
             @LookupParentId INT            
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
                   
        (            
            SELECT Sys_Lookup.Value AS lookupValueId,    
       Sys_Lookup.Id AS lookupId,             
                   Sys_Trans.Value AS lookupValue,             
                   Sys_Lookup.Name AS lookupFieldValue,             
                   Sys_Trans.ItemId AS LookupTranslationId,             
                   Ent_Fld.Id AS EntityFieldId            
            FROM service.LookupValues Sys_Lookup            
                 INNER JOIN [dbo].[vw_Translations] Sys_Trans ON Sys_Trans.ItemId = Sys_Lookup.id            
                 INNER JOIN system.TranslationKeys Sys_Trans_Key ON Sys_Trans_Key.Id = Sys_Trans.TranslationKeyId            
            WHERE Sys_Lookup.ParentId = CAST(@LookupParentId AS INT)            
                  AND Sys_Trans_Key.Id = @systemLookupTranslationKeyId            
                  AND Sys_Trans.LanguageId = @languageid            
                  AND Sys_Lookup.LookupTypeId =            
            (            
                SELECT CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT)            
                FROM service.EntityFields            
                WHERE id = @EntityFieldId            
            ) FOR JSON PATH            
      ) AS entityData            
        FROM service.EntityFields Ent_Fld            
             INNER JOIN lookups.FieldTypes Fld_Typ ON Fld_Typ.Id = Ent_Fld.FieldTypeId            
             INNER JOIN service.FormSectionFields Frm_Sction_Fld ON Frm_Sction_Fld.EntityFieldId = Ent_Fld.Id            
            WHERE Ent_Fld.Id = @EntityFieldId;            
    END;  