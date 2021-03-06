
/****** Object:  StoredProcedure [dbo].[sp_GetUserPermissionForService]    Script Date: 11-02-2021 12:24:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetUserPermissionForService 34,90,'1a69f548-8029-4ae2-84f4-9243f91c915c','NAD Program Manager,Admin'  
ALTER PROCEDURE [dbo].[sp_GetUserPermissionForService] @serviceid     VARCHAR(100), 
                                                        @stageActionId AS INT, 
                                                        @creatorid     NVARCHAR(100), 
                                                        @role          NVARCHAR(100), 
                                                        @creatorName   NVARCHAR(100)
AS
    BEGIN
        DECLARE @uId INT, @roleId INT, @IsOwner INT= 0, @NeedProfile INT= 0, @Exist BIT= 0;
        EXEC @uId = sp_GetUserId 
             @creatorid, 
             @creatorName;
     
								SELECT @IsOwner = Id
								FROM Service.Roles
								WHERE Name = 'Owner';
								
								DECLARE @temp TABLE(Id INT);
								INSERT INTO @temp
								EXEC sp_GetRoleId 
									 @role;
       
        
		IF(ISNULL(@stageActionId, 0) > 0)
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM service.StageActionRoles
                    WHERE StageActionId = @stageActionId
                          AND (RoleId IN
                    (
                        SELECT Id
                        FROM @temp
                    )
                               OR (@isOwner IN
                    (
                        SELECT Id
                        FROM @temp
                    )))
                )
                    BEGIN
                        SET @Exist = 1;
                END;
        END;
        IF EXISTS
        (
            SELECT ISNULL(ServiceId, 0)
            FROM service.ServiceProfiles
            WHERE ServiceId = @serviceid
        )
            BEGIN
                SET @NeedProfile = 1;
			END;

        SELECT @NeedProfile AS NeedProfile, 
               @Exist AS Permission;
    END;