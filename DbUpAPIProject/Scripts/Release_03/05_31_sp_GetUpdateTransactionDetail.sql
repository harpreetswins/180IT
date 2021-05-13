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
                                                      @languageid        INT, 
                                                      @creatorId         NVARCHAR(100), 
                                                      @creatorName       NVARCHAR(100)
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            DECLARE @applicationstageid INT, @applicationid INT, @paymenttransactionid INT, @timediffrence INT, @returnmessage VARCHAR(50), @paid BIT, @openstatus INT= 1, @closestatus INT= 2, @stageid INT, @serviceid INT, @statusId INT, @uId INT, @IsPermission INT= 1, @serviceTranslationKeyId INT= 11, @englanguageid INT= 1, @arabiclanguageid INT= 2, @nextstageavailability AS BIT= 0, @stageActionId AS INT, @appStageActionId AS INT, @existedCertificateId AS INT;
            EXEC @uId = sp_GetUserId 
                 @creatorId, 
                 @creatorName;
            SELECT @paymenttransactionid = APT.OrderId,                                 
                   --@applicationstageid = App_Stg_Act.ApplicationStageId,                                 
                   @timediffrence = DATEDIFF(minute, APT.CreatedDateTime, GETDATE()), 
                   @paid = APT.Paid, 
                   @appStageActionId = APT.ApplicationStageActionId
            FROM application.PaymentTransactions APT
                 INNER JOIN application.ApplicationStageActions App_Stg_Act ON APT.[ApplicationStageActionId] = App_Stg_Act.Id
            WHERE APT.OrderNumber = @ordernumber;
            SELECT TOP 1 @stageid = AAS.StageId, 
                         @serviceid = AAA.ServiceId, 
                         @statusId = AAS.StageStatusId, 
                         @applicationstageid = AAS.Id
            FROM vw_ApplicationStagesOrderBy AAS
                 INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId
            WHERE AAS.Id =
            (
                SELECT ApplicationStageId
                FROM application.ApplicationStageActions
                WHERE Id = @appStageActionId
            );

            -- Checked new stage availability                        
            SELECT @stageActionId = StageActionId
            FROM application.ApplicationStageActions
            WHERE Id = @appStageActionId;
            SET @nextstageavailability =
            (
                SELECT dbo.fn_appNextStageAvailability(@stageActionId, @stageid)
            );
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
            SET @existedCertificateId =
            (
                SELECT dbo.fn_certificateExists(@stageActionId)
            );
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

                                    -- Certificates checks  
                                    IF(@existedCertificateId > 0)
                                        BEGIN
                                            EXEC sp_CreateApplicationCertificates 
                                                 @applicationstageid, 
                                                 @existedCertificateId, 
                                                 @uId, 
                                                 @appStageActionId;
                                    END;
                                    IF(@nextstageavailability = 1)
                                        BEGIN
                                            INSERT INTO application.ApplicationStages
                                            ([ApplicationId], 
                                             [UserId], 
                                             [StageId], 
                                             [CreatedOn], 
                                             [StageStatusId], 
                                             [PreviousAppStageId]
                                            )
                                                   SELECT ApplicationId, 
                                                          UserId, 
                                                   (
                                                       SELECT ToStageId
                                                       FROM service.StageActions
                                                       WHERE Id = @stageActionId
                                                             AND ToStageID <> @stageid
                                                             AND ToStageID IS NOT NULL
                                                   ) AS StageId, 
                                                          GETDATE() AS CreatedOn, 
                                                          @openstatus AS StageStatusId, 
                                                          Id AS PreviousStageId
                                                   FROM vw_ApplicationStagesOrderBy
                                                   WHERE Id = @applicationstageid;
                                    END;
                            END;
                    END;
            END;
            IF(@uId =
            (
                SELECT CreatedBy
                FROM [application].[PaymentTransactions]
                WHERE OrderNumber = @ordernumber
            ))
                BEGIN
                    SELECT
                    (
                        SELECT DISTINCT                                 
                        --SS.Name AS ServiceName,                      
                               dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId) AS ServiceName, 
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
                            (
                                SELECT '[' +
                                (
                                    SELECT @englanguageid AS langId, 
                                           ServiceDescriptionInEnglish AS [value]
                                    FROM service.ServiceCodes
                                    WHERE ServiceCode = APTD1.ServiceCode FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                                ) + ',' +
                                (
                                    SELECT @arabiclanguageid AS langId, 
                                           ServiceDescriptionInArabic AS [value]
                                    FROM service.ServiceCodes
                                    WHERE ServiceCode = APTD1.ServiceCode FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                                ) + ']'
                            ) AS ServiceCodeDescription, 
                                   APTD1.Quantity AS Quantity, 
                                   APTD1.Amount AS Amount
                            FROM application.PaymentTransactionDetails APTD1
                                 LEFT JOIN service.ServiceCodes SSC ON SSC.ServiceCode = APTD1.ServiceCode
                            WHERE APTD1.OrderId = APT1.OrderId FOR JSON PATH
                        ) AS Services, 
                               AAS.ApplicationId AS ApplicationId, 
                               (CASE
                                    WHEN APT1.Paid IS NULL
                                    THEN 'Pending'
                                    WHEN APT1.Paid = 0
                                    THEN 'Failed'
                                    ELSE 'Paid'
                                END) AS PaymentStatus
                        FROM application.PaymentTransactions APT1
                             INNER JOIN application.PaymentTransactionDetails APTD ON APTD.OrderId = APT1.OrderId
                             INNER JOIN application.ApplicationStageActions App_Stg_Act ON App_Stg_Act.Id = APT1.ApplicationStageActionId
                             INNER JOIN application.ApplicationStages AAS ON AAS.Id = App_Stg_Act.ApplicationStageId
                             INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                             INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
                             INNER JOIN service.Stages SSS ON SSS.Id = AAS.StageId
                        WHERE APT1.OrderNumber = @ordernumber FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                    ) AS TransactionDetail, 
                    @IsPermission AS IsPermission, 
                    200 AS STATUS, 
                    'Success' AS SuccessMessage;
            END;
                ELSE
                BEGIN
                    SET @IsPermission = 0;
                    SELECT @IsPermission AS IsPermission;
            END;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT NULL AS TransactionDetail, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END;