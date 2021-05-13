

ALTER TABLE [service].[StageForms]
ADD CONSTRAINT [FK_StageForms_FormModes] FOREIGN KEY ([FormModeId])
    REFERENCES [lookups].[FormModes] ([Id]);