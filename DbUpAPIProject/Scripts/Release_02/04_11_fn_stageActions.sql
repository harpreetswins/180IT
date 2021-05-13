-- =============================================                
-- Author:  <Author,,Name>                
-- Create date: <Create Date, ,>                
-- Description: <Description, ,>           
-- SELECT dbo.fn_stageActions(20,'NAD Program Manager',1)        
-- =============================================                
ALTER FUNCTION [dbo].[fn_stageActions]
(@stageId INT, 
 @roleId  NVARCHAR(100), 
 @isOwner BIT
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @tempRoles TABLE(Roles VARCHAR(100));
         INSERT INTO @tempRoles(Roles)
                SELECT Item
                FROM SplitString(@roleId, ',');
         DECLARE @Actions AS NVARCHAR(MAX), @stageActionsTranslationKeyId INT= 7, @saveactiontypeid INT= 1, @submitactiontypeid INT= 2;
         SET @Actions =
         (
             SELECT DISTINCT 
                    SAs.Id AS stageActionId, 
                    SAs.OrderNumber AS stageOrder, 
                    LAT.Name AS stageActionTypeName, 
                    LAT.Id AS stageActionTypeId, 
                    JSON_QUERY(dbo.fn_multiLingualName(SAs.Id, @stageActionsTranslationKeyId)) AS StageActionName
             FROM service.StageActions SAs
                  INNER JOIN lookups.ActionTypes LAT ON LAT.Id = SAs.ActionTypeId
             WHERE SAs.StageId = @stageId
                   AND SAs.Id IN
					 (
						 SELECT Stg_Act_Role.StageActionId
						 FROM service.StageActionRoles Stg_Act_Role
						 WHERE Stg_Act_Role.RoleId IN
						 (
							 SELECT Id
							 FROM service.roles
							 WHERE Name IN
							 (
								 SELECT Roles
								 FROM @tempRoles
							 )
						 )
							   OR (@isOwner = 1
								   AND Stg_Act_Role.RoleId =
						 (
							 SELECT Id
							 FROM service.roles
							 WHERE Name = 'Owner'
						 ))
					 ) FOR JSON PATH
         );
         RETURN @Actions;
     END;