-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
ALTER PROCEDURE [admin].[sp_AddEditFormSectionAttachments] @id                 INT, 
                                                            @sectionAttachments NVARCHAR(4000)
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @attachmentId AS INT, @translationkeyid AS INT= 6, @translationattachmentdescriptionkeyid AS INT= 21, @ordernumber AS INT= 0;
            CREATE TABLE #tempAttachment
            (Id               INT, 
             Name             NVARCHAR(200), 
             Description      NVARCHAR(500), 
             AttachmentTypeId INT, 
             FormSectionId    INT, 
             LanguageId       INT
            );
            INSERT INTO #tempAttachment
            (Id, 
             Name, 
             Description, 
             AttachmentTypeId, 
             FormSectionId, 
             LanguageId
            )
                   SELECT Id, 
                          Name, 
                          Description, 
                          AttachmentTypeId, 
                          FormSectionId, 
                          LanguageId
                   FROM OPENJSON(@sectionAttachments) WITH(Id INT, Name NVARCHAR(200), Description NVARCHAR(500), AttachmentTypeId INT, FormSectionId INT, LanguageId INT);
            
			SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1
            FROM service.FormSectionAttachments
            WHERE FormSectionId =
            (
                SELECT FormSectionId
                FROM #tempAttachment
                WHERE LanguageId = @enlanguageid
            )
            ORDER BY OrderNumber DESC;

            MERGE service.Attachments AS TARGET
            USING #tempAttachment AS SOURCE
            ON(TARGET.Id = SOURCE.Id)
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid
                THEN UPDATE SET 
                                @attachmentId = TARGET.Id, 
                                TARGET.Name = SOURCE.Name, 
                                TARGET.Description = SOURCE.Description
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid
                THEN
                  INSERT(Name, 
                         Description, 
                         AttachmentTypeId)
                  VALUES
            (Name, 
             Description, 
             AttachmentTypeId
            );
           
		    SET @attachmentId = ISNULL(@attachmentId, SCOPE_IDENTITY());
           
		    MERGE service.Translations AS TARGET
            USING #tempAttachment AS SOURCE
            ON(TARGET.ItemId = @attachmentId
               AND TARGET.LanguageId = SOURCE.LanguageId
               AND TARGET.TranslationKeyId = @translationkeyid)
                WHEN MATCHED AND TARGET.Value <> SOURCE.Name
                THEN UPDATE SET 
                                TARGET.Value = SOURCE.Name
                WHEN NOT MATCHED BY TARGET
                THEN
                  INSERT(TranslationKeyId, 
                         LanguageId, 
                         ItemId, 
                         Value)
                  VALUES
            (@translationkeyid, 
             LanguageId, 
             @attachmentId, 
             SOURCE.Name
            );
            
			MERGE service.Translations AS TARGET
            USING #tempAttachment AS SOURCE
            ON(TARGET.ItemId = @attachmentId
               AND TARGET.LanguageId = SOURCE.LanguageId
               AND TARGET.TranslationKeyId = @translationattachmentdescriptionkeyid)
                WHEN MATCHED AND TARGET.Value <> SOURCE.Description
                THEN UPDATE SET 
                                TARGET.Value = SOURCE.Description
                WHEN NOT MATCHED BY TARGET
                THEN
                  INSERT(TranslationKeyId, 
                         LanguageId, 
                         ItemId, 
                         Value)
                  VALUES
            (@translationattachmentdescriptionkeyid, 
             LanguageId, 
             @attachmentId, 
             SOURCE.Description
            );
            
			MERGE service.FormSectionAttachments AS TARGET
            USING #tempAttachment AS SOURCE
            ON(TARGET.FormSectionId = SOURCE.FormSectionId
               AND TARGET.AttachmentId = @attachmentId)
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid
                THEN UPDATE SET 
                                TARGET.AttachmentId = @attachmentId, 
                                TARGET.OrderNumber = @ordernumber
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid
                THEN
                  INSERT(FormSectionId, 
                         AttachmentId, 
                         OrderNumber)
                  VALUES
            (FormSectionId, 
             @attachmentId, 
             @ordernumber
            );
            
			SELECT @attachmentId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @attachmentId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;