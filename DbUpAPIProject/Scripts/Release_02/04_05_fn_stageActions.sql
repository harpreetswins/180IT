
/****** Object:  UserDefinedFunction [dbo].[fn_stageActions]    Script Date: 08-02-2021 16:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  <Author,,Name>            
-- Create date: <Create Date, ,>            
-- Description: <Description, ,>       
-- SELECT dbo.fn_stageActions(16,'NAD Program Manager',1)    
-- =============================================            
ALTER FUNCTION [dbo].[fn_stageActions]      
(@stageId INT,    
@roleId NVARCHAR(100),    
@isOwner BIT    
)      
RETURNS NVARCHAR(MAX)      
AS      
     BEGIN      
  DECLARE @tempRoles TABLE (Roles VARCHAR(100));    
  INSERT INTO @tempRoles(Roles) SELECT Item FROM SplitString(@roleId, ',');    
   DECLARE @Actions AS NVARCHAR(MAX), @stageActionsTranslationKeyId INT = 7 , @saveactiontypeid INT = 1, @submitactiontypeid INT = 2;      
         SET @Actions =      
         (      
             SELECT DISTINCT SAs.Id AS stageActionId,       
                    SAs.OrderNumber AS stageOrder,       
                    LAT.Name AS stageActionTypeName,       
                    LAT.Id AS stageActionTypeId,       
                    JSON_QUERY(dbo.fn_multiLingualName(SAs.Id, @stageActionsTranslationKeyId)) AS StageActionName      
             FROM service.StageActions SAs      
                  INNER JOIN lookups.ActionTypes LAT ON LAT.Id = SAs.ActionTypeId      
                  INNER JOIN service.Stages SSS ON SSS.Id = SAs.StageId      
                  INNER JOIN lookups.StageTypes ST ON ST.Id = SSS.StageTypeId      
      LEFT JOIN service.StageActionRoles SAR ON SAR.StageActionId = SAs.Id    
      LEFT JOIN service.Roles SR ON SR.Id = SAR.RoleId    
             WHERE SAs.StageId = @stageId AND (SAR.RoleId IN (Select Id From service.roles Where Name IN (Select Roles From @tempRoles)) -- OR (SR.Name = 'Owner' OR @isOwner = 1)  
    OR (@isOwner = 1 AND SAs.ActionTypeId IN (@saveactiontypeid, @submitactiontypeid))  
    ) FOR JSON PATH      
         );      
         RETURN @Actions;      
     END; 