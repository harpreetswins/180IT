
/****** Object:  StoredProcedure [dbo].[sp_GetChildEntityFieldLookups]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetChildEntityFieldLookups] @formsectionparentid AS     INT,             
                                                  @languageid AS INT            
              ,@serviceid AS INT            
AS            
    BEGIN        
	DECLARE @lookupTranslationKeyId INT = 8;    
        SELECT DISTINCT SFSF.EntityFieldId,             
               SFSF.FormSectionId,             
               SEF.FieldTypeId,             
               SFT.Name AS FieldTypeName,             
          
      (SELECT LEFL.Value AS lookupId,        
                   STS.Value AS lookupValue,             
                   STS.ItemId AS LookupTranslationId,    
       LEFL.EntityFieldId AS EntityFieldId            
        
      FROM service.EntityFieldLookups LEFL         
      INNER JOIN service.Translations   STS  ON STS.ItemId =  LEFL.id        
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId          
     WHERE STS.ItemId = LEFL.id AND STK.Id = @lookupTranslationKeyId AND STS.LanguageId = @languageid AND LEFL.EntityFieldId = SFSF.EntityFieldId        
     FOR JSON PATH            
        ) AS entityData      
            
        FROM         service.FormSectionFields SFSF            
             INNER JOIN service.EntityFields SEF ON SEF.id = SFSF.EntityFieldId            
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId  
    INNER JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SFSF.EntityFieldId    
              
        WHERE SFSF.FormSectionParentId = @formsectionparentid AND SFSF.FormSectionId IS NULL;            
    END;
GO