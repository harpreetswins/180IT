-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- exec sp_AddApplications 1,1,'','',NULL    
--     
-- =============================================    
ALTER PROCEDURE [dbo].[sp_AddApplications] @ServiceId         INT,   
                                            @CreatorId         NVARCHAR(100),   
                                            @UserAgent         NVARCHAR(500),   
                                            @ClientIP          NVARCHAR(50),   
                                            @ParentApplication INT,   
                                            @ProfileAppId      INT,  
                                            @CreatorName       NVARCHAR(100)  
  
AS  
    BEGIN  
  DECLARE @OpenStageID int = 1  
        DECLARE @ApplicationId AS INT;  
        DECLARE @CurrentDate AS DATETIME;  
        SET @CurrentDate = GETDATE();  
        DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @CreatorId,@CreatorName;  
        BEGIN TRY  
            BEGIN TRAN;  
            INSERT INTO application.Applications  
            (ServiceId,   
             CreatorId,   
             CreatedOn,   
             DeviceTypeId,   
             ApplicationNumber,   
             UserAgent,   
             ClientIPAddress,   
             ParentApplicationId,   
             ProfileAppId  
            )  
            VALUES  
            (@ServiceId,   
             @uId,   
             @CurrentDate,   
             1,   
             1,   
             @UserAgent,   
             @ClientIP,   
             NULL,   
             @ProfileAppId  
            );  
            SET @ApplicationId = SCOPE_IDENTITY();  
            UPDATE application.Applications  
              SET   
             
                  ApplicationNumber = 'AppNo' + CONVERT(VARCHAR(10), @ApplicationId)  
            WHERE Id = @ApplicationId;  
            INSERT INTO application.ApplicationStages  
            (ApplicationId,   
             UserId,   
             StageId,   
             CreatedOn,   
             StageStatusId,   
             PreviousAppStageId  
            )  
            VALUES  
            (@ApplicationId,   
             @uId,   
            (  
                SELECT TOP 1 Id  
                FROM service.Stages  
                WHERE ServiceId = @ServiceId  
                ORDER BY Id ASC  
            ),   
            @CurrentDate,   
            @OpenStageID,   
             NULL  
            );  
            SELECT @ApplicationId AS Id,   
                   200 AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            SELECT @ApplicationId AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
            ROLLBACK TRANSACTION;  
        END CATCH;  
    END;  