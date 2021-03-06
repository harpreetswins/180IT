
/****** Object:  StoredProcedure [admin].[sp_DeleteFormSections]    Script Date: 04-02-2021 19:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [admin].[sp_DeleteFormSections] @formSectionId INT,
												 @formId INT

AS
BEGIN

BEGIN TRY
BEGIN TRAN

DELETE FROM [service].[FormSections] WHERE Id = @formSectionId AND FormId = @formId
Update [service].[FormSections] SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From [service].[FormSections] Where Id = @formSectionId) 

SELECT @formSectionId AS Id,
		200 AS STATUS, 
        'Success' AS Message;

COMMIT TRANSACTION
END TRY

BEGIN CATCH
SELECT @formSectionId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
END CATCH

END