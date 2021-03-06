
/****** Object:  StoredProcedure [dbo].[sp_AdminLinkUnlinkStageForms]    Script Date: 22-01-2021 18:40:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                
-- Author:  <Author,,Name>                
-- Create date: <Create Date,,>                
-- Description: <Description,,>                
-- sp_AdminLinkUnlinkStageForms                 
-- =============================================                
CREATE PROCEDURE [dbo].[sp_AdminLinkUnlinkStageForms] @stageid       INT,         
                                                      @formid          INT,         
                                                      @linkStatus     VARCHAR(100)
AS       
    BEGIN       
        BEGIN TRY       
            BEGIN TRAN; 
DECLARE @ordernumber AS INT = 0;
SELECT @ordernumber = ISNULL(OrderNumber, 0) From service.StageForms Where StageId = @stageid AND FormId = @formid
IF(@linkStatus = 'true')
BEGIN
			IF EXISTS(Select 1 From service.StageForms Where StageId = @stageid AND FormId = @formid)
      BEGIN
	  INSERT INTO service.StageForms(
	  StageId,
	  FormId,
	  OrderNumber
	  )VALUES(
	  @stageid,
	  @formid,
	  @ordernumber + 1
	  )
	  SET @stageid = SCOPE_IDENTITY();
	  END
	  END
	  ELSE
	  BEGIN
	  
	  Delete From service.StageForms Where StageId = @stageid AND FormId = @formid
	  Update service.StageForms SET OrderNumber = OrderNumber - 1 Where StageId = @stageid AND OrderNumber > @formid
	  END
            
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