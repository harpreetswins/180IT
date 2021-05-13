ALTER PROCEDURE [dbo].[sp_GetApplicationPaymentDetail] @applicationid AS INT,            
              @languageid AS INT ,         
                                                        @userid AS        NVARCHAR(100)  ,    
              @stageActionId AS INT    
                       
AS            
    BEGIN            
        DECLARE @stageid AS INT, @stagestatusid AS INT, @applicationstageid AS INT, @orderid AS INT, @stagesettings AS NVARCHAR(500), @serviceId AS INT;            
  DECLARE @paid AS INT, @message AS VARCHAR(50) = 'New', @currentdate AS DateTime, @minute AS INT, @orderNumber AS VARCHAR(50);    
  DECLARE @openStageStatusId INT = 1, @closeStageStatusId INT = 2, @paymentId INT = 2;  
        DECLARE @uId INT;            
        EXEC @uId = sp_GetUserId             
             @userid;            
        BEGIN TRY            
            BEGIN TRAN;            
            SELECT DISTINCT TOP 1 @applicationstageid = AAS3.Id,             
                                  @stageid = AAS3.StageId,             
                                  @stagestatusid = AAS3.StageStatusId,             
                                  @stagesettings = SS2.Settings,
								  @serviceId = AA5.ServiceId
            FROM application.ApplicationStages AAS3 
				INNER JOIN application.applications AA5 ON AA5.Id = AAS3.ApplicationId
                 INNER JOIN service.Stages SS2 ON SS2.Id = AAS3.StageId            
            WHERE applicationId = @applicationid            
                  AND UserId = @uId            
            ORDER BY AAS3.Id DESC;            
            
            CREATE TABLE #tempStageSettings            
            (ServiceCode VARCHAR(50),             
             Quantity    INT,             
             Amount      Varchar(50)            
            );            
            INSERT INTO #tempStageSettings            
            (ServiceCode,             
             Quantity,             
             Amount            
            )            
                   SELECT ServiceCode,             
                          Quantity,             
                          Amount            
                   FROM OPENJSON(@stagesettings) WITH(ServiceCode VARCHAR(50), Quantity INT, Amount Varchar(50));            
            UPDATE #tempStageSettings            
              SET             
                  Quantity = 1            
            WHERE Quantity IS NULL;            
            -- select * from  #tempStageSettings            
           
    SELECT @paid = PT.Paid, @orderNumber = PT.OrderNumber, @currentdate = PT.CreatedDateTime FROM application.PaymentTransactions PT WHERE PT.ApplicationStageId = @applicationstageid    
    
    SET @minute = (SELECT DATEDIFF(MINUTE,@currentdate,GETDATE()));     
    
IF EXISTS(SELECT 1 FROM application.PaymentTransactions PT WHERE PT.ApplicationStageId = @applicationstageid)    
BEGIN    
    
IF(@paid IS NUll AND @minute <= 15)    
BEGIN    
SET @message = 'Pending';    
END    
    
ELSE IF(@paid IS NUll AND @minute >= 15)    
BEGIN    
 SET @message = 'Check'    
END    
    
ELSE IF(@paid = 1)    
BEGIN    
 SET @message = 'Paid'    
END    
    
ELSE IF(@paid = 0)    
BEGIN    
SET @message = 'Failed'    
END    
END    
IF(@message = 'Failed' OR @message = 'New')    
BEGIN    
 IF EXISTS            
            (            
                SELECT 1            
                FROM application.ApplicationStages AAS            
                     INNER JOIN service.Stages SS ON SS.Id = AAS.StageId            
                     INNER JOIN lookups.StageStatuses SSS ON SSS.Id = AAS.StageStatusId            
                WHERE AAS.applicationId = @applicationid            
                      AND AAS.UserId = @uId            
       AND AAS.Id = @applicationstageid            
                      AND AAS.StageStatusId = @openStageStatusId           
                --(            
                --    SELECT Id            
                --    FROM lookups.StageStatuses            
                --    WHERE [Name] = 'Open'            
                --)            
       AND AAS.StageId =          
             (            
                    SELECT SS.Id            
                    FROM service.Stages SS  
					     INNER JOIN application.applicationStages AAS ON AAS.StageId = SS.Id
						 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                         INNER JOIN lookups.StageTypes LST ON LST.Id = SS.StageTypeId            
                    WHERE LST.Id = @paymentId AND AAS.Id = @applicationstageid AND AA.ServiceId = @serviceId   
                )            
            )            
                BEGIN            
                    INSERT INTO application.PaymentTransactions            
                    (OrderNumber,            
      OrderDate,             
                     Paid,             
                     ApplicationStageId,             
                     TaxAmount,             
                     EDirhamFeesAmount,             
                     TotalAmount,             
                     CreatedBy,             
                     CreatedDateTime            
                    )            
                    VALUES            
                    (1,            
      GETDATE(),             
                     null,             
                     @applicationstageid,             
                     NULL,             
                     NULL,             
                     NULL,             
                     @uId,             
                     GETDATE()            
                );            
                                
     SET @orderid = SCOPE_IDENTITY();            
                                
     UPDATE application.PaymentTransactions            
                      SET             
                OrderNumber = 'ORD' + CONVERT(VARCHAR(10), @orderid)            
                    WHERE OrderId = @orderid;            
            
 INSERT INTO [application].[PaymentTransactionDetails](OrderId,ServiceCode,Quantity,Amount)      
  SELECT       
  @orderid,      
  JSON_VALUE(stagesetting.VALUE, '$.ServiceCode') AS ServiceCode,      
  ISNULL(JSON_VALUE(stagesetting.VALUE, '$.Quantity'), 1) AS Quantity,      
  JSON_VALUE(stagesetting.VALUE, '$.Amount') AS Amount      
  FROM OPENJSON (@stagesettings) AS stagesetting      
      
  INSERT INTO [application].[applicationstageactions](ApplicationStageId,StageActionId,CreatedOn,UserId,Data)    
  VALUES(@applicationstageid,@stageActionId,GETDATE(),@uId,null)    
            
                    SELECT DISTINCT TOP 1 AAS1.Id,            
                                          AA1.ApplicationNumber AS ApplicationNumber,             
                                          APT.OrderNumber AS OrderNumber,             
                                          (Select ServiceCode, Quantity, Amount       
            From #tempStageSettings FOR JSON AUTO, INCLUDE_NULL_VALUES) AS Services,      
   'Ok' AS Status,    
   @message AS Message    
                    FROM application.ApplicationStages AAS1            
     INNER JOIN application.Applications AA1 ON AA1.Id = AAS1.ApplicationId            
                         INNER JOIN application.PaymentTransactions APT ON APT.ApplicationStageId = AAS1.Id           
                    WHERE applicationId = @applicationid            
                          AND UserId = @uId            
                          AND @stageid =         
                    (            
                        SELECT SS.Id      
						FROM service.Stages SS  
					     INNER JOIN application.applicationStages AAS ON AAS.StageId = SS.Id
						 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                         INNER JOIN lookups.StageTypes LST ON LST.Id = SS.StageTypeId            
                    WHERE LST.Id = @paymentId AND AAS.Id = @applicationstageid AND AA.ServiceId = @serviceId      
                    )            
                              AND @stagestatusid = @openStageStatusId        
                    --(            
                    --    SELECT Id            
                    --    FROM lookups.StageStatuses            
                    --    WHERE [Name] = 'Open'            
                    --)            
                              AND APT.OrderId = @orderid            
                    ORDER BY AAS1.Id DESC;      
         
            END;          
END    
ELSE    
BEGIN    
    
SELECT @applicationstageid AS Id,     
(SELECT AA.ApplicationNumber FROM [application].[ApplicationStages] AAS INNER JOIN [application].[Applications] AA ON AA.Id = AAS.ApplicationId WHERE AAS.Id = @applicationstageid) AS ApplicationNumber,    
@orderNumber AS OrderNumber, null AS Services, 'Ok' AS Status, @message AS Message    
    
END    
             
            COMMIT TRANSACTION;            
        END TRY            
        BEGIN CATCH            
            SELECT @orderid AS Id,             
                   500 AS STATUS,             
                   ERROR_MESSAGE() AS ErrorMessage;            
            ROLLBACK TRANSACTION;            
        END CATCH;            
    END;   