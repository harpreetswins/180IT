
/****** Object:  UserDefinedFunction [dbo].[fn_stageActions]    Script Date: 25-01-2021 21:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  <Author,,Name>        
-- Create date: <Create Date, ,>        
-- Description: <Description, ,>        
-- =============================================        
ALTER FUNCTION [dbo].[fn_stageActions]  
(@stageId INT,
@roleId INT,
@isOwner BIT
)  
RETURNS NVARCHAR(MAX)  
AS  
     BEGIN  
         DECLARE @Actions AS NVARCHAR(MAX), @stageActionsTranslationKeyId INT = 7;  
         SET @Actions =  
         (  
             SELECT SAs.Id AS stageActionId,   
                    SAs.OrderNumber AS stageOrder,   
                    LAT.Name AS stageActionTypeName,   
                    LAT.Id AS stageActionTypeId,   
                    JSON_QUERY(dbo.fn_multiLingualName(Sas.Id, @stageActionsTranslationKeyId)) AS StageActionName  
             FROM service.StageActions SAs  
                  INNER JOIN lookups.ActionTypes LAT ON LAT.Id = SAs.ActionTypeId  
                  INNER JOIN service.Stages SSS ON SSS.Id = SAs.StageId  
                  INNER JOIN lookups.StageTypes ST ON ST.Id = SSS.StageTypeId  
				  INNER JOIN service.StageActionRoles SAR ON SAR.StageActionId = SAs.Id
				  INNER JOIN service.Roles SR ON SR.Id = SAR.RoleId
             WHERE SAs.StageId = @stageId AND (SAR.RoleId = @roleId OR (SR.Name = 'Owner' and @isOwner = 1)) FOR JSON PATH  
         );  
         RETURN @Actions;  
     END;