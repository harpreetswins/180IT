
/****** Object:  StoredProcedure [dbo].[sp_DeleteService]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_DeleteService 7045,4
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeleteService] @ServiceId INT, 
                                  @DeletedBy INT
AS
    BEGIN
        DECLARE @CurrentDate DATETIME;
        SET @CurrentDate = GETDATE();
		DECLARE @GroupId INT
		SET @GroupId = (SELECT GroupId FROM service.Services WHERE Id = @ServiceId)

        BEGIN TRY
            BEGIN TRAN;
            UPDATE service.Services
              SET 
                  IsDeleted = 1, 
                  DeletedDate = @CurrentDate, 
                  DeletedBy = @DeletedBy
            WHERE Id = @ServiceId;

			Update service.Services SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From service.Services Where Id = @ServiceId AND GroupId = @GroupId) AND GroupId = @GroupId AND IsDeleted = 0

            SELECT @ServiceId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @ServiceId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;
GO