
/****** Object:  StoredProcedure [dbo].[sp_DeleteStages]    Script Date: 25-01-2021 20:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteStages] @stageId INT

AS
BEGIN

BEGIN TRY
BEGIN TRAN

DELETE FROM [service].[Stages] WHERE Id = @stageId
Update [service].[Stages] SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From [service].[Stages] Where Id = @stageId) 

SELECT @stageId AS Id,
		200 AS STATUS, 
        'Success' AS Message;

COMMIT TRANSACTION
END TRY

BEGIN CATCH
SELECT @stageId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
END CATCH

END
