
/****** Object:  StoredProcedure [dbo].[sp_ReorderGroups]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  Neeraj    
-- Create date: 28th-Dec-2020    
-- Description: Reordering of groups.    
-- =============================================    
ALTER PROCEDURE [dbo].[sp_ReorderGroups] @GroupId         INT,   
                                  @PreviousOrderNo INT,   
                                  @NewOrderNo      INT  
AS  
    BEGIN  
        BEGIN TRY  
            BEGIN TRAN;  
            DECLARE @parentid AS INT= NULL;  
   SELECT @parentid = ParentId From service.Groups WHERE Id = @GroupId  
  
   IF(ISNULL(@parentid, 0 ) > 0)  
   BEGIN  
            IF(@PreviousOrderNo < @NewOrderNo)  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER - 1  
                    WHERE((OrderNumber > @PreviousOrderNo  
                           AND OrderNumber <= @NewOrderNo)  
                          AND ParentId = @parentid);  
            END;  
                ELSE  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER + 1  
                    WHERE((OrderNumber < @PreviousOrderNo  
                           AND OrderNumber >= @NewOrderNo)  
                          AND ParentId = @parentid);  
            END;  
  END  
  ELSE  
  BEGIN  
  IF(@PreviousOrderNo < @NewOrderNo)  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER - 1  
                    WHERE((OrderNumber > @PreviousOrderNo  
                           AND OrderNumber <= @NewOrderNo)  
                          AND ParentId IS NULL);  
            END;  
                ELSE  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER + 1  
                    WHERE((OrderNumber < @PreviousOrderNo  
                           AND OrderNumber >= @NewOrderNo)  
                          AND ParentId IS NULL);  
            END;  
  
  END  
  
  
  
            UPDATE service.Groups  
              SET   
                  OrderNumber = @NewOrderNo  
            WHERE Id = @GroupId  
                  AND OrderNumber = @PreviousOrderNo;  
  
   SELECT @GroupId AS Id,   
                   200 AS STATUS,   
                   'Success' AS Message;  
  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @GroupId AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS Message;  
        END CATCH;  
    END;
GO