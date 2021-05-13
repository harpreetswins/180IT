-- =============================================                                      
-- Author:  <Author,,Name>                                      
-- Create date: <Create Date,,>                                      
-- Description: <Description,,>                                      
-- sp_GetSearchRelatedRecords 125,'09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','Sanjay'                                     
-- =============================================                                      
ALTER PROCEDURE [dbo].[sp_GetSearchRelatedRecords] @FormSectionFieldId INT,   
                                                   @CreatorId          NVARCHAR(100),   
                                                   @creatorName        NVARCHAR(100)  
AS  
    BEGIN  
        DECLARE @serviceId INT, @uId INT, @serviceTranslationKeyId INT= 11, @fieldTranslationKeyId INT= 1, @closeStatusTranslationKeyId INT= 2, @systemLookupTranslationKeyId INT= 18, @lookupsTranslationKeyId INT= 8, @lookupFieldTypeId INT= 5, @relationFieldTypeId INT = 7, @relationEntityFieldId INT, @fromEntityId INT;  
        EXEC @uId = sp_GetUserId   
             @CreatorId,   
             @creatorName;  
        DECLARE @RelatedData NVARCHAR(MAX);  
        SELECT @serviceId = (CAST(JSON_VALUE(Settings, '$.serviceIds[0]') AS INT)) ,
		@relationEntityFieldId = EntityFieldId 
        FROM service.FormSectionFields  
        WHERE Id = @FormSectionFieldId;  
		Select @fromEntityId = relation.FromEntityId from service.EntityRelationships relation
		INNER JOIN service.EntityFields entity_Fld ON relation.EntityFieldId = entity_Fld.Id
		INNER JOIN lookups.FieldTypes fld_type ON entity_Fld.FieldTypeId = fld_type.Id
		Where relation.EntityFieldId = @relationEntityFieldId AND entity_Fld.FieldTypeId = @relationFieldTypeId
        DECLARE @Statistics TABLE  
        (AppId           INT,   
         StageId         INT,   
         StageStatusId   INT,   
         StageStatusName NVARCHAR(50)  
        );  
        INSERT INTO @Statistics  
               SELECT *  
               FROM dbo.fn_MyApplicationDetails(@uId, @serviceId);  
        SET @RelatedData =  
        (  
            SELECT AppId AS ApplicationId,   
                   @serviceId AS ServiceId,   
                   JSON_QUERY(dbo.fn_multiLingualName(@serviceId, @serviceTranslationKeyId)) AS serviceName,   
            (  
                SELECT SFSF.EntityFieldId,   
                       EF.FieldTypeId,  
                       CASE  
                           WHEN ISNULL(SFSF.ShowOnMainForm, 0) = 0  
                           THEN 'Hide'  
                           ELSE 'Show'  
                       END AS showOnMainForm,   
                (  
                    SELECT STS.Value AS value,   
                           STS.LanguageId AS langId  
                    FROM service.LookupValues SLV  
                         INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id  
                         INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId  
                    WHERE SLV.Value = CAST(SAFV.Value AS INT)  
                          AND STK.Id = @systemLookupTranslationKeyId  
                          AND SLV.LookupTypeId =  
                    (  
                        SELECT CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT)  
                        FROM service.EntityFields  
                        WHERE id = SFSF.EntityFieldId  
                    )  
                          AND EF.FieldTypeId = @lookupFieldTypeId FOR JSON PATH  
                ) AS lookupValues,   
                       (CASE  
                            WHEN MAX(SAFV.Value) IS NULL  
                            THEN ''  
                            ELSE MAX(SAFV.Value)  
                        END) AS formSectionFieldValue,   
                       JSON_QUERY(dbo.fn_multiLingualName(SFSF.EntityFieldId, @fieldTranslationKeyId)) AS formSectionFieldName  
                FROM service.FormSectionFields SFSF  
                     INNER JOIN service.EntityFields EF ON EF.Id = SFSF.EntityFieldId  
                     LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = SFSF.EntityFieldId  
                                                                          AND SAFV.ApplicationId = Stats_Detail.AppId  
                WHERE EF.EntityId = @fromEntityId  
                GROUP BY SFSF.EntityFieldId,   
                         EF.FieldTypeId,   
                         SAFV.Value,   
                         SFSF.OrderNumber,   
                         SFSF.ShowOnMainForm  
                ORDER BY SFSF.OrderNumber ASC FOR JSON PATH  
            ) AS Fields  
            FROM @Statistics AS Stats_Detail FOR JSON PATH  
        );  
        SELECT @RelatedData AS RelatedData;  
    END;  