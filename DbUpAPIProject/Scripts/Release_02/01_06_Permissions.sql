

/****** Object:  Table [service].[Permissions]    Script Date: 05-02-2021 12:03:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [service].[Permissions](
	[RoleId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [service].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Roles] FOREIGN KEY([RoleId])
REFERENCES [service].[Roles] ([Id])
GO

ALTER TABLE [service].[Permissions] CHECK CONSTRAINT [FK_Permissions_Roles]
GO

ALTER TABLE [service].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Services] FOREIGN KEY([ServiceId])
REFERENCES [service].[Services] ([Id])
GO

ALTER TABLE [service].[Permissions] CHECK CONSTRAINT [FK_Permissions_Services]
GO


