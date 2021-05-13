
ALTER TABLE [application].[ActionAttachments] DROP CONSTRAINT [FK_ActionAttachments_Attachments]; 
ALTER TABLE [application].[ActionAttachments] DROP COLUMN AttachmentId;
GO

sp_RENAME '[application].[ActionAttachments].[ActionId]' , 'ActionTypeId', 'COLUMN';

ALTER TABLE [application].[ApplicationStageActions] ALTER COLUMN Comments NVARCHAR(500);