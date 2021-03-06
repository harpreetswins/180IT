
/****** Object:  StoredProcedure [dbo].[sp_ReorderStages]    Script Date: 27-01-2021 16:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  Neeraj      
-- Create date: 27th-Jan-2021     
-- Description: Reordering of Stages.      
-- =============================================      
CREATE PROCEDURE [dbo].[sp_ReorderStages] @ServiceId   INT,
											@StageId INT,     
											@PreviousOrderNo INT,     
											@NewOrderNo      INT    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
  IF(@PreviousOrderNo < @NewOrderNo)    
                BEGIN    
                    UPDATE service.Stages    
                      SET     
                          ORDERNUMBER = ORDERNUMBER - 1    
                    WHERE((OrderNumber > @PreviousOrderNo    
                           AND OrderNumber <= @NewOrderNo)    
                          AND ServiceId = @ServiceId);    
            END;    
                ELSE    
                BEGIN    
                    UPDATE service.Stages    
                      SET     
                          ORDERNUMBER = ORDERNUMBER + 1    
                    WHERE((OrderNumber < @PreviousOrderNo    
                           AND OrderNumber >= @NewOrderNo)    
                          AND ServiceId = @ServiceId);    
            END;   
            UPDATE service.Stages    
              SET     
                  OrderNumber = @NewOrderNo    
            WHERE Id = @StageId    
               --   AND OrderNumber = @PreviousOrderNo;    
    
   SELECT @StageId AS Id,     
                   200 AS STATUS,     
                   'Success' AS Message;    
    
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            ROLLBACK TRANSACTION;    
            SELECT @StageId AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
        END CATCH;    
    END;  