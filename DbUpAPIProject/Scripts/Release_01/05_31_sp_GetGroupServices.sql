
/****** Object:  StoredProcedure [dbo].[sp_GetGroupServices]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetGroupServices      
ALTER PROCEDURE [dbo].[sp_GetGroupServices]        
AS        
    BEGIN    
	DECLARE @groupTranslationKeyId INT = 14, @serviceTranslationKeyId INT = 11, @serviceDescriptionTranslationKeyId INT = 16;
        SELECT a.ID,         
              -- a.Name,      
            (SELECT ST.Value AS value,         
                       ST.LanguageId AS langId        
                FROM service.Translations ST        
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId        
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId        
                WHERE ST.ItemId =  a.Id       
                      AND STK.Id = @groupTranslationKeyId FOR JSON PATH ) AS Name,        
               COALESCE(b.Name, '-') AS 'ParentName',  
      a.ParentId,         
               a.OrderNumber AS GroupOrder,         
        (        
            SELECT s.Id,         
                   s.Name,         
                   s.OrderNumber ,      
        (        
                SELECT ST.Value AS value,         
                       ST.LanguageId AS langId        
                FROM service.Translations ST        
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId        
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId        
                WHERE ST.ItemId = S.Id        
                      AND STK.Id = @serviceTranslationKeyId FOR JSON PATH        
            ) AS serviceName,  
   (        
                SELECT ST.Value AS value,         
                       ST.LanguageId AS langId        
                FROM service.Translations ST        
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId        
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId        
                WHERE ST.ItemId = S.Id        
                      AND STK.Id = @serviceDescriptionTranslationKeyId FOR JSON PATH        
            ) AS serviceDescription     
            FROM service.Services AS s        
            WHERE s.GroupId = a.Id AND s.IsDeleted = 0 AND s.IsProfile = 0  
   ORDER BY S.OrderNumber ASC FOR JSON PATH        
        ) AS Services        
        FROM service.Groups AS a        
             LEFT JOIN service.Groups AS b ON a.ParentID = b.Id WHERE a.IsDeleted = 0  
    ORDER BY a.OrderNumber ASC;        
    END;  
GO