
/****** Object:  StoredProcedure [dbo].[sp_AdminLinkUnlinkStageForms]    Script Date: 25-01-2021 21:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    
-- Author:  <Author,,Name>                    
-- Create date: <Create Date,,>                    
-- Description: <Description,,>                    
-- sp_AdminLinkUnlinkStageForms 22,7,'true'                    
-- =============================================                    
ALTER PROCEDURE [dbo].[sp_AdminLinkUnlinkStageForms] @stageid INT,   
                                                      @formid  INT,   
                                                      @Status  BIT 
AS  
    BEGIN  
        BEGIN TRY  
            BEGIN TRAN;  
            DECLARE @ordernumber AS INT= 0;  
            SELECT @ordernumber = ISNULL(OrderNumber, 0)  
            FROM service.StageForms  
            WHERE StageId = @stageid  
                  AND FormId = @formid;  
            IF(@Status = 1)  
                BEGIN  
                    IF NOT EXISTS  
                    (  
                        SELECT 1  
                        FROM service.StageForms  
                        WHERE StageId = @stageid  
                              AND FormId = @formid  
                    )  
                        BEGIN  
                            INSERT INTO service.StageForms  
                            (StageId,   
                             FormId,   
                             OrderNumber  
                            )  
                            VALUES  
                            (@stageid,   
                             @formid,   
                             @ordernumber + 1  
                            );   
                    END;  
            END;  
                ELSE  
                BEGIN  
                    DELETE FROM service.StageForms  
                    WHERE StageId = @stageid  
                          AND FormId = @formid;  
                    UPDATE service.StageForms  
                      SET   
                          OrderNumber = OrderNumber - 1  
                    WHERE StageId = @stageid  
                          AND OrderNumber > @formid;  
            END;  
            SELECT @stageid AS ID,   
                   200 AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @stageid AS ID,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END;