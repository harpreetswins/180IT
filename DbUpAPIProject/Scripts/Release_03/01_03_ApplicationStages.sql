ALTER TABLE application.ApplicationStages
DROP CONSTRAINT FK_ApplicationStages_ApplicationStages;

ALTER TABLE application.ApplicationStages
DROP COLUMN PreviousStageId;

ALTER TABLE application.ApplicationStages
  ADD PreviousAppStageId INT NULL


-- Add constraint

ALTER TABLE [application].[ApplicationStages]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStages_ApplicationStages] FOREIGN KEY([PreviousAppStageId])
REFERENCES [application].[ApplicationStages] ([Id])
GO

ALTER TABLE [application].[ApplicationStages] CHECK CONSTRAINT [FK_ApplicationStages_ApplicationStages]
GO
