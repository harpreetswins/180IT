
/****** Object:  StoredProcedure [dbo].[sp_GetResourceKeyValues]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetResourceKeyValues 'Menu,Button', 1
ALTER PROCEDURE [dbo].[sp_GetResourceKeyValues] @categoryname VARCHAR(100) = 'Menu,Button', 
                                                @languageid   INT          = 1
AS
    BEGIN
        DECLARE @data NVARCHAR(MAX), @delimiter NVARCHAR(5);
        SET @data = @categoryname;
        SET @delimiter = ',';
        DECLARE @textXML XML;
        -- SELECT @textXML = CAST('<d>' + REPLACE(@data, @delimiter, '</d><d>') + '</d>' AS XML);
        SELECT @textXML = CONVERT(XML, '<d>' + REPLACE(@data, @delimiter, '</d><d>') + '</d>');
        DECLARE @temp TABLE(Category VARCHAR(100));
        INSERT INTO @temp
               SELECT T.split.value('.', 'nvarchar(max)') AS data
               FROM @textXML.nodes('/d') T(split);
        SELECT TRV.Id AS 'Id', 
               TRK.TextresourcesKeyName AS 'Key', 
               TRV.Value AS 'Value', 
               TRC.TextResourceCategoryName AS 'Category'
        FROM system.TextResourceValues AS TRV
             INNER JOIN system.TextResourcesKeys AS TRK ON TRK.Id = TRV.TextResourcesKeyId
             INNER JOIN system.TextResourcesCategories AS TRC ON TRC.Id = TRK.TextResourceCategoryId
             INNER JOIN system.Languages AS L ON L.Id = TRV.LanguageId
        WHERE TRC.TextResourceCategoryName IN
        (
            SELECT Category
            FROM @temp
        )
              AND TRV.LanguageId = @languageid;
    END;
GO