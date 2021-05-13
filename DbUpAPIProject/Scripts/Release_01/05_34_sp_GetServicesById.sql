
/****** Object:  StoredProcedure [dbo].[sp_GetServicesById]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- sp_GetServicesById 6043      
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetServicesById] @ServiceId INT  
AS  
    BEGIN  
	DECLARE @serviceTranslationKeyId INT = 11, @serviceDescritionTranslationKeyId INT = 16;
        SELECT S.Id,   
               ST.LanguageId,   
        (  
            SELECT ST1.Value AS ServiceTranslatedName  
            FROM system.TranslationKeys STK1  
                 INNER JOIN service.Translations ST1 ON ST1.TranslationKeyId = STK1.Id  
                                                          AND STK1.Id = @serviceTranslationKeyId  
            WHERE ST1.ItemId = S.Id  
                  AND ST1.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER  
        ) AS ServiceName,   
        (  
            SELECT ST2.Value AS ServiceTranslatedDescription  
            FROM system.TranslationKeys STK2  
                 INNER JOIN service.Translations ST2 ON ST2.TranslationKeyId = STK2.Id  
                                                          AND STK2.Id = @serviceDescritionTranslationKeyId 
            WHERE ST2.ItemId = S.Id  
                  AND ST2.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER  
        ) AS ServiceDescription,   
               S.GroupId,   
               MAX(G.[Name]) AS GroupName,   
               S.OrderNumber,   
               S.StartStageID  
        FROM service.Translations ST  
             INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
             INNER JOIN service.Services S ON S.Id = ST.ItemId  
             INNER JOIN service.Groups G ON S.GroupId = G.Id  
        WHERE S.Id = @ServiceId  
              AND S.IsDeleted = 0  
        GROUP BY S.Id,   
                 ST.LanguageId,   
                 S.GroupId,   
                 S.OrderNumber,   
                 S.StartStageID;  
    END;  
GO