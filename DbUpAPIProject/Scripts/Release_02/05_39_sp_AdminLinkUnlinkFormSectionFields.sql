
/****** Object:  StoredProcedure [admin].[sp_AdminLinkUnlinkFormSectionFields]    Script Date: 04-02-2021 19:44:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [admin].[sp_AdminLinkUnlinkFormSectionFields] @entityFieldId INT,
															@formSectionId INT,
															@Status  BIT
AS
BEGIN

BEGIN TRY  
            BEGIN TRAN;  
            DECLARE @ordernumber AS INT= 0;  
			SELECT @ordernumber = ISNULL(OrderNumber, 0) + 1 FROM service.FormSectionFields WHERE FormSectionId = @formSectionId AND EntityFieldId = @entityFieldId;  

            IF(@Status = 1)  
                BEGIN  
                    IF NOT EXISTS  
                    (  
                        SELECT 1  
                        FROM service.FormSectionFields 
                        WHERE FormSectionId = @formSectionId AND EntityFieldId = @entityFieldId)  
                        BEGIN  
                            INSERT INTO service.FormSectionFields 
                            (FormSectionId,
                             OrderNumber,
							 EntityFieldId
                            )  
                            VALUES  
                            (@formSectionId, 
                             @ordernumber + 1,
							 @entityFieldId
                            );   
                    END;  
            END;  
                ELSE  
                BEGIN  
                    DELETE FROM service.FormSectionFields 
                    WHERE FormSectionId = @formSectionId  
                          AND EntityFieldId = @entityFieldId;  
                    UPDATE service.FormSectionFields
                      SET   
                          OrderNumber = OrderNumber - 1  
                    WHERE FormSectionId = @formSectionId  
                          AND OrderNumber > @entityFieldId;  
            END;  
            SELECT @formSectionId AS Id,   
                   200 AS STATUS,   
                   'Success' AS Message;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @formSectionId AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS Message;  
        END CATCH;  
END
