
/****** Object:  StoredProcedure [dbo].[sp_AddLog]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--sp_AddLog '637426913323688117','Chrome','{\"Error\":\"ExecuteAction not working properly\",\"UserId\":2,\"ApplicationId\":14,\"ServiceId\":34,\"LanguageId\":2,\"ExceptionOn\":\"12/04/2020 03:14:52\"}','BadRequest'
ALTER PROCEDURE [dbo].[sp_AddLog]
-- Add the parameters for the stored procedure here
--@ExceptionId VARCHAR(100), 
@Browser     VARCHAR(50), 
@Status      VARCHAR(100),
@Error       VARCHAR(MAX), 
@UserId		NVARCHAR(100),
@ApplicationId INT,
@ServiceId     INT
AS
    BEGIN

	DECLARE @CurrentDate DATETIME;
	SET @CurrentDate = GETDATE();
	DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @UserId;

        SET NOCOUNT ON;

        -- Insert statements for procedure here
		  INSERT INTO lookup.Logs
        ([Browser], 
         [Status], 
         [Error],
		 [CreatedDate],
		 [UserId],
		 [ApplicationId],
		 [ServiceId]
        )
        VALUES
        (@Browser, 
         @Status,
         CONVERT(VARCHAR(MAX), @Error),
		 @CurrentDate,
		 @uId,
		 @ApplicationId,
		 @ServiceId
        );
    END;
GO