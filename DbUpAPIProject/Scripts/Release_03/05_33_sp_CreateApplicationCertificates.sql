-- =============================================                                          
-- Author:  <Author,,Name>                                          
-- Create date: <Create Date,,>                                          
-- Description: <Description,,>                                                                                 
-- =============================================                                          
CREATE PROCEDURE [dbo].[sp_CreateApplicationCertificates] @applicationstageid       INT, 
                                                          @certificateid            INT, 
                                                          @creatorid                INT, 
                                                          @applicationstageactionid INT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            DECLARE @createdcertificateid AS INT, @applicationid INT;
            SELECT @applicationid = ApplicationId
            FROM application.ApplicationStages
            WHERE Id = @applicationstageid;
            INSERT INTO application.ApplicationCertificates
            (ApplicationId, 
             CertificateId, 
             CertificateNumber, 
             CreatedOn, 
             CreatedBy, 
             ApplicationStageActionId
            )
            VALUES
            (@applicationid, 
             @certificateid, 
             'CER', 
             GETDATE(), 
             @creatorid, 
             @applicationstageactionid
            );
            SET @createdcertificateid = SCOPE_IDENTITY();
            UPDATE application.ApplicationCertificates
              SET 
                  CertificateNumber = 'CER' + CONVERT(VARCHAR(10), @createdcertificateid)
            WHERE Id = @createdcertificateid;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
        END CATCH;
    END;