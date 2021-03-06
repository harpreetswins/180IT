
/****** Object:  StoredProcedure [admin].[sp_GetStagesByServiceId]    Script Date: 09-02-2021 19:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                  
-- Author:  <Author,,Name>                  
-- Create date: <Create Date,,>                  
-- Description: <Description,,>                  
-- admin.sp_GetStagesByServiceId 7                   
-- =============================================                  
ALTER PROCEDURE [admin].[sp_GetStagesByServiceId] @serviceid INT        
AS        
    BEGIN        
        DECLARE @translationkeyid AS INT = 12, @formtranslationkeyid AS INT = 2, @actiontranslationkeyid AS INT = 7;        
            
        
        SELECT SSS.Id AS StageId,         
        (        
            SELECT ST.LanguageId AS langId,         
                   ST.Value AS value        
            FROM service.Translations ST        
            WHERE ST.ItemId = SSS.Id        
                  AND ST.TranslationKeyId = @translationkeyid FOR JSON PATH        
        ) AS StageName,         
               SSS.OrderNumber AS OrderNumber,         
        (        
            SELECT Id AS StageTypeId,         
                   StageTypeName AS StageTypeName        
            FROM lookups.StageTypes        
            WHERE Id = LST.Id        
        FOR JSON PATH) AS StageTypeName,         
        (        
            SELECT SF.Id AS FormId,         
            (        
                SELECT ST.LanguageId AS langId,         
                       ST.Value AS value        
                FROM service.Translations ST        
                WHERE ST.ItemId = SF.Id        
                      AND ST.TranslationKeyId = @formtranslationkeyid FOR JSON PATH        
            ) AS FormName,         
                   SF.EntityId        
            FROM service.StageForms SSF        
                 INNER JOIN service.Forms SF ON SF.Id = SSF.FormId        
            WHERE SSF.StageId = SSS.Id        
            ORDER BY SSF.OrderNumber ASC FOR JSON PATH        
        ) AS Forms,         
        (        
            SELECT SSA.Id AS ActionId,         
                   (        
                SELECT ST.LanguageId AS langId,         
                       ST.Value AS value        
                FROM service.Translations ST        
                WHERE ST.ItemId = SSA.Id        
                      AND ST.TranslationKeyId = @actiontranslationkeyid FOR JSON PATH        
            )  AS StageActionName,      
   SSA.ActionTypeId,      
     SSA.ToStageID AS DestinationStageId,  
  (Select RoleId from service.StageActionRoles Where StageActionId = SSA.Id FOR JSON PATH) AS StageActionRoles   
            FROM service.StageActions SSA        
            WHERE SSA.StageId = SSS.Id FOR JSON PATH        
        ) AS Actions,
			   (SELECT Id, Name FROM [lookups].[FormModes] FOR JSON PATH) AS FormMode        
        FROM service.Stages SSS        
             INNER JOIN service.Services SS ON SS.Id = SSS.ServiceId        
             INNER JOIN lookups.StageTypes LST ON LST.Id = SSS.StageTypeId        
        WHERE SSS.ServiceId = @serviceid ORDER BY SSS.OrderNumber ASC;        
    END;
