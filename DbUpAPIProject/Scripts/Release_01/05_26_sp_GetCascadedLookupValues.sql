
/****** Object:  StoredProcedure [dbo].[sp_GetCascadedLookupValues]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- sp_GetCascadedLookupValues 56,2,1
ALTER PROCEDURE [dbo].[sp_GetCascadedLookupValues] @EntityFieldId INT,   
                                                   @Value         INT,   
                                                   @LanguageId    INT  
AS  
    BEGIN  
        DECLARE @ParentId AS INT, @lookupsTranslationKeyId INT = 8;  
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
        (  
            SELECT LEFL.Value AS lookupId,   
                   STS.Value AS lookupValue,   
                   STS.ItemId AS LookupTranslationId,   
                   LEFL.EntityFieldId AS EntityFieldId  
            FROM service.EntityFieldLookups LEFL  
                 INNER JOIN service.Translations STS ON STS.ItemId = LEFL.id  
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId  
            WHERE STK.Id = @lookupsTranslationKeyId 
                  AND STS.LanguageId = @LanguageId  
                  AND LEFL.ParentId = @ParentId FOR JSON PATH  
        ) AS entityData  
        FROM service.EntityFieldLookups LEFLS  
             INNER JOIN service.EntityFields SEF ON SEF.Id = LEFLS.EntityFieldId  
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId  
             INNER JOIN service.FormSectionFields SFSF ON SFSF.EntityFieldId = SEF.Id  
        WHERE LEFLS.ParentId IS NOT NULL;  
    END;
GO