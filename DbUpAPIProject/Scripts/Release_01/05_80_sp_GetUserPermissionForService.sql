
/****** Object:  StoredProcedure [dbo].[sp_GetUserPermissionForService]    Script Date: 27-01-2021 19:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetUserPermissionForService 34,90,'09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','NAD Program Manager,Admin'
ALTER PROCEDURE [dbo].[sp_GetUserPermissionForService] @serviceid VARCHAR(100), 
											@stageActionId AS INT,
											@creatorid   NVARCHAR(100),
											@role NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int  ,  @roleId INT  

EXEC @uId= sp_GetUserId @creatorid 

DECLARE @IsOwner INT = 0, @NeedProfile INT;
   SELECT  @IsOwner = Id From Service.Roles Where Name = 'Owner';

DECLARE @temp TABLE(Id INT)
		INSERT INTO @temp
		EXEC sp_GetRoleId @role

Declare @Exist BIT = 0;  

IF(ISNULL(@stageActionId, 0)  > 0)
BEGIN
IF EXISTS(Select 1 From service.StageActionRoles Where StageActionId = @stageActionId AND (RoleId IN (Select Id From @temp) OR (@isOwner IN (Select Id From @temp))))
BEGIN
SET @Exist = 1;
END
END
ELSE
BEGIN
SET @Exist = 1;
END

  IF EXISTS (select ISNULL(ServiceId, 0) From service.ServiceProfiles Where ServiceId = @serviceid)
   BEGIN
   Set @NeedProfile = 1     
   END
   ELSE
   BEGIN
   Set @NeedProfile = 0     
   END

   SELECT @NeedProfile AS NeedProfile, @Exist AS Permission

    END;
