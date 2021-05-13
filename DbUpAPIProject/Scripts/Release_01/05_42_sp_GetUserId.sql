
/****** Object:  StoredProcedure [dbo].[sp_GetUserId]    Script Date: 21-01-2021 18:39:41 ******/
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
@userId NVARCHAR(100)
AS
BEGIN

DECLARE @newId INT
	
	--BEGIN TRY
	--	BEGIN TRAN
			IF EXISTS (SELECT 1 FROM application.Users WHERE [ExternalId] = @userId)
			BEGIN
				
				SET @newId = (SELECT Id FROM application.Users WHERE [ExternalId] = @userId)
				Return @newId
			END
			ELSE
			BEGIN
				INSERT INTO application.Users([ExternalId]) VALUES(@userId)
				
				SET @newId = SCOPE_IDENTITY()    

				Return @newId  

			END

END
GO