
/****** Object:  Table [application].[ActionAttachments]    Script Date: 28-01-2021 19:40:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [application].[ActionAttachments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NOT NULL,
	[AppStageId] [int] NOT NULL,
	[ActionId] [int] NOT NULL,
	[AppStageActionId] [int] NULL,
	[AttachmentId] [int] NOT NULL,
	[CreatorId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[FileContents] [varbinary](max) NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[Extension] [varchar](20) NOT NULL,
	[Size] [decimal](18, 0) NOT NULL,
	[MimeType] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
	[ItemIndex] [int] NULL,
 CONSTRAINT [PK_application.ActionAttachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [application].[ActionAttachments] ADD  CONSTRAINT [DF_application.ActionAttachments_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [application].[ActionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ActionAttachments_ActionTypes] FOREIGN KEY([ActionId])
REFERENCES [lookups].[ActionTypes] ([Id])
GO

ALTER TABLE [application].[ActionAttachments] CHECK CONSTRAINT [FK_ActionAttachments_ActionTypes]
GO

ALTER TABLE [application].[ActionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ActionAttachments_Applications] FOREIGN KEY([AppId])
REFERENCES [application].[Applications] ([Id])
GO

ALTER TABLE [application].[ActionAttachments] CHECK CONSTRAINT [FK_ActionAttachments_Applications]
GO

ALTER TABLE [application].[ActionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ActionAttachments_ApplicationStageActions] FOREIGN KEY([AppStageActionId])
REFERENCES [application].[ApplicationStageActions] ([Id])
GO

ALTER TABLE [application].[ActionAttachments] CHECK CONSTRAINT [FK_ActionAttachments_ApplicationStageActions]
GO

ALTER TABLE [application].[ActionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ActionAttachments_Attachments] FOREIGN KEY([AttachmentId])
REFERENCES [service].[Attachments] ([Id])
GO

ALTER TABLE [application].[ActionAttachments] CHECK CONSTRAINT [FK_ActionAttachments_Attachments]
GO

ALTER TABLE [application].[ActionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ActionAttachments_Stages] FOREIGN KEY([AppStageId])
REFERENCES [service].[Stages] ([Id])
GO

ALTER TABLE [application].[ActionAttachments] CHECK CONSTRAINT [FK_ActionAttachments_Stages]
GO


