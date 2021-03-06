
/****** Object:  StoredProcedure [dbo].[sp_GetUserId]    Script Date: 03-02-2021 15:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetUserId] 
@userId NVARCHAR(100),
@userName NVARCHAR(50)
AS
BEGIN

DECLARE @newId INT

			IF EXISTS (SELECT 1 FROM application.Users WHERE [ExternalId] = @userId)
			BEGIN
				IF ((SELECT UserName FROM application.Users WHERE [ExternalId] = @userId) IS NUll)
				BEGIN
				UPDATE application.Users SET UserName = @userName WHERE ExternalId = @userId;
				SET @newId = (SELECT Id FROM application.Users WHERE [ExternalId] = @userId)
				Return @newId
				END
				ELSE
				BEGIN
				SET @newId = (SELECT Id FROM application.Users WHERE [ExternalId] = @userId)
				Return @newId
				END
				
			END
			ELSE
			BEGIN
				INSERT INTO application.Users([ExternalId],[UserName]) VALUES(@userId, @userName)
				
				SET @newId = SCOPE_IDENTITY()    
				Return @newId  

			END

END