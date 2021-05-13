
/****** Object:  StoredProcedure [dbo].[sp_GetUserPermissionForService]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetUserPermissionForService 5051, '52761bd1-bb91-40be-b713-44ca5c32e089'
ALTER PROCEDURE [dbo].[sp_GetUserPermissionForService] @serviceid VARCHAR(100), 
                                         @creatorid   NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int  
EXEC @uId= sp_GetUserId @creatorid 
   
Declare @Exist int  
Set @Exist = 1   

Declare @NeedProfile int  

  IF EXISTS (select ISNULL(ServiceId, 0) From service.ServiceProfiles Where ServiceId = @serviceid)
   BEGIN
   Set @NeedProfile = 1     
   SELECT @NeedProfile AS NeedProfile, @Exist AS Permission
   END
   ELSE
   BEGIN
   Set @NeedProfile = 0     
   SELECT @NeedProfile AS NeedProfile, @Exist AS Permission
   END
    END;
GO