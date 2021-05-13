
/****** Object:  StoredProcedure [dbo].[sp_DeleteGroup]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,> 
-- sp_DeleteGroup 15089,1 
-- =============================================  
ALTER PROCEDURE [dbo].[sp_DeleteGroup] @GroupId   INT, 
                               @DeletedBy INT
AS
    BEGIN
        DECLARE @CurrentDate DATETIME;
        SET @CurrentDate = GETDATE();
        BEGIN TRY
            BEGIN TRAN;
            UPDATE service.Groups
              SET 
                  IsDeleted = 1, 
                  DeletedDate = @CurrentDate, 
                  DeletedBy = @DeletedBy
            WHERE Id = @GroupId;
            IF(
            (
                SELECT ISNULL(ParentId, 0)
                FROM service.Groups
                WHERE Id = @GroupId
            ) > 0)
                BEGIN
                    UPDATE service.Groups
                      SET 
                          OrderNumber = OrderNumber - 1
                    WHERE OrderNumber > (Select OrderNumber From service.Groups Where id = @GroupId)
                          AND ParentId =
                    (
                        SELECT ISNULL(ParentId, 0)
                        FROM service.Groups
                        WHERE Id = @GroupId
                    )
                          AND IsDeleted = 0;
            END;
                ELSE
                BEGIN
                    UPDATE service.Groups
                      SET 
                          OrderNumber = OrderNumber - 1
                    WHERE OrderNumber > (Select OrderNumber From service.Groups Where id = @GroupId)
                          AND ParentId IS NULL
                          AND IsDeleted = 0;
            END;
            SELECT @GroupId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @GroupId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;
GO