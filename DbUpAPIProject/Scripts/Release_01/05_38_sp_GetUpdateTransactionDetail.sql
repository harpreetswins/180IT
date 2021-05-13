
/****** Object:  StoredProcedure [dbo].[sp_GetUpdateTransactionDetail]    Script Date: 21-01-2021 21:08:46 ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================              
-- Author:  <Author,,Name>              
-- Create date: <Create Date,,>              
-- Description: <Description,,>              
-- sp_AddEditEntities               
-- =============================================              
ALTER PROCEDURE [dbo].[sp_GetUpdateTransactionDetail] @ordernumber       VARCHAR(50), 
                                                      @services          NVARCHAR(4000), 
                                                      @statusmessage     VARCHAR(100), 
                                                      @status            VARCHAR(20), 
                                                      @edirhamfees       DECIMAL(18, 2), 
                                                      @urn               VARCHAR(50), 
                                                      @transactionamount DECIMAL(18, 2), 
                                                      @paymentmethodtype VARCHAR(50), 
                                                      @success           VARCHAR(10), 
                                                      @errorid           INT, 
                                                      @languageid        INT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            DECLARE @applicationstageid INT, @applicationid INT, @paymenttransactionid INT, @timediffrence INT, @returnmessage VARCHAR(50), @paid BIT, @openstatus INT= 1, @closestatus INT= 2, @stageid INT, @serviceid INT, @statusId INT;
            SELECT @paymenttransactionid = APT.OrderId, 
                   @applicationstageid = APT.ApplicationStageId, 
                   @timediffrence = DATEDIFF(minute, APT.CreatedDateTime, GETDATE()), 
                   @paid = APT.Paid
            FROM application.PaymentTransactions APT
            WHERE APT.OrderNumber = @ordernumber;
            SELECT TOP 1 @stageid = AAS.StageId, 
                         @serviceid = AAA.ServiceId, 
                         @statusId = AAS.StageStatusId
            FROM application.ApplicationStages AAS
                 INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId
            WHERE AAS.Id = @applicationstageid
            ORDER BY AAS.Id DESC;
            IF(ISJSON(@services) = 1)
                BEGIN  
                    --CREATE temporary tablewith existence check                  
                    DROP TABLE IF EXISTS #tempTransactions;
                    CREATE TABLE #tempTransactions
                    (ServiceCode VARCHAR(50), 
                     Quantity    INT, 
                     Amount      DECIMAL(18, 2), 
                     TotalAmount DECIMAL(18, 2), 
                     Tax         DECIMAL(18, 2)
                    );
                    INSERT INTO #tempTransactions
                    (ServiceCode, 
                     Quantity, 
                     Amount, 
                     TotalAmount, 
                     Tax
                    )
                           SELECT ServiceCode, 
                                  Quantity, 
                                  Amount, 
                                  TotalAmount, 
                                  Tax
                           FROM OPENJSON(@services) WITH(ServiceCode VARCHAR(50), Quantity INT, Amount DECIMAL(18, 2), TotalAmount DECIMAL(18, 2), Tax DECIMAL(18, 2));
                    MERGE application.PaymentTransactionDetails AS TARGET
                    USING #tempTransactions AS SOURCE
                    ON(TARGET.ServiceCode = SOURCE.ServiceCode)         
                    --When records are matched, update the records if there is any change        
                        WHEN MATCHED AND ISNULL(TARGET.Amount, 0) <> SOURCE.Amount
                        THEN UPDATE SET 
                                        TARGET.Amount = SOURCE.Amount;
            END;
            IF EXISTS
            (
                SELECT 1
                FROM application.PaymentTransactions
                WHERE OrderNumber = @ordernumber
            )
                BEGIN
                    IF(@paid IS NULL)
                        BEGIN
                            UPDATE application.PaymentTransactions
                              SET 
                                  SourceCode = @status, 
                                  EDirhamFeesAmount = @edirhamfees, 
                                  TotalAmount = @transactionamount, 
                                  URN = @urn, 
                                  Message = @statusmessage, 
                                  Paid = CASE
                                             WHEN @status = '0000'
                                             THEN 1
                                             ELSE 0
                                         END
                            WHERE OrderNumber = @ordernumber;
                            UPDATE application.ApplicationStageActions
                              SET 
                                  Data =
                            (
                                SELECT DISTINCT 
                                       APT3.OrderId, 
                                       APT3.OrderNumber AS OrderNumber, 
                                       APT3.URN AS URN, 
                                       APT3.CreatedDateTime AS PaymentDate, 
                                       APT3.TaxAmount AS TaxAmount, 
                                       APT3.EDirhamFeesAmount AS EDirhamFeesAmount, 
                                       APT3.TotalAmount AS TotalAmount, 
                                (
                                    SELECT APTD2.ServiceCode AS ServiceCode, 
                                           SSC.ServiceDescriptionInEnglish AS EnglishDescription, 
                                           SSC.ServiceDescriptionInArabic AS ArabicDescription, 
                                           APTD2.Quantity AS Quantity, 
                                           APTD2.Amount AS Amount
                                    FROM application.PaymentTransactionDetails APTD2
                                         LEFT JOIN service.ServiceCodes SSC ON SSC.ServiceCode = APTD2.ServiceCode
                                    WHERE APTD2.OrderId = APT3.OrderId FOR JSON PATH
                                ) AS Services
                                FROM application.PaymentTransactions APT3
                                WHERE APT3.OrderNumber = @ordernumber FOR JSON PATH
                            )
                            WHERE ApplicationStageId = @applicationstageid;
                            IF(@status = '0000')
                                BEGIN
                                    UPDATE application.ApplicationStages
                                      SET 
                                          StageStatusId = @closestatus
                                    WHERE Id = @applicationstageid;
                                    IF EXISTS
                                    (
                                        SELECT 1
                                        FROM service.Stages
                                        WHERE ServiceId = @serviceId
                                              AND id > @stageId
                                    )
                                        BEGIN
                                            INSERT INTO application.ApplicationStages
                                            ([ApplicationId], 
                                             [UserId], 
                                             [StageId], 
                                             [CreatedOn], 
                                             [StageStatusId], 
                                             [PreviousStageId]
                                            )
                                                   SELECT TOP 1 ApplicationId, 
                                                                UserId, 
                                                   (
                                                       SELECT MIN(id)
                                                       FROM service.Stages
                                                       WHERE ServiceId = @serviceid
                                                             AND id > @stageid
                                                   ) AS StageId, 
                                                                GETDATE() AS CreatedOn, 
                                                                @openstatus AS StageStatusId, 
                                                                StageId AS PreviousStageId
                                                   FROM application.ApplicationStages
                                                   WHERE ApplicationId = @applicationId
                                                   ORDER BY ID DESC;
                                    END;
                            END;
                    END;
            END;
            SELECT
            (
                SELECT DISTINCT 
                       SS.Name AS ServiceName, 
                       AA.ApplicationNumber AS ApplicationNumber, 
                       SSS.Name AS StageName, 
                       APT1.OrderNumber AS OrderNumber, 
                       APT1.URN AS URN, 
                       APT1.CreatedDateTime AS PaymentDate, 
                       APT1.TaxAmount AS TaxAmount, 
                       APT1.EDirhamFeesAmount AS EDirhamFeesAmount, 
                       APT1.TotalAmount AS TotalAmount, 
                (
                    SELECT APTD1.ServiceCode AS ServiceCode, 
                           SSC.ServiceDescriptionInEnglish AS EnglishDescription, 
                           SSC.ServiceDescriptionInArabic AS ArabicDescription, 
                           APTD1.Quantity AS Quantity, 
                           APTD1.Amount AS Amount
                    FROM application.PaymentTransactionDetails APTD1
                         LEFT JOIN service.ServiceCodes SSC ON SSC.ServiceCode = APTD1.ServiceCode
                    WHERE APTD1.OrderId = APT1.OrderId FOR JSON PATH
                ) AS Services
                FROM application.PaymentTransactions APT1
                     INNER JOIN application.PaymentTransactionDetails APTD ON APTD.OrderId = APT1.OrderId
                     INNER JOIN application.ApplicationStages AAS ON AAS.Id = APT1.ApplicationStageId
                     INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                     INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
                     INNER JOIN service.Stages SSS ON SSS.Id = AAS.StageId
                WHERE APT1.OrderNumber = @ordernumber FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
            ) AS TransactionDetail, 
            200 AS STATUS, 
            'Success' AS SuccessMessage;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT NULL AS TransactionDetail, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END;