-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [admin].[sp_AddEditTextResourceValues] @category VARCHAR(200),
													 @key VARCHAR(200),
													 @values NVARCHAR(MAX)
AS
BEGIN

DECLARE @textResourceCategoryId INT, @textResourceKeyId INT, @enlanguageid AS INT = 1, @aralanguageid AS INT = 2

	BEGIN TRY
		BEGIN TRAN

		CREATE TABLE #temp(
		Id INT,
		LanguageId INT,
		Value VARCHAR(500))
		INSERT INTO #temp(
		Id,
		LanguageId,
		Value)
		SELECT Id,
			   LanguageId,
			   Value 
			   FROM OPENJSON(@values) WITH(Id INT, LanguageId INT, Value VARCHAR(500))


		IF EXISTS(SELECT 1 FROM [system].[TextResourcesCategories] WHERE TextResourceCategoryName = @category)
		BEGIN 
			SET @textResourceCategoryId = (SELECT Id FROM [system].[TextResourcesCategories] WHERE TextResourceCategoryName = @category)		
		END
		ELSE
		BEGIN
			INSERT INTO [system].[TextResourcesCategories](TextResourceCategoryName) 
			VALUES(@category);
			SET @textResourceCategoryId = SCOPE_IDENTITY();
		END

		IF EXISTS(SELECT 1 FROM [system].[TextResourcesKeys] WHERE TextResourcesKeyName = @key AND TextResourceCategoryId = @textResourceCategoryId)
		BEGIN
			SET @textResourceKeyId = (SELECT Id FROM [system].[TextResourcesKeys] WHERE TextResourcesKeyName = @key AND TextResourceCategoryId = @textResourceCategoryId)
		END
		ELSE
		BEGIN
			INSERT INTO [system].[TextResourcesKeys](TextResourcesKeyName,TextResourceCategoryId)
			VALUES(@key, @textResourceCategoryId)
			SET @textResourceKeyId = SCOPE_IDENTITY();
		END

		MERGE [system].[TextResourceValues] AS TARGET  
                            USING #temp AS SOURCE  
                            ON(TARGET.TextResourcesKeyId = @textResourceKeyId AND TARGET.LanguageId = SOURCE.LanguageId)  
                                WHEN MATCHED AND TARGET.Value <> SOURCE.Value   
                                THEN UPDATE SET    
                                                TARGET.Value = SOURCE.Value  
                                WHEN NOT MATCHED BY TARGET   
                                THEN  
                                  INSERT(TextResourcesKeyId, LanguageId, Value)  
                                  VALUES(@textResourceKeyId, SOURCE.LanguageId, SOURCE.Value);  

		 SELECT @textResourceCategoryId AS Id,   
                           200 AS STATUS,   
                           'Success' AS SuccessMessage;  

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;  
            SELECT @textResourceCategoryId AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH; 
END
GO
