
/****** Object:  StoredProcedure [dbo].[sp_ReorderServices]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Neeraj
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_ReorderServices] @GroupId         INT, 
                                           @ServiceId       INT, 
                                           @PreviousOrderNo INT, 
                                           @NewOrderNo      INT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            IF(@PreviousOrderNo < @NewOrderNo)
                BEGIN
                    UPDATE service.Services
                      SET 
                          ORDERNUMBER = ORDERNUMBER - 1
                    WHERE(OrderNumber > @PreviousOrderNo
                          AND OrderNumber <= @NewOrderNo);
            END;
                ELSE
                BEGIN
                    UPDATE service.Services
                      SET 
                          ORDERNUMBER = ORDERNUMBER + 1
                    WHERE(OrderNumber < @PreviousOrderNo
                          AND OrderNumber >= @NewOrderNo);
            END;
            UPDATE service.Services
              SET 
                  OrderNumber = @NewOrderNo
            WHERE GroupId = @GroupId
                  AND Id = @ServiceId
                  AND OrderNumber = @PreviousOrderNo;
            SELECT @ServiceId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @ServiceId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
        END CATCH;
    END;
GO