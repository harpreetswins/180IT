
/****** Object:  StoredProcedure [dbo].[sp_GetGroupsById]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_GetGroupsById 9092
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetGroupsById] @GroupId INT
AS
    BEGIN
        SELECT DISTINCT 
               G.Id AS GroupId, 
               ParentId, 
               OrderNumber, 
               ST.LanguageId, 
        (
            SELECT ST1.Value AS GroupTranslatedName
            FROM system.TranslationKeys STK1
                 INNER JOIN service.Translations ST1 ON ST1.TranslationKeyId = STK1.Id
                                                          AND STK1.Name = 'Groups'
            WHERE ST1.ItemId = G.Id
                  AND ST1.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS GroupName, 
        (
            SELECT ST2.Value AS GroupTranslatedDescription
            FROM system.TranslationKeys STK2
                 INNER JOIN service.Translations ST2 ON ST2.TranslationKeyId = STK2.Id
                                                          AND STK2.Name = 'Group Description'
            WHERE ST2.ItemId = G.Id
                  AND ST2.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS GroupDescription
        FROM service.Translations ST
             INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId
             INNER JOIN service.Groups G ON ST.ItemId = G.Id
        WHERE G.Id = @GroupId
              AND IsDeleted = 0;
    END;
GO