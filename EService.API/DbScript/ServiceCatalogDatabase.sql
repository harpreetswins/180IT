CREATE DATABASE ServiceCatalog
/****** Object:  Table [dbo].[application.ActionAssignedUsers]    Script Date: 11/26/2020 10:59:34 AM ******/
GO

USE ServiceCatalog
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
use ServiceCatalog
go
CREATE TABLE [dbo].[application.ActionAssignedUsers](
	[ApplicationStageActionId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_ActionAssignedUsers] PRIMARY KEY CLUSTERED 
(
	[ApplicationStageActionId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.ApplicationAttachments]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.ApplicationAttachments](
	[Id] [int] NULL,
	[AppId] [int] NULL,
	[AppStageId] [int] NULL,
	[AttachmentId] [int] NULL,
	[CreatorId] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[FileContents] [binary](200) NULL,
	[FileName] [varchar](100) NULL,
	[Extension] [varchar](10) NULL,
	[Size] [decimal](18, 0) NULL,
	[MimeType] [varchar](50) NULL,
	[AttachmentTypeId] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.Applications]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.Applications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[CreatorId] [int] NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[DeviceTypeId] [int] NOT NULL,
	[ApplicationNumber] [nvarchar](50) NOT NULL,
	[UserAgent] [nvarchar](500) NOT NULL,
	[ClientIPAddress] [nvarchar](50) NOT NULL,
	[ParentApplicationId] [int] NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.ApplicationStageActions]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.ApplicationStageActions](
	[Id] [int] NOT NULL,
	[ApplicationStageId] [int] NOT NULL,
	[StageActionId] [int] NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[UserId] [int] NOT NULL,
	[Data] [xml] NULL,
 CONSTRAINT [PK_ApplicationStageActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.ApplicationStages]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.ApplicationStages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[StageId] [int] NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[StageStatusId] [int] NOT NULL,
	[PreviousStageId] [int] NULL,
 CONSTRAINT [PK_ApplicationStages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.DeviceTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.DeviceTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DeviceTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application.StageStatuses]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application.StageStatuses](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_StageStatuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.Categories]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OldId] [int] NULL,
	[SectionId] [int] NOT NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.CategoryNotifyBodies]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.CategoryNotifyBodies](
	[CategoryId] [int] NOT NULL,
	[NotifyBodyId] [int] NOT NULL,
	[NotifyBodyCertificate] [nvarchar](20) NULL,
 CONSTRAINT [PK_SubCategoryNotifyBodies] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[NotifyBodyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.Cities]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.Cities](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.Countries]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.Countries](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ISOCode2] [nvarchar](2) NOT NULL,
	[ISOCode3] [nvarchar](3) NOT NULL,
	[PhoneCode] [nvarchar](5) NOT NULL,
	[NumericCode] [nvarchar](5) NOT NULL,
	[OldCountryId] [int] NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.NotifyBodies]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.NotifyBodies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[OldId] [int] NULL,
 CONSTRAINT [PK_NotifyBodies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.ProductTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.ProductTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](270) NOT NULL,
	[OldId] [int] NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.Sections]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.Sections](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[OldId] [int] NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.SubCategories]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.SubCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[OldId] [int] NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_SubCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.SubCategoryProductTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.SubCategoryProductTypes](
	[SubCategoryId] [int] NOT NULL,
	[ProductTypeId] [int] NOT NULL,
 CONSTRAINT [PK_SubCategoryProductTypes] PRIMARY KEY CLUSTERED 
(
	[SubCategoryId] ASC,
	[ProductTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.SubCategoryThirdParties]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.SubCategoryThirdParties](
	[ThirdPartyId] [int] NOT NULL,
	[SubCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_SubCategoryThirdParties] PRIMARY KEY CLUSTERED 
(
	[ThirdPartyId] ASC,
	[SubCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup.ThirdParties]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup.ThirdParties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[OldId] [int] NULL,
 CONSTRAINT [PK_ThirdParties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.ActionForms]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.ActionForms](
	[ActionId] [int] NOT NULL,
	[FormId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
 CONSTRAINT [PK_ActionForms] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC,
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.ActionTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.ActionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ActionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.ApplicationFieldValues]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.ApplicationFieldValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[EntityFieldId] [int] NOT NULL,
	[Value] [varchar](500) NOT NULL,
	[ParentId] [int] NULL,
	[FieldIndex] [int] NOT NULL,
 CONSTRAINT [PK_service.ApplicationFieldValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.AttachmentConstraints]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.AttachmentConstraints](
	[FormSectionAttachmentId] [int] NOT NULL,
	[AttachmentConstraintTypeId] [int] NOT NULL,
	[Settings] [xml] NULL,
 CONSTRAINT [PK_AttachmentAttachmentConstraints] PRIMARY KEY CLUSTERED 
(
	[FormSectionAttachmentId] ASC,
	[AttachmentConstraintTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.AttachmentConstraintTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.AttachmentConstraintTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AttachmentConstraintTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Attachments]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Attachments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[AttachmentTypeId] [int] NULL,
 CONSTRAINT [PK_Attachments_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.AttachmentTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.AttachmentTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AttachmentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Entities]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Entities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Entities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.EntityFields]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.EntityFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FieldTypeId] [int] NOT NULL,
	[EntityId] [int] NOT NULL,
	[Settings] [xml] NULL,
 CONSTRAINT [PK_EntityFields] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.EntityRelationships]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.EntityRelationships](
	[FromEntityId] [int] NOT NULL,
	[ToEntityId] [int] NOT NULL,
	[EntityRelationshipTypeId] [int] NOT NULL,
	[EntityFieldId] [int] NOT NULL,
 CONSTRAINT [PK_EntityRelationship] PRIMARY KEY CLUSTERED 
(
	[FromEntityId] ASC,
	[ToEntityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.EntityRelationTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.EntityRelationTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RelationTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FieldConstraintTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FieldConstraintTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_FieldConstraintTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FieldTypeConstraintType]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FieldTypeConstraintType](
	[FieldConstraintTypeId] [int] NOT NULL,
	[FieldTypeId] [int] NOT NULL,
 CONSTRAINT [PK_FieldTypeConstraintType] PRIMARY KEY CLUSTERED 
(
	[FieldConstraintTypeId] ASC,
	[FieldTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FieldTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FieldTypes](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_FormFieldTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FormFieldConstraints]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FormFieldConstraints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormSectionFieldId] [int] NOT NULL,
	[FieldConstraintTypeId] [int] NULL,
	[Settings] [xml] NULL,
 CONSTRAINT [PK_FormFieldConstraints] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Forms]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Forms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Settings] [xml] NULL,
 CONSTRAINT [PK_Forms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FormSectionAttachments]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FormSectionAttachments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormSectionId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[AttachmentId] [int] NULL,
 CONSTRAINT [PK_Attachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FormSectionFields]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FormSectionFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormSectionId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[EntityFieldId] [int] NOT NULL,
	[FormSectionParentId] [int] NULL,
 CONSTRAINT [PK_FormFields_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.FormSections]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.FormSections](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[FormId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[Settings] [xml] NULL,
 CONSTRAINT [PK_FormSections] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Groups]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ParentId] [int] NULL,
	[OrderNumber] [int] NOT NULL,
	[Description] [nvarchar](400) NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Languages]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Languages](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Direction] [varchar](50) NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.LookupFieldsValues]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.LookupFieldsValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntityFieldId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [int] NOT NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_service.LookupFieldsValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Roles]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Services]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Services](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[GroupId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[Description] [nvarchar](400) NULL,
	[Settings] [xml] NULL,
	[StartStageID] [int] NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.StageActionRoles]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.StageActionRoles](
	[StageActionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_StageActionRoles] PRIMARY KEY CLUSTERED 
(
	[StageActionId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.StageActions]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.StageActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ActionTypeId] [int] NULL,
	[OrderNumber] [int] NOT NULL,
	[StageId] [int] NOT NULL,
	[ToStageID] [int] NULL,
 CONSTRAINT [PK_ServiceAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.StageForms]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.StageForms](
	[StageId] [int] NOT NULL,
	[FormId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
 CONSTRAINT [PK_StageForms] PRIMARY KEY CLUSTERED 
(
	[StageId] ASC,
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Stages]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Stages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[StageTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Stages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.StageTypes]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.StageTypes](
	[Id] [int] NOT NULL,
	[StageTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_StageTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.TextResourcesCategories]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.TextResourcesCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextResourceCategoryName] [nvarchar](100) NULL,
 CONSTRAINT [PK_TextResourcesCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.TextResourcesKeys]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.TextResourcesKeys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextResourcesKeyName] [nvarchar](100) NULL,
	[TextResourceCategoryId] [int] NULL,
 CONSTRAINT [PK_TextResourcesKeys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.TextResourceValues]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.TextResourceValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextResourcesKeyId] [int] NULL,
	[LanguageId] [int] NULL,
	[Value] [nvarchar](200) NULL,
 CONSTRAINT [PK_TextResourceValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.TranslationKeys]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.TranslationKeys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TranslationKeys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Translations]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Translations](
	[TranslationKeyId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Translations] PRIMARY KEY CLUSTERED 
(
	[TranslationKeyId] ASC,
	[LanguageId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service.Users]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service.Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExternalId] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[application.Applications] ON 
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (12, 1, 1, CAST(N'2019-12-12T00:00:00.0000000' AS DateTime2), 1, N'1', N'mozilla', N'1223', NULL)
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (13, 1, 1, CAST(N'2020-11-26T10:16:21.0800000' AS DateTime2), 1, N'1', N'12/12/2016', N'ClientIP', NULL)
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (16, 1, 1, CAST(N'2020-11-26T10:19:37.6066667' AS DateTime2), 1, N'1', N'12/12/2016', N'ClientIP', NULL)
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (17, 1, 1, CAST(N'2020-11-26T10:20:13.0366667' AS DateTime2), 1, N'1', N'12/12/2016', N'ClientIP', NULL)
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (18, 1, 1, CAST(N'2020-11-26T10:20:13.5933333' AS DateTime2), 1, N'1', N'12/12/2016', N'ClientIP', NULL)
GO
INSERT [dbo].[application.Applications] ([Id], [ServiceId], [CreatorId], [CreatedOn], [DeviceTypeId], [ApplicationNumber], [UserAgent], [ClientIPAddress], [ParentApplicationId]) VALUES (19, 1, 1, CAST(N'2020-11-26T10:21:55.1600000' AS DateTime2), 1, N'1', N'User1', N'Client IP', NULL)
GO
SET IDENTITY_INSERT [dbo].[application.Applications] OFF
GO
SET IDENTITY_INSERT [dbo].[application.ApplicationStages] ON 
GO
INSERT [dbo].[application.ApplicationStages] ([Id], [ApplicationId], [UserId], [StageId], [CreatedOn], [StageStatusId], [PreviousStageId]) VALUES (3, 16, 1, 1, CAST(N'2020-11-26T10:19:37.6066667' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[application.ApplicationStages] ([Id], [ApplicationId], [UserId], [StageId], [CreatedOn], [StageStatusId], [PreviousStageId]) VALUES (4, 17, 1, 1, CAST(N'2020-11-26T10:20:13.0366667' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[application.ApplicationStages] ([Id], [ApplicationId], [UserId], [StageId], [CreatedOn], [StageStatusId], [PreviousStageId]) VALUES (5, 18, 1, 1, CAST(N'2020-11-26T10:20:13.5933333' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[application.ApplicationStages] ([Id], [ApplicationId], [UserId], [StageId], [CreatedOn], [StageStatusId], [PreviousStageId]) VALUES (6, 19, 1, 1, CAST(N'2020-11-26T10:21:55.1600000' AS DateTime2), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[application.ApplicationStages] OFF
GO
INSERT [dbo].[application.DeviceTypes] ([Id], [Name]) VALUES (1, N'Mobile')
GO
INSERT [dbo].[application.StageStatuses] ([Id], [Name]) VALUES (1, N'Open')
GO
INSERT [dbo].[application.StageStatuses] ([Id], [Name]) VALUES (2, N'Close')
GO
SET IDENTITY_INSERT [dbo].[lookup.Categories] ON 
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (1, N'AD BLU', 8, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (2, N'Air Condition(EESL)', 7, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (3, N'Aluminium/Aluminum Products', 78, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (4, N'Automatic Doors', 9, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (5, N'Automatic Windows', 10, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (6, N'Automobile Spare parts', 11, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (7, N'Baby Care Products
', 6524, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (8, N'Bottled Drinking Water', 77, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (9, N'Cables', 12, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (10, N'Child Restrain Seats', 13, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (11, N'Cigar Label Evaluation', 5494, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (12, N'Cigarettes Label Evaluation', 54, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (13, N'Cigarettes Product Evaluation', 67, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (14, N'Commercial AC', 58, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (15, N'Cosmetics', 14, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (16, N'Detergents', 15, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (17, N'Diesel', 53, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (18, N'ECAS-Ex Electro-mechnical Equipment', 2154, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (19, N'EESL Washing Machine', 2153, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (20, N'Electrical Equipment', 17, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (21, N'Electrical Products', 76, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (22, N'Electronic Nicotine Devices
', 3322, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (23, N'Electronic Nicotine Products (Labels)', 3321, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (24, N'Electronic Nicotine Products Evaluation', 3320, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (25, N'Elevators', 18, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (26, N'Energy Drinks', 19, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (27, N'Escalators', 20, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (28, N'Floor/Wall Tiles', 79, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (29, N'Food Contact Materials', 63, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (30, N'Foods for Special Dietary Use', 5197, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (31, N'Foods for Special Medical Purposes', 5200, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (32, N'G Mark', 21, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (33, N'Green label Scheme', 22, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (34, N'GSO Authentication for Tires', 51, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (35, N'Halal National Mark', 23, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (36, N'Halal National Mark- Cosmetics', 24, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (37, N'Halal Slaughtering House', 25, 4)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (38, N'Hazardous Chemical', 26, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (39, N'Health Protection Products', 6497, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (40, N'Health Protection Products', 6520, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (41, N'Honey', 27, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (42, N'Hover Board', 28, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (43, N'IEC CB Test', 29, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (44, N'Industrial measurement system', 30, 5)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (45, N'Juice and Beverages', 2156, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (46, N'Lane Departure Warning', 31, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (47, N'Laser Products', 32, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (48, N'Lighting', 50, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (49, N'Liquid Petroleum Gas (LPG) cylinder', 6618, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (50, N'Liquid Petroleum Gas (LPG) cylinder accessories', 6621, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (51, N'LPG Cylinders and Accessories', 2151, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (52, N'Lubricating oil', 70, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (53, N'Marine Outboard Engines', 74, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (54, N'Measuring Equipment-Meters', 33, 5)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (55, N'Measuring Medical Equipment', 34, 5)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (56, N'Metrology Workshop registeration', 49, 5)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (57, N'Milk and Dairy Products', 2155, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (58, N'Moassel Label Evaluation', 66, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (59, N'Moassel Product Evaluation', 64, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (60, N'Non Automatic weighing scales', 35, 5)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (61, N'Oil and Gaz Products', 36, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (62, N'Organic Crop Production/Farm', 60, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (63, N'Organic Foods', 37, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (64, N'Organic Livestock', 61, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (65, N'Paints and Varnishes', 38, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (66, N'perfume wholesale', 56, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (67, N'Perfumes&Fragrances', 39, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (68, N'Personal Protective Equipment', 40, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (69, N'Petroleum Products', 62, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (70, N'Plastic Products', 59, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (71, N'Precious Stones and Metals', 2150, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (72, N'Refrigerators', 69, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (73, N'Retreaded Tire', 52, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (74, N'ROHS', 41, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (75, N'Rubber', 42, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (76, N'Seafood Product', 3857, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (77, N'Slaughterhouse', 57, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (78, N'Speed Limiter', 73, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (79, N'Telecommunication Cables', 43, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (80, N'TOBACCO AND TOBACCO PRODUCTS – DOKHA ', 5189, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (81, N'Tobacco Pipe (Dokha) Label Evaluation', 65, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (82, N'Trailer and Semi-trailer', 45, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (83, N'Vehicle', 46, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (84, N'Vehicle Workshop Certification', 5209, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (85, N'Voluntary Chemical', 81, 1)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (86, N'Voluntary Electrical', 82, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (87, N'Voluntary Food', 83, 3)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (88, N'Voluntary Mechanical', 84, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (89, N'Voluntary Medical Electrical Equipment', 5431, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (90, N'Voluntary PPE', 5394, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (91, N'Washing Machines', 72, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (92, N'Water Fixture', 47, 6)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (93, N'Water Heater', 71, 2)
GO
INSERT [dbo].[lookup.Categories] ([Id], [Name], [OldId], [SectionId]) VALUES (94, N'Weighing Instruments', 48, 6)
GO
SET IDENTITY_INSERT [dbo].[lookup.Categories] OFF
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 14, N'UAENB163')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (2, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (4, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (4, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (4, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (4, 14, N'UAENB151')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (5, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (5, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (5, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (5, 14, N'UAENB151')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (6, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (6, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (6, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (6, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (6, 14, N'UAENB0204')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (8, 14, N'UAENB159')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (9, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (9, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (9, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (10, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (10, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (10, 14, N'UAENB167')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (11, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (12, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (13, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 14, N'UAENB163')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (14, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (15, 14, N'UAENB153')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (16, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (17, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (17, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (17, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (17, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (17, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (18, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (19, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (19, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (19, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (19, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 14, N'UAENB154')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (21, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (22, 7, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (22, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (22, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (22, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (22, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (23, 7, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (23, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (23, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (23, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (23, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (24, 7, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (24, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (24, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (24, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (24, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (25, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (25, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (25, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (25, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (25, 14, N'UAENB161')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (26, 14, N'UAENB155')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (27, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (27, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (27, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (27, 14, N'UAENB160')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 13, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (29, 14, N'UAENB164')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 14, N'UAENB165')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (38, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (41, 14, N'UAENB156')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (42, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (42, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (42, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 4, N'UAENB150')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 13, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (44, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (47, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (47, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (47, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (47, 13, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 9, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 13, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (48, 14, N'UAENB168')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (51, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (51, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (52, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (52, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (52, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (52, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (52, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (53, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (53, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (54, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (54, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (54, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (54, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (54, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (55, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (55, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (55, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (55, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (55, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (58, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (59, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (60, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (60, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (60, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (60, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (60, 14, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (62, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (62, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (62, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (63, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (63, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (63, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (64, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (64, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (64, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (65, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (65, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (65, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (66, 14, N'UAENB152')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 6, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (67, 14, N'UAENB152')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (68, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (68, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (68, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (68, 7, NULL)
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (68, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (69, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (69, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (69, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (69, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (69, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (70, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (70, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (70, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (70, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (70, 14, N'UAENB157')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 14, N'UAENB163')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (72, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (73, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (73, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (73, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 14, N'UAENB165')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (74, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (78, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (78, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (78, 14, N'UAENB158')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (79, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (79, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (79, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (79, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (80, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 6, N'NB0014')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (81, 14, N'UAENB162')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (82, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (82, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 14, N'UAENB163')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (91, 15, N'NB0010')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (92, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (92, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (92, 7, N'NB0001')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (92, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (92, 14, N'UAENB0203')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 1, N'NB0013')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 2, N'NB0015')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 3, N'NB0020')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 4, N'NB0003')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 5, N'NB0007')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 9, N'NB0002')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 11, N'NB0019')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 12, N'NB0018')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 13, N'NB0009')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 14, N'UAENB163')
GO
INSERT [dbo].[lookup.CategoryNotifyBodies] ([CategoryId], [NotifyBodyId], [NotifyBodyCertificate]) VALUES (93, 15, N'NB0010')
GO
SET IDENTITY_INSERT [dbo].[lookup.Cities] ON 
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (1, N'Addis Ababa', 64)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (2, N'Baku', 13)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (3, N'Yerevan', 9)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (4, N'Oranjestad', 10)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (5, N'Asmara', 62)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (6, N'Tallinn', 63)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (7, N'Kabul', 1)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (8, N'Quito', 58)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (9, N'Tirana', 2)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (10, N'Berlin', 74)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (11, N'Saint John''s', 7)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (12, N'Andorra la Vella', 4)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (13, N'Jakarta', 92)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (14, N'Luanda', 5)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (15, N'Anguilla', 6)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (16, N'Montevideo', 213)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (17, N'Tashkent', 215)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (18, N'Kampala', 208)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (19, N'Kiev', 209)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (20, N'Connacht
', 95)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (21, N'Leinster', 95)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (22, N'Munster', 95)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (23, N'Ulster', 95)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (24, N'Reykjavik', 90)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (25, N'Bolona', 97)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (26, N'Rome', 97)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (27, N'Madrid', 182)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (28, N'Buenos Aires', 8)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (29, N'Ajloun', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (30, N'Al'' Aqabah', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (31, N'Al Karak', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (32, N'Al Quwaysimah', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (33, N'Al Ramtha', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (34, N'Al Salt', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (35, N'Amman', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (36, N'Azraq', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (37, N'Fuheis', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (38, N'Irbid', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (39, N'Jarash', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (40, N'Juhfiyah', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (41, N'Khirbat as Souk', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (42, N'kufranja', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (43, N'Madaba', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (44, N'Petra', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (45, N'Sahab', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (46, N'Zarqa', 100)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (47, N'Abu Dhabi', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (48, N'Ajman', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (49, N'Dubai', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (50, N'Fujairah', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (51, N'Ras Al-Khaimah', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (52, N'Sharjah', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (53, N'Umm Al-Quwain', 210)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (54, N'Moscow', 164)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (55, N'al-Budayyi', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (56, N'Ali', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (57, N'AL-Malikiyah', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (58, N'Ar Rifa', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (59, N'Jidd Haffs', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (60, N'Madinat Hamad', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (61, N'Madinat Isa', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (62, N'Manama', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (63, N'Muharraq', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (64, N'Sar', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (65, N'Sitra', 15)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (66, N'Brasilia', 28)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (67, N'Lisbon', 159)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (68, N'Ain el Beida', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (69, N'Aïn Oussara', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (70, N'Alger', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (71, N'Annaba', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (72, N'Bab Ezzouar', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (73, N'Baraki', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (74, N'Barika', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (75, N'Batna', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (76, N'Bechar', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (77, N'Bejaia', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (78, N'Biskra', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (79, N'Blida', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (80, N'Bordj Bou Arreridj', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (81, N'Bordj el Kiffan', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (82, N'Bou Saada', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (83, N'Chellalat El Adhaoura', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (84, N'Chlef', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (85, N'Constantine', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (86, N'Djelfa', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (87, N'El Eulma-Snt. A.', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (88, N'El Khroub', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (89, N'El Oued', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (90, N'Ghardaia', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (91, N'Guelma', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (92, N'Jijel', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (93, N'Khenchela', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (94, N'Laghouat', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (95, N'Medea', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (96, N'Messaad', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (97, N'Mostaganem', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (98, N'MSila', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (99, N'Oran', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (100, N'Ouargla', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (101, N'Relizane', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (102, N'Saida', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (103, N'Saida', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (104, N'Setif', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (105, N'Sidi Bel Abbes', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (106, N'Skikda', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (107, N'Souk Ahras', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (108, N'Tebessa', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (109, N'Tiaret', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (110, N'Tlemcen', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (111, N'Touggourt', 3)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (112, N'Ajdabya', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (113, N'Al ''Aziziyah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (114, N'Al Bayda', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (115, N'Al Jawf', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (116, N'Al Khums', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (117, N'Al Marj', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (118, N'Al Qubbah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (119, N'Al Zawia', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (120, N'Bani Walid', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (121, N'Benghazi', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (122, N'Darnah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (123, N'Ghiryen', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (124, N'Misratah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (125, N'Murzuk', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (126, N'Nalut', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (127, N'Sabha', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (128, N'Sabratah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (129, N'Sirt', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (130, N'Sorman', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (131, N'Tarhoona', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (132, N'Tobruk', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (133, N'Tripoli', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (134, N'Yafran', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (135, N'Zliten', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (136, N'Zuwarah', 112)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (137, N'Abu Kamal', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (138, N'ADLEP', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (139, N'Afrin', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (140, N'Ain al-Arab', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (141, N'al dimas', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (142, N'Al kadmus', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (143, N'AL Kardaha', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (144, N'AL kaswah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (145, N'Al Qamishli', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (146, N'Al Qonaitera', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (147, N'ALATARB', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (148, N'al-Bab', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (149, N'Aleppo', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (150, N'Al-Hasakah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (151, N'ALKahtanieah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (152, N'al-Mayadin', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (153, N'ALSEKELBIAH', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (154, N'AMUDAH', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (155, N'an-Nabk', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (156, N'Ariha', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (157, N'ARMANAZ', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (158, N'ar-Raqqa', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (159, N'ar-Rastan', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (160, N'As-Safirah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (161, N'As-Suwayda', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (162, N'ath-Thawrah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (163, N'At-Tall', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (164, N'Azaz', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (165, N'AZRAA', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (166, N'banyas', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (167, N'Damascus', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (168, N'Dara', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (169, N'Darayya', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (170, N'Dayr az-Zawr', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (171, N'Deer Atiah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (172, N'Duma', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (173, N'Hama', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (174, N'Haramlek', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (175, N'Homs', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (176, N'Idlib', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (177, N'Jableh', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (178, N'JAESR ALSHAGUR', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (179, N'jarablus', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (180, N'Khan Shaykhun', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (181, N'Latakia', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (182, N'Maarrat al-Numan', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (183, N'Manbij', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (184, N'MSIAF', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (185, N'Nawa', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (186, N'Qatifh', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (187, N'Ras Alaen', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (188, N'SAFITAH', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (189, N'Salamiyah', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (190, N'SALKED', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (191, N'SALNFAH', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (192, N'shahba', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (193, N'SURAN', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (194, N'Tal kalak', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (195, N'Tartus', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (196, N'Teabt Alamam', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (197, N'Tel reafat', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (198, N'Tudmur', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (199, N'YABRUD', 193)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (200, N'Copenhagen', 53)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (201, N'Praia', 36)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (202, N'San Salvador', 60)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (203, N'Dakar', 171)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (204, N'ad-Damazin', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (205, N'ad-Damir', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (206, N'ad-Du''ain', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (207, N'al-Dschunaina', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (208, N'al-Fashir', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (209, N'al-Managil', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (210, N'al-Qadarif', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (211, N'al-Ubayyid', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (212, N'An-Nahud', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (213, N'Atbara', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (214, N'Ed Dueim', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (215, N'Juba', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (216, N'Kaduqli', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (217, N'Kasala', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (218, N'Khartoum', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (219, N'Kusti', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (220, N'Malakal', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (221, N'new Halfa', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (222, N'Nyala', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (223, N'Omdurman', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (224, N'Port-Soudan', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (225, N'Rabak', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (226, N'Sannar', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (227, N'Shendi', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (228, N'Sindscha', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (229, N'Umm Rawaba', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (230, N'Wad Madani', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (231, N'Wadi Halfa', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (232, N'Waw', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (233, N'Yambio', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (234, N'Yei', 188)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (235, N'Stockholm', 191)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (236, N'Baardheere', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (237, N'Beledweyne', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (238, N'Berbera', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (239, N'Borco', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (240, N'Gaalkacyo', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (241, N'Gardho', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (242, N'Garoowe', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (243, N'Gilib', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (244, N'Hargeisa', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (245, N'Hoby', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (246, N'Kismayo', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (247, N'luuq', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (248, N'Mogadishu', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (249, N'Mogadishu', 179)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (250, N'Ningbo', 41)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (251, N'Ad-Dawr', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (252, N'Afak', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (253, N'Al Diwaniyah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (254, N'Al Hala', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (255, N'Al-Awja', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (256, N'Al-Qaim', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (257, N'Amarah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (258, N'Ar Rutba', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (259, N'Arbil', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (260, N'Baghdad', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (261, N'Baghdadi', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (262, N'Baiji', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (263, N'Balad', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (264, N'Baqubah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (265, N'Basra', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (266, N'Dahuk', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (267, N'Fallujah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (268, N'Green Zone', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (269, N'Haditha', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (270, N'Halabja', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (271, N'Hit', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (272, N'Iskandariya', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (273, N'Kadhimiya', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (274, N'Karbala', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (275, N'Khanaqin', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (276, N'Kirkuk', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (277, N'Kut', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (278, N'Mosul', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (279, N'Muqdadiyah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (280, N'Najaf', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (281, N'Nasiriyah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (282, N'Ramadi', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (283, N'Sadr City', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (284, N'Samarra', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (285, N'Samawah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (286, N'Shamia', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (287, N'Sulaymaniyah', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (288, N'Taji', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (289, N'Tal Afar', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (290, N'Tel Keppe', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (291, N'Tikrit', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (292, N'Umm Qasr', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (293, N'Zakho', 94)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (294, N'Manila', 157)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (295, N'Yaoundé', 34)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (296, N'Vatican City', 86)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (297, N'Al-Jahra', 105)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (298, N'Fahaheel', 105)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (299, N'Kuwait', 105)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (300, N'Madinat al-Hareer', 105)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (301, N'Agadir', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (302, N'Al-Hoceima', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (303, N'Benguerir', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (304, N'Beni Mellal', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (305, N'Berkane', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (306, N'Berrechid', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (307, N'Casablanca', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (308, N'El Aaiún', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (309, N'El Jadida', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (310, N'El-Kelâa-des-Sraghna', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (311, N'Er Rachidia', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (312, N'Essaouira', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (313, N'Faki ben-Sala', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (314, N'Fez', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (315, N'Fnideq', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (316, N'Guelmim', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (317, N'Guercif', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (318, N'Kenitra', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (319, N'Khemisset', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (320, N'khenifra', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (321, N'Khouribga', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (322, N'Ksar el-Kebir', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (323, N'Larache', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (324, N'Marrakesch', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (325, N'Meknes', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (326, N'Mohammedia', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (327, N'Nador', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (328, N'Ouarzazate', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (329, N'Oued Zem', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (330, N'Ouezzane', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (331, N'Oujda', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (332, N'Oulad-Teïma', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (333, N'Rabat', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (334, N'Safi', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (335, N'Sebt Oulad Nemma', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (336, N'Sefrou', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (337, N'Settat', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (338, N'Sidi Kacem', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (339, N'Sidi Slimane', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (340, N'Tangier', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (341, N'Tan-Tan', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (342, N'Taourirt', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (343, N'Taroudannt', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (344, N'Taza', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (345, N'Tetouan', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (346, N'Tiflet', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (347, N'Tiznit', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (348, N'Youssoufia', 131)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (349, N'Mexico City', 126)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (350, N'Abha', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (351, N'Abqaiq', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (352, N'Afif', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (353, N'Al Bahah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (354, N'Al Jafer', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (355, N'Al Kharj', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (356, N'Al Lith', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (357, N'Al Majmaah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (358, N'Al Qunfudhah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (359, N'Al Wajh', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (360, N'Al-`Ula', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (361, N'Al-Gwei''iyyah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (362, N'Al-Hareeq', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (363, N'Al-Namas', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (364, N'Al-Omran', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (365, N'Al-Oyoon', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (366, N'Ar Rass', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (367, N'Arar', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (368, N'As Sulayyil', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (369, N'Az Zaimah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (370, N'Badr', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (371, N'Baljurashi', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (372, N'Bisha', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (373, N'Buraydaah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (374, N'Buraydah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (375, N'Dahaban', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (376, N'Dammam', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (377, N'Dawadmi', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (378, N'Dhahran', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (379, N'Dhurma', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (380, N'Diriyah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (381, N'Duba', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (382, N'Dumat Al-Jandal', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (383, N'faifa', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (384, N'Farasan city', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (385, N'Gurayat', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (386, N'Haail', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (387, N'Hafr Al-Batin', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (388, N'Hajrah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (389, N'Haql', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (390, N'Hofuf', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (391, N'Hotat Bani Tamim', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (392, N'Jalajil', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (393, N'Jeddah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (394, N'Jizan', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (395, N'Jubail', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (396, N'K. Abdullah Economic City', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (397, N'Khafji', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (398, N'Khamis Mushayt', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (399, N'Khobar', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (400, N'Layla', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (401, N'Mecca', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (402, N'Medina', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (403, N'Muzahmiyya', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (404, N'Nagran', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (405, N'Qadeimah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (406, N'Qaisumah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (407, N'Qatif', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (408, N'Rabigh', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (409, N'Rafha', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (410, N'Ras Tanura', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (411, N'Riyadh', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (412, N'Rumailah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (413, N'Safwa city', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (414, N'Saihat', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (415, N'Sakakah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (416, N'Shaqraa', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (417, N'Sharurah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (418, N'Shaybah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (419, N'Tabuk', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (420, N'Taif', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (421, N'Tanomah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (422, N'Tarout', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (423, N'Tayma', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (424, N'Thadiq', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (425, N'Thuqbah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (426, N'Thuwal', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (427, N'Turaif', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (428, N'Turubah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (429, N'Udhailiyah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (430, N'Unaizah', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (431, N'Uqair', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (432, N'Uyayna', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (433, N'Wadi Al-Dawasir', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (434, N'Yanbu', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (435, N'Zulfi', 170)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (436, N'London', 211)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (437, N'Oslo', 148)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (438, N'Vienna', 12)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (439, N'Niamey', 144)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (440, N'Agartala', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (441, N'Agra', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (442, N'Ahmedabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (443, N'Ahmednagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (444, N'Aizawl', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (445, N'Ajmer', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (446, N'Akola', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (447, N'Aligarh', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (448, N'Allahabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (449, N'Alwar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (450, N'Ambattur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (451, N'Ambernath', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (452, N'Amravati', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (453, N'Amritsar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (454, N'Anantapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (455, N'Arrah', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (456, N'Asansol', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (457, N'Aurangabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (458, N'Avadi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (459, N'Bally', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (460, N'Bangalore', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (461, N'Baranagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (462, N'Barasat', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (463, N'Bardhaman', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (464, N'Bareilly', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (465, N'Bathinda', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (466, N'Begusarai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (467, N'Belgaum', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (468, N'Bellary', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (469, N'Bhagalpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (470, N'Bharatpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (471, N'Bhatpara', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (472, N'Bhavnagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (473, N'Bhilai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (474, N'Bhilwara', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (475, N'Bhiwandi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (476, N'Bhopal', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (477, N'Bhubaneswar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (478, N'Bihar Sharif', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (479, N'Bijapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (480, N'Bikaner', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (481, N'Bilaspur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (482, N'Bokaro', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (483, N'Brahmapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (484, N'Bulandshahr', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (485, N'Chandigarh', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (486, N'Chandrapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (487, N'Chennai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (488, N'Coimbatore[N 2]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (489, N'Cuttack', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (490, N'Darbhanga', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (491, N'Davanagere', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (492, N'Dehradun', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (493, N'Delhi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (494, N'Dewas', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (495, N'Dhanbad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (496, N'Dhule', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (497, N'Durg', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (498, N'Durgapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (499, N'Etawah', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (500, N'Faridabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (501, N'Farrukhabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (502, N'Firozabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (503, N'Gandhidham', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (504, N'Gaya', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (505, N'Ghaziabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (506, N'Gopalpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (507, N'Gorakhpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (508, N'Gulbarga', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (509, N'Guntur[3]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (510, N'Gurgaon', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (511, N'Guwahati', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (512, N'Gwalior', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (513, N'Hapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (514, N'Haridwar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (515, N'Hisar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (516, N'Howrah', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (517, N'Hubballi-Dharwad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (518, N'Hyderabad[3]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (519, N'Ichalkaranji', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (520, N'Imphal', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (521, N'Indore', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (522, N'Jabalpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (523, N'Jaipur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (524, N'Jalandhar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (525, N'Jalgaon', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (526, N'Jalna', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (527, N'Jammu', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (528, N'Jamnagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (529, N'Jamshedpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (530, N'Jhansi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (531, N'Jodhpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (532, N'Junagadh', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (533, N'Kadapa', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (534, N'Kakinada', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (535, N'Kalyan-Dombivali', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (536, N'Kamarhati', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (537, N'Kanpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (538, N'Karawal Nagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (539, N'Karimnagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (540, N'Karnal', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (541, N'Katihar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (542, N'Khammam', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (543, N'Kirari Suleman Nagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (544, N'Kochi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (545, N'Kolhapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (546, N'Kolkata', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (547, N'Kollam', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (548, N'Korba', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (549, N'Kota', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (550, N'Kozhikode', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (551, N'Kulti', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (552, N'Kurnool', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (553, N'Latur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (554, N'Loni', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (555, N'Lucknow', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (556, N'Ludhiana', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (557, N'Madurai[N 3]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (558, N'Maheshtala', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (559, N'Malegaon', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (560, N'Mangalore', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (561, N'Mango', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (562, N'Mathura', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (563, N'Mau', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (564, N'Meerut', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (565, N'Mira-Bhayandar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (566, N'Mirzapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (567, N'Moradabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (568, N'Mumbai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (569, N'Muzaffarnagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (570, N'Muzaffarpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (571, N'Mysore', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (572, N'Nagercoil', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (573, N'Nagpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (574, N'Nanded', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (575, N'Nashik', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (576, N'Navi Mumbai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (577, N'Nellore', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (578, N'New Delhi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (579, N'Nizamabad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (580, N'Noida', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (581, N'North Dumdum', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (582, N'Ozhukarai', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (583, N'Pali', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (584, N'Panihati', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (585, N'Panipat', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (586, N'Parbhani', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (587, N'Patiala', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (588, N'Patna', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (589, N'Pimpri-Chinchwad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (590, N'Puducherry', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (591, N'Pune', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (592, N'Purnia', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (593, N'Raichur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (594, N'Raipur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (595, N'Rajahmundry', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (596, N'Rajkot', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (597, N'Rajpur Sonarpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (598, N'Rampur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (599, N'Ranchi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (600, N'Ratlam', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (601, N'Rewa', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (602, N'Rohtak', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (603, N'Rourkela', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (604, N'Sagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (605, N'Saharanpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (606, N'Salem', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (607, N'Sangli-Miraj & Kupwad', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (608, N'Satna', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (609, N'Shahjahanpur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (610, N'Shivamogga (Shimoga)', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (611, N'Sikar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (612, N'Siliguri', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (613, N'Solapur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (614, N'Sonipat', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (615, N'South Dumdum', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (616, N'Sri Ganganagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (617, N'Srinagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (618, N'Surat', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (619, N'Thane', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (620, N'Thanjavur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (621, N'Thiruvananthapuram', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (622, N'Thoothukudi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (623, N'Thrissur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (624, N'Tiruchirappalli[N 4]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (625, N'Tirunelveli', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (626, N'Tirupati', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (627, N'Tirupur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (628, N'Tiruvottiyur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (629, N'Tumkur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (630, N'Udaipur', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (631, N'Ujjain', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (632, N'Ulhasnagar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (633, N'Vadodara', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (634, N'Varanasi', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (635, N'Vasai-Virar', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (636, N'Vijayawada', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (637, N'Visakhapatnam', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (638, N'Vizianagaram', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (639, N'Warangal[4]', 91)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (640, N'New York', 212)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (641, N'Washington D.C.', 212)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (642, N'Tokyo', 99)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (643, N'Aden', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (644, N'Al Hudaydah', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (645, N'al-Marawia', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (646, N'al-Mukalla', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (647, N'Amran', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (648, N'ash-Shir', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (649, N'Bait al-Faqih', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (650, N'bajil', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (651, N'Chanffar', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (652, N'Dhamar', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (653, N'Dhi Sufal', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (654, N'Hajjah', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (655, N'Ibb', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (656, N'Lahij', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (657, N'Rida', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (658, N'Sahar', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (659, N'Sanaa', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (660, N'Sayyan', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (661, N'Taizz', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (662, N'Yarim', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (663, N'zabid', 220)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (664, N'Athens', 77)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (665, N'Asunción', 155)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (666, N'Bahawalpur', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (667, N'Faisalabad', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (668, N'Gujranwala', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (669, N'Gujrat', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (670, N'Hyderabad', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (671, N'Islamabad', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (672, N'Islamabad', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (673, N'Jhang', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (674, N'Karachi', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (675, N'Kasur', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (676, N'Lahore', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (677, N'Larkana', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (678, N'Mardan', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (679, N'Multan', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (680, N'Okara', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (681, N'Peshawar', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (682, N'Quetta', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (683, N'Rahim Yar Khan', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (684, N'Rawalpindi', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (685, N'Sahiwal', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (686, N'Sargodha', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (687, N'Sheikhupura', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (688, N'Sialkot', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (689, N'Sukkur', 150)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (690, N'Melekeok', 151)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (691, N'Bridgetown', 17)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (692, N'Hamilton', 22)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (693, N'Brussels', 19)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (694, N'Sofia', 30)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (695, N'Belmopan', 20)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (696, N'Dhaka', 16)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (697, N'Panama (City)', 153)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (698, N'Porto-Novo', 21)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (699, N'Thimphu', 23)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (700, N'Gaborone', 26)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (701, N'San Juan', 160)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (702, N'Ouagadougou', 31)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (703, N'Bujumbura', 32)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (704, N'Bialystok', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (705, N'Bydgoszcz', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (706, N'Krakow', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (707, N'Lodz', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (708, N'Sopot', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (709, N'Warsaw', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (710, N'Zakopane', 158)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (711, N'La Paz', 24)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (712, N'Lima', 156)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (713, N'Minsk', 18)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (714, N'Bangkok', 198)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (715, N'Ashgabat', 205)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (716, N'Ankara', 204)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (717, N'N''Djamena', 39)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (718, N'Lomé', 199)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (719, N'Funafuti', 207)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (720, N'Tokelau', 200)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (721, N'Ben Arous', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (722, N'Bizerte', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (723, N'Gabes', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (724, N'Kairouan', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (725, N'Kasserine', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (726, N'La Marsa', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (727, N'Medenine', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (728, N'Monastir', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (729, N'Nabeul', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (730, N'Sfax', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (731, N'Sousse', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (732, N'Tunis', 203)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (733, N'Nuku''alofa', 201)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (734, N'Kingston', 98)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (735, N'Nassau', 14)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (736, N'Moroni', 43)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (737, N'Dar es Salaam', 196)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (738, N'Dodoma', 196)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (739, N'Bloemfontein', 180)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (740, N'Cape Town', 180)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (741, N'Pretoria', 180)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (742, N'T''bilisi', 73)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (743, N'Ali Sabieh', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (744, N'Arta', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (745, N'As Ela', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (746, N'Balho', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (747, N'Dikhil', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (748, N'Djibouti', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (749, N'Dorra', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (750, N'Galafi', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (751, N'Holhol', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (752, N'Khor Angar', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (753, N'Obock', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (754, N'Randa', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (755, N'Yoboki', 54)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (756, N'Akka', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (757, N'Al-Bireh', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (758, N'Al-Quds', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (759, N'Baqa al-Gharbiyye', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (760, N'Beit Hanoun', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (761, N'Beit Lahia', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (762, N'Bethlehem', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (763, N'Deir al-Balah', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (764, N'Gaza', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (765, N'Haifa', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (766, N'Hebron', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (767, N'Jabalia', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (768, N'Jaffa', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (769, N'Jenin', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (770, N'Jericho', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (771, N'Jet', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (772, N'Jish', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (773, N'Kafr Kanna', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (774, N'Kafr Qasim', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (775, N'Khan Yunis', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (776, N'Lod', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (777, N'Nablus', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (778, N'Naorah', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (779, N'Nazareth', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (780, N'Qalqilyah', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (781, N'Rafah', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (782, N'Ramallah', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (783, N'Ramla', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (784, N'Sakhnin', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (785, N'Selfeit', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (786, N'Shefa-''Amr', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (787, N'Tubas', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (788, N'Tulkarm', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (789, N'Turaan', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (790, N'Umm Al-Fahm', 152)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (791, N'Roseau', 55)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (792, N'Kigali', 165)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (793, N'Bucharest', 163)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (794, N'Lusaka', 221)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (795, N'Harare', 222)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (796, N'Apia', 167)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (797, N'San Marino', 168)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (798, N'Sri Jayewardenepura-Kotte; see: Colombo', 183)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (799, N'Ljubljana', 177)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (800, N'Singapore', 175)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (801, N'Lobamba', 190)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (802, N'Mbabane', 190)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (803, N'Paramaribo', 189)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (804, N'Bern', 192)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (805, N'Freetown', 174)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (806, N'Victoria', 173)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (807, N'Santiago', 40)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (808, N'Belgrade', 172)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (809, N'Dushanbe', 195)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (810, N'Adam', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (811, N'Al Buraimi', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (812, N'Al Hamra', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (813, N'AL Suwaiq', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (814, N'As Sib', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (815, N'Bahla', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (816, N'Barka', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (817, N'Bidbid', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (818, N'Duqm', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (819, N'Ibri', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (820, N'Izki', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (821, N'Khasab', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (822, N'Mad''ha', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (823, N'Manah', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (824, N'Masirah', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (825, N'Matrah', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (826, N'Muscat', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (827, N'Nizwa', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (828, N'Quriyat', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (829, N'Raysut', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (830, N'Rustaq', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (831, N'Saham', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (832, N'Salalah', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (833, N'Samail', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (834, N'Seeb', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (835, N'Shinas', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (836, N'Sohar', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (837, N'Sur', 149)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (838, N'Libreville', 71)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (839, N'Banjul', 72)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (840, N'Accra', 75)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (841, N'Saint George''s', 79)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (842, N'Nuuk', 78)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (843, N'Guatemala', 81)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (844, N'Guam', 80)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (845, N'Georgetown', 84)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (846, N'Bissau', 82)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (847, N'Conakry', 82)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (848, N'Port-Vila', 216)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (849, N'Caracas', 217)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (850, N'Paris', 70)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (851, N'Helsinki', 68)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (852, N'Suva', 67)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (853, N'Hanoi', 218)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (854, N'Nicosia', 50)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (855, N'al Wakrah', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (856, N'Ar Rayyan', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (857, N'Doha', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (858, N'Dukhan', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (859, N'Ras Laffan', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (860, N'The Pearl-Qatar', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (861, N'Umm Said', 161)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (862, N'Bishkek', 106)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (863, N'Astana', 101)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (864, N'Zagreb', 48)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (865, N'Phnom Penh', 33)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (866, N'Ottawa', 35)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (867, N'Havana', 49)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (868, N'San José', 46)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (869, N'Bogotá', 42)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (870, N'Tarawa', 103)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (871, N'Nairobi', 102)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (872, N'Riga', 108)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (873, N'Alshouf', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (874, N'Baabda', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (875, N'Baalbak', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (876, N'Beirut', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (877, N'Bint Jbeil', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (878, N'Damour', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (879, N'Deer El Qamar', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (880, N'Halba', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (881, N'Jezzine', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (882, N'Junyiah', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (883, N'kfarshouba', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (884, N'Nabatieh', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (885, N'Shamustar', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (886, N'Sour', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (887, N'Zahle', 109)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (888, N'Luxembourg', 115)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (889, N'Monrovia', 111)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (890, N'Vilnius', 114)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (891, N'Maseru', 110)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (892, N'Male', 120)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (893, N'Valletta', 122)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (894, N'Bamako', 121)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (895, N'Johor Bahru', 119)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (896, N'Kuala Lumpur', 119)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (897, N'Antananarivo', 117)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (898, N'Abu Kabeer', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (899, N'Akhmim', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (900, N'Al Arish', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (901, N'Al Fayyum', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (902, N'Al Ghardaqah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (903, N'Al Ismailiyah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (904, N'Al Jizah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (905, N'Al Mahallah al Kubra', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (906, N'Al Mansurah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (907, N'Al Matariyyah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (908, N'Al Minya', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (909, N'Alexandria', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (910, N'Alhawamdeya', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (911, N'Asuit', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (912, N'Aswan', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (913, N'Az Zaqaziq', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (914, N'Banha', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (915, N'Bani Suwayf', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (916, N'Bilbeis', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (917, N'Bur Said', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (918, N'Cairo', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (919, N'city 10th Of Ramadan', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (920, N'City 6 October', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (921, N'Damanhur', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (922, N'Damietta', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (923, N'Disuq', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (924, N'Edfu', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (925, N'engl', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (926, N'Girga', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (927, N'Kafr el-Dawwar', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (928, N'Kafr el-Sheikh', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (929, N'Luxor', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (930, N'Mallawi', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (931, N'Marsa Matruh', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (932, N'Mit Ghamr', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (933, N'Qalyub', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (934, N'Qena', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (935, N'Shibin El Kom', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (936, N'Shubra al Khaymah', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (937, N'Sohag', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (938, N'Suez', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (939, N'Tanta', 59)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (940, N'Lilongwe', 118)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (941, N'Ulaanbaatar', 129)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (942, N'Adel Bagrou', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (943, N'Akjoujt', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (944, N'Aleg', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (945, N'Atar', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (946, N'Ayoûn el-Atroûs', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (947, N'Bababe', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (948, N'Bogue', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (949, N'Bou Gadoum', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (950, N'Boutilimit', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (951, N'Guérou', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (952, N'Kaédi', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (953, N'Kiffa', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (954, N'Magta Lahjar', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (955, N'Mâl', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (956, N'Néma', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (957, N'Nouadhibou', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (958, N'Nouakchott', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (959, N'Oualata', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (960, N'Rosso', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (961, N'Selibaby', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (962, N'Tidjikdja', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (963, N'Timbédra', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (964, N'Tintane', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (965, N'Zouérat', 124)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (966, N'Port Louis', 125)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (967, N'Maputo', 132)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (968, N'Monaco', 128)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (969, N'Montserrat', 130)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (970, N'Windhoek', 135)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (971, N'Yaren District', 136)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (972, N'Kathmandu', 137)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (973, N'Abuja', 145)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (974, N'Managua', 143)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (975, N'Wellington', 142)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (976, N'Niue', 146)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (977, N'Port-au-Prince', 85)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (978, N'Tegucigalpa', 87)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (979, N'Budapest', 89)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (980, N'Amsterdam', 139)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (981, N'The Hague (seat of gov''t)', 139)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (982, N'Busan', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (983, N'Daegu', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (984, N'Goyang', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (985, N'Gwangju', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (986, N'Seosan', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (987, N'Seoul', 181)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (988, N'Adelaide', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (989, N'Darwin', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (990, N'Glenorchy', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (991, N'Hobart', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (992, N'Melbourne', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (993, N'Perth', 11)
GO
INSERT [dbo].[lookup.Cities] ([Id], [Name], [CountryId]) VALUES (994, N'Sydney', 11)
GO
SET IDENTITY_INSERT [dbo].[lookup.Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[lookup.Countries] ON 
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (1, N'Afghanistan', N'AF', N'AFG', N'93', N'4', 804)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (2, N'Albania', N'AL', N'ALB', N'355', N'8', 806)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (3, N'Algeria', N'DZ', N'DZA', N'213', N'12', 830)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (4, N'Andorra', N'AD', N'AND', N'376', N'20', 809)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (5, N'Angola', N'AO', N'AGO', N'244', N'24', 811)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (6, N'Anguilla', N'AI', N'AIA', N'1264', N'660', 812)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (7, N'Antigua and Barbuda', N'AG', N'ATG', N'1268', N'0', 808)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (8, N'Argentina', N'AR', N'ARG', N'54', N'32', 822)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (9, N'Armenia', N'AM', N'ARM', N'374', N'51', 800)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (10, N'Aruba', N'AW', N'ABW', N'297', N'533', 801)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (11, N'Australia', N'AU', N'AUS', N'036', N'61', 3309)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (12, N'Austria', N'AT', N'AUT', N'43', N'40', 854)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (13, N'Azerbaijan', N'AZ', N'AZE', N'994', N'31', 799)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (14, N'Bahamas', N'BS', N'BHS', N'1242', N'44', 898)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (15, N'Bahrain', N'BH', N'BHR', N'973', N'48', 826)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (16, N'Bangladesh', N'BD', N'BGD', N'880', N'50', 871)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (17, N'Barbados', N'BB', N'BRB', N'1246', N'52', 865)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (18, N'Belarus', N'BY', N'BLR', N'375', N'112', 883)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (19, N'Belgium', N'BE', N'BEL', N'32', N'56', 868)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (20, N'Belize', N'BZ', N'BLZ', N'501', N'84', 870)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (21, N'Benin', N'BJ', N'BEN', N'229', N'204', 873)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (22, N'Bermuda', N'BM', N'BMU', N'1441', N'60', 866)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (23, N'Bhutan', N'BT', N'BTN', N'975', N'64', 874)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (24, N'Bolivia', N'BO', N'BOL', N'591', N'68', 880)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (25, N'Bosnia Herzg', N'BA', N'BIH', N'387', N'70', 829)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (26, N'Botswana', N'BW', N'BWA', N'267', N'72', 875)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (27, N'British Virgin Islands', N'VG', N'VGB', N'1284', N'92', 904)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (28, N'Brazil', N'BR', N'BRA', N'55', N'76', 827)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (29, N'Brunei', N'BN', N'BRN', N'673', N'96', 867)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (30, N'Bulgaria', N'BG', N'BGR', N'359', N'100', 869)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (31, N'Burkina Faso', N'BF', N'BFA', N'226', N'854', 877)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (32, N'Burundi', N'BI', N'BDI', N'257', N'108', 878)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (33, N'Cambodia', N'KH', N'KHM', N'855', N'0', 972)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (34, N'Cameroon', N'CM', N'CMR', N'237', N'120', 845)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (35, N'Canada', N'CA', N'CAN', N'1', N'124', 973)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (36, N'Cape Verde', N'CV', N'CPV', N'238', N'132', 836)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (37, N'Cayman Islands', N'CY', N'CYM', N'1345', N'0', 906)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (38, N'Central African Republic', N'CF', N'CAF', N'236', N'0', 913)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (39, N'Chad', N'TD', N'TCD', N'235', N'148', 888)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (40, N'Chile', N'CL', N'CHL', N'56', N'152', 945)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (41, N'China', N'CN', N'CHN', N'86', N'156', 842)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (42, N'Colombia', N'CO', N'COL', N'57', N'170', 977)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (43, N'Comoros', N'KM', N'COM', N'269', N'174', 899)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (44, N'Congo', N'CG', N'COG', N'242', N'178', 847)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (45, N'Cook Islands', N'CK', N'COK', N'682', N'184', 907)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (46, N'Costa Rica', N'CR', N'CRI', N'506', N'188', 976)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (47, N'Côte d''Ivoire', N'CI', N'CIV', N'225', N'384', 975)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (48, N'Croatia', N'HR', N'HRV', N'385', N'191', 971)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (49, N'Cuba', N'CU', N'CUB', N'53', N'192', 974)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (50, N'Cyprus', N'CY', N'CYP', N'357', N'196', 966)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (51, N'Czech Republic', N'CZ', N'CZE', N'420', N'203', 832)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (52, N'Democratic Republic of the Congo', N'CD', N'COD', N'243', N'180', 914)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (53, N'Denmark', N'DK', N'DNK', N'45', N'208', 835)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (54, N'Djibouti', N'DJ', N'DJI', N'253', N'262', 922)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (55, N'Dominica', N'DM', N'DMA', N'1767', N'212', 924)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (56, N'Dominican Republic', N'DO', N'DOM', N'1809', N'214', 833)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (57, N'East Timor', N'TL', N'TLS', N'670', N'0', 894)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (58, N'Ecuador', N'EC', N'ECU', N'593', N'0', 805)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (59, N'Egypt', N'EG', N'EGY', N'20', N'818', 993)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (60, N'El Salvador', N'SV', N'SLV', N'503', N'222', 837)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (61, N'Equatorial Guinea', N'GQ', N'GNQ', N'240', N'622', 959)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (62, N'Eritrea', N'ER', N'ERI', N'291', N'232', 802)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (63, N'Estonia', N'EE', N'EST', N'372', N'233', 803)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (64, N'Ethiopia', N'ET', N'ETH', N'251', N'231', 798)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (65, N'Faroe Islands', N'FO', N'FRO', N'298', N'234', 902)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (66, N'Falkland Islands', N'FK', N'FLK', N'500', N'238', 905)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (67, N'Fiji', N'FJ', N'FJI', N'679', N'242', 964)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (68, N'Finland', N'FI', N'FIN', N'358', N'246', 963)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (69, N'French Polynesia', N'PF', N'PYF', N'689', N'258', 881)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (70, N'France', N'FR', N'FRA', N'33', N'250', 962)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (71, N'Gabon', N'GA', N'GAB', N'241', N'266', 949)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (72, N'Gambia', N'GM', N'GMB', N'220', N'270', 950)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (73, N'Georgia', N'GE', N'GEO', N'995', N'268', 921)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (74, N'Germany', N'DE', N'DEU', N'49', N'276', 807)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (75, N'Ghana', N'GH', N'GHA', N'233', N'288', 951)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (76, N'Gibraltar', N'GI', N'GIB', N'350', N'292', 896)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (77, N'Greece', N'GR', N'GRC', N'30', N'300', 860)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (78, N'Greenland', N'GL', N'GRL', N'299', N'304', 953)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (79, N'Grenada', N'GD', N'GRD', N'1473', N'308', 952)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (80, N'Guam', N'GU', N'GUM', N'1671', N'316', 955)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (81, N'Guatemala', N'GT', N'GTM', N'502', N'320', 954)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (82, N'Guinea', N'GN', N'GIN', N'224', N'324', 957)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (83, N'Guinea-Bissau', N'GW', N'GNB', N'245', N'624', 958)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (84, N'Guyana', N'GY', N'GUY', N'592', N'328', 956)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (85, N'Haiti', N'HT', N'HTI', N'509', N'332', 1012)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (86, N'Holy See', N'VA', N'VAT', N'39', N'336', 846)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (87, N'Honduras', N'HN', N'HND', N'504', N'340', 1013)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (88, N'Hong Kong', N'HK', N'HKG', N'852', N'344', 996)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (89, N'Hungary', N'HU', N'HUN', N'36', N'348', 1014)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (90, N'Iceland', N'IS', N'ISL', N'354', N'352', 819)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (91, N'India', N'IN', N'IND', N'91', N'356', 856)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (92, N'Indonesia', N'ID', N'IDN', N'62', N'360', 810)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (93, N'Iran', N'IR', N'IRN', N'98', N'364', 817)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (94, N'Iraq', N'IQ', N'IRQ', N'964', N'368', 843)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (95, N'Ireland', N'IE', N'IRL', N'353', N'372', 818)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (96, N'Isle Of Man', N'IM', N'IMY', N'44', N'833', 911)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (97, N'Italy', N'IT', N'ITA', N'39', N'380', 820)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (98, N'Jamaica', N'JM', N'JAM', N'1876', N'388', 895)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (99, N'Japan', N'JP', N'JPN', N'81', N'392', 858)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (100, N'Jordan', N'JO', N'JOR', N'962', N'400', 823)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (101, N'Kazakhstan', N'KZ', N'KAZ', N'7', N'398', 969)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (102, N'Kenya', N'KE', N'KEN', N'254', N'404', 979)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (103, N'Kiribati', N'KI', N'KIR', N'686', N'296', 978)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (104, N'North Korea', N'KP', N'PRK', N'850', N'408', 916)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (105, N'Kuwait', N'KW', N'KWT', N'965', N'414', 848)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (106, N'Kyrgyzstan', N'KG', N'KGZ', N'996', N'417', 968)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (107, N'Laos', N'LA', N'LAO', N'856', N'418', 917)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (108, N'Latvia', N'LV', N'LVA', N'371', N'428', 980)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (109, N'Lebanon', N'LB', N'LBN', N'961', N'422', 981)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (110, N'Lesotho', N'LS', N'LSO', N'266', N'426', 986)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (111, N'Liberia', N'LR', N'LBR', N'231', N'430', 984)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (112, N'Libya', N'LY', N'LBY', N'218', N'434', 831)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (113, N'Liechtensten', N'LI', N'LIE', N'423', N'438', 982)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (114, N'Lithuania', N'LT', N'LTU', N'370', N'440', 985)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (115, N'Luxembourg', N'LU', N'LUX', N'352', N'442', 983)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (116, N'Macau', N'MO', N'MAC', N'853', N'446', 987)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (117, N'Madagascar', N'MG', N'MDG', N'261', N'450', 992)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (118, N'Malawi', N'MW', N'MWI', N'265', N'454', 995)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (119, N'Malaysia', N'MY', N'MYS', N'60', N'458', 991)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (120, N'Maldives', N'MV', N'MDV', N'960', N'462', 988)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (121, N'Mali', N'ML', N'MLI', N'223', N'466', 990)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (122, N'Malta', N'MT', N'MLT', N'356', N'470', 989)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (123, N'Marshall Islands', N'MH', N'MHL', N'692', N'584', 908)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (124, N'Mauritania', N'MR', N'MRT', N'222', N'478', 998)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (125, N'Mauritius', N'MU', N'MUS', N'230', N'480', 999)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (126, N'Mexico', N'MX', N'MEX', N'52', N'484', 850)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (127, N'Micronesia', N'FM', N'FSM', N'691', N'583', 1004)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (128, N'Monaco', N'MC', N'MCO', N'377', N'492', 1001)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (129, N'Mongolia', N'MN', N'MNG', N'976', N'496', 997)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (130, N'Montserrat', N'MS', N'MSR', N'1664', N'500', 1002)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (131, N'Morocco', N'MA', N'MAR', N'212', N'504', 849)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (132, N'Mozambique', N'MZ', N'MOZ', N'258', N'508', 1000)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (133, N'Myanmar', N'MM', N'MMR', N'95', N'104', 1003)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (134, N'N. Mariana Is', N'MP', N'MNP', N'1670', N'580', 909)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (135, N'Namibia', N'NA', N'NAM', N'264', N'516', 1005)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (136, N'Nauru', N'NR', N'NRU', N'674', N'520', 1006)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (137, N'Nepal', N'NP', N'NPL', N'977', N'524', 1007)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (138, N'Netherlands Antilles', N'AN', N'ANT', N'599', N'530', 897)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (139, N'Netherlands', N'NL', N'NLD', N'31', N'528', 1015)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (140, N'Nevis', N'KN', N'KNA', N'1869', N'659', 5182)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (141, N'New Calednia', N'NC', N'NCL', N'687', N'540', 970)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (142, N'New Zealand', N'NZ', N'NZL', N'64', N'554', 1010)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (143, N'Nicaragua', N'NI', N'NIC', N'505', N'558', 1009)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (144, N'Niger', N'NE', N'NER', N'227', N'562', 855)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (145, N'Nigeria', N'NG', N'NGA', N'234', N'566', 1008)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (146, N'Niue', N'NU', N'NIU', N'683', N'570', 1011)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (147, N'Norfolk Islands', N'NF', N'NFK', N'672', N'574', 912)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (148, N'Norway', N'NO', N'NOR', N'47', N'578', 853)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (149, N'Oman', N'OM', N'OMN', N'968', N'512', 948)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (150, N'Pakistan', N'PK', N'PAK', N'92', N'586', 863)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (151, N'Palau', N'PW', N'PLW', N'680', N'585', 864)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (152, N'Palestinian Territories', N'PS', N'PSE', N'970', N'275', 923)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (153, N'Panama', N'PA', N'PAN', N'507', N'591', 872)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (154, N'Papua New Guinea', N'PG', N'PNG', N'675', N'598', 861)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (155, N'Paraguay', N'PY', N'PRY', N'595', N'600', 862)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (156, N'Peru', N'PE', N'PER', N'51', N'604', 882)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (157, N'Philippines', N'PH', N'PHL', N'63', N'608', 844)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (158, N'Poland', N'PL', N'POL', N'48', N'616', 879)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (159, N'Portugal', N'PT', N'PRT', N'351', N'620', 828)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (160, N'Puerto Rico', N'PR', N'PRI', N'1', N'630', 876)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (161, N'Qatar', N'QA', N'QAT', N'974', N'634', 967)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (162, N'Moldova', N'MD', N'MDA', N'373', N'498', 919)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (163, N'Romania', N'RO', N'ROM', N'40', N'642', 926)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (164, N'Russian Federation', N'RU', N'RUS', N'7', N'643', 825)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (165, N'Rwanda', N'RW', N'RWA', N'250', N'646', 925)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (166, N'Saint Kitts And Nevis', N'KN', N'KNA', N'1869', N'659', 5446)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (167, N'Samoa', N'WS', N'WSM', N'685', N'882', 929)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (168, N'San Marino', N'SM', N'SMR', N'378', N'674', 932)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (169, N'Sao Tome Prn.', N'ST', N'STP', N'239', N'678', 931)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (170, N'Saudi Arabia', N'SA', N'SAU', N'966', N'682', 851)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (171, N'Senegal', N'SN', N'SEN', N'221', N'686', 838)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (172, N'Serbia', N'RS', N'RSD', N'381', N'891', 946)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (173, N'Seychelles', N'SC', N'SYC', N'248', N'690', 944)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (174, N'Sierra Leone', N'SL', N'SLE', N'232', N'694', 943)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (175, N'Singapore', N'SG', N'SGP', N'65', N'702', 939)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (176, N'Slovakia', N'SK', N'SVK', N'421', N'703', 937)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (177, N'Slovenia', N'SI', N'SVN', N'386', N'705', 938)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (178, N'Solomon Is', N'SB', N'SLB', N'677', N'90', 901)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (179, N'Somalia', N'SO', N'SOM', N'252', N'706', 841)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (180, N'South Africa', N'ZA', N'ZAF', N'27', N'710', 920)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (181, N'South Korea', N'KR', N'KOR', N'410', N'82', 2401)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (182, N'Spain', N'ES', N'ESP', N'34', N'724', 821)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (183, N'Sri Lanka', N'LK', N'LKA', N'94', N'144', 936)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (184, N'Saint Helena', N'SH', N'SHN', N'290', N'654', 935)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (185, N'Saint Lucia', N'LC', N'LCA', N'1758', N'662', 934)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (186, N'St. Pierre, Mq', N'PM', N'SPM', N'508', N'666', 930)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (187, N'Saint Vincent and the Grenadines', N'VC', N'VCT', N'1784', N'670', 933)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (188, N'Sudan', N'SD', N'SDN', N'249', N'736', 839)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (189, N'Suriname', N'SR', N'SUR', N'597', N'740', 941)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (190, N'Swaziland', N'SZ', N'SWZ', N'268', N'748', 940)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (191, N'Sweden', N'SE', N'SWE', N'46', N'752', 840)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (192, N'Switzerland', N'CH', N'CHE', N'41', N'756', 942)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (193, N'Syria', N'SY', N'SYR', N'963', N'760', 834)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (194, N'Taiwan', N'TW', N'TWN', N'886', N'158', 994)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (195, N'Tajikistan', N'TJ', N'TJK', N'992', N'762', 947)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (196, N'Tanzania', N'TZ', N'TZA', N'255', N'834', 915)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (197, N'North Macedonia', N'MK', N'MKD', N'389', N'807', 918)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (198, N'Thailand', N'TH', N'THA', N'66', N'764', 884)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (199, N'Togo', N'TG', N'TGO', N'228', N'768', 889)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (200, N'Tokelau', N'TK', N'TKL', N'690', N'772', 891)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (201, N'Tonga', N'TO', N'TON', N'676', N'776', 893)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (202, N'Trinidad and Tobago', N'TT', N'TTO', N'1868', N'780', 887)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (203, N'Tunisia', N'TN', N'TUN', N'216', N'788', 892)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (204, N'Turkey', N'TR', N'TUR', N'90', N'792', 886)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (205, N'Turkmenistan', N'TM', N'TKM', N'993', N'795', 885)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (206, N'Turks and Caicos Islands', N'TC', N'TCA', N'1649', N'796', 900)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (207, N'Tuvalu', N'TV', N'TUV', N'688', N'798', 890)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (208, N'Uganda', N'UG', N'UGA', N'256', N'800', 815)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (209, N'Ukraine', N'UA', N'UKR', N'380', N'804', 816)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (210, N'United Arab Emirates', N'AE', N'ARE', N'971', N'0', 824)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (211, N'United Kingdom', N'GB', N'GBR', N'44', N'826', 852)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (212, N'United States', N'US', N'USA', N'1', N'840', 857)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (213, N'Uruguay', N'UY', N'URY', N'598', N'858', 813)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (214, N'U.S. Virgin Islands', N'VI', N'VIR', N'1340', N'850', 903)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (215, N'Uzbekistan', N'UZ', N'UZB', N'998', N'860', 814)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (216, N'Vanuatu', N'VU', N'VUT', N'678', N'548', 960)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (217, N'Venezuela', N'VE', N'VEN', N'58', N'862', 961)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (218, N'Vietnam', N'VN', N'VNM', N'84', N'704', 965)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (219, N'Wallis and Futuna', N'WF', N'WLF', N'681', N'876', 910)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (220, N'Yemen', N'YE', N'YEM', N'967', N'887', 859)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (221, N'Zambia', N'ZM', N'ZMB', N'960', N'894', 927)
GO
INSERT [dbo].[lookup.Countries] ([Id], [Name], [ISOCode2], [ISOCode3], [PhoneCode], [NumericCode], [OldCountryId]) VALUES (222, N'Zimbabwe', N'ZW', N'ZWE', N'263', N'716', 928)
GO
SET IDENTITY_INSERT [dbo].[lookup.Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[lookup.NotifyBodies] ON 
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (1, N'Abu Dhabi Quality and Conformity Council', 775)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (2, N'BSI Management Systems Ltd', 776)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (3, N'Dubai Central Laboratory Department / Dubai Municipality', 5235)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (4, N'GulfTIC Certification LLC', 2367)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (5, N'Intertek International Limited Dubai Branch', 781)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (6, N'Prime Certification And Inspection LLC', 782)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (7, N'RACS Quality Certificate issuing Services LLC', 783)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (8, N'RACS QUALITY CERTIFICATES ISSUING SERVICES LLC - راكس لخدمات اصدار شهادات الجودة', 784)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (9, N'SGS Gulf Ltd', 785)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (10, N'SQCLAB QUALITY CERTIFICATION SERVICES', 786)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (11, N'The Q', 5180)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (12, N'TUV Middle East W.L.L', 5110)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (13, N'TUV Rheinland Middle East FZE', 787)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (14, N'TUV SUD Middle East LLC', 3319)
GO
INSERT [dbo].[lookup.NotifyBodies] ([Id], [Name], [OldId]) VALUES (15, N'Underwriters Laboratories Middle East FZ LLC', 788)
GO
SET IDENTITY_INSERT [dbo].[lookup.NotifyBodies] OFF
GO
SET IDENTITY_INSERT [dbo].[lookup.ProductTypes] ON 
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (1, N'*Hand-held Food Mixer', 371)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (2, N'A Farming 1(Animals)', 277)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (3, N'AC to DC power adaptors, power supplies, battery chargers', 278)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (4, N'AD BLU', 279)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (5, N'Adaptors', 3954)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (6, N'AFTER SHAVE BALM', 280)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (7, N'After shave Cologne', 281)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (8, N'AFTER SHAVE LOTION', 282)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (9, N'Air Condition', 753)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (10, N'Air conditioner appliances', 570)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (11, N'Air Cooler', 283)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (12, N'Air filters', 2182)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (13, N'air fryers', 3935)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (14, N'Air mover / blower fan, only for household use', 3875)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (15, N'Air Purifiers', 681)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (16, N'Air-purifiers', 285)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (17, N'Alarm systems for buses and commercial vehicles', 2183)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (18, N'All appliances which deliver automatically all kind of products', 571)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (19, N'All purpose cleaner', 5451)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (20, N'Aluminium Products', 287)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (21, N'Aluminium Profiles', 5239)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (22, N'Analyzers', 5173)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (23, N'Analyzers', 572)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (24, N'Answering systems', 573)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (25, N'Antiperspirants & Deodrants', 288)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (26, N'Appliances for hair-cutting, hair drying, tooth brushing, shaving, massage and other body care appliances', 574)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (27, N'Appliances for heating liquids including tea and coffee brewing appliances', 289)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (28, N'Appliances used for sewing, knitting, weaving and other processing for textiles Irons and other appliances for ironing, mangling and other care of clothing', 575)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (29, N'Aquarium and garden pond pumps', 290)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (30, N'ARGENTINA-JUICE AND BEVERAGES PRODUCTS', 5138)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (31, N'ARGENTINA-MILK AND DAIRY PRODUCTS', 5140)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (32, N'Artificial Nail Extensions', 291)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (33, N'Audio Amplifier', 2412)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (34, N'Audio amplifiers', 576)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (35, N'Audio/Video Player', 2415)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (36, N'Automatic dispensers for hot drinks', 577)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (37, N'Automatic dispensers for hot or cold bottles or cans', 578)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (38, N'Automatic dispensers for money', 579)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (39, N'Automatic dispensers for solid products', 580)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (40, N'Automatic Doors', 2247)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (41, N'Automatic movement transfer liquid', 6596)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (42, N'Automatic Windows', 2262)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (43, N'AV CENTER', 479)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (44, N'B Farming 2 (Plants)', 292)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (45, N'Babies elastomeric feeding bottle teats', 5459)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (46, N'Baby Formula, Follow up formula/ baby food', 5206)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (47, N'Ballast', 293)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (48, N'Ballasts', 5362)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (49, N'BAP Finfish', 3860)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (50, N'Bar Soap', 294)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (51, N'Bath Capsules', 295)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (52, N'Bath Tablets', 296)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (53, N'Battery chargers', 3956)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (54, N'BEARD SERUM', 297)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (55, N'Berry-juice extractors', 3896)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (56, N'Biodiesel Fuels (B100)', 3399)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (57, N'BLENDER', 744)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (58, N'Blenders', 3897)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (59, N'Bluetooth Audio System', 487)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (60, N'Bluetooth Audio System', 488)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (61, N'Blush', 298)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (62, N'Blush', 738)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (63, N'Body Care', 299)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (64, N'Body Lotion', 300)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (65, N'Body Protective clothing', 2241)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (66, N'Body Wash', 301)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (67, N'boilers', 3933)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (68, N'Bottled Drinking Water', 774)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (69, N'BOWL CLEANER', 5463)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (70, N'Brake lining & Brake drum', 302)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (71, N'Brake pads', 2187)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (72, N'Brake System and Brake Pads', 3552)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (73, N'Brake systems', 2188)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (74, N'bread makers', 3938)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (75, N'Bread toasters for household and similar use', 3904)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (76, N'Breath Freshners', 303)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (77, N'Bronze Highlighters', 304)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (78, N'Built-in Speed Limiter', 6639)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (79, N'C Processing 1 (Perishable animal products)', 305)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (80, N'Cable reels', 306)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (81, N'Cables', 307)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (82, N'Callus Remover', 308)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (83, N'Car batteries', 2189)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (84, N'Car coolers', 2190)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (85, N'Cardiology', 581)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (86, N'Cardiology equipment', 5167)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (87, N'Carpet sweepers', 582)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (88, N'CEILING FAN', 309)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (89, N'Ceiling fans', 3869)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (90, N'Ceiling mounted heat lamp appliances', 3923)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (91, N'Cellular telephones', 583)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (92, N'Centralized data processing:', 584)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (93, N'Centrifugal clothes dryers and clothes washing machines, including machines which both wash and dry', 310)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (94, N'Centrifugal juicers and slow juicers', 3893)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (95, N'Charcoal Burner', 311)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (96, N'Cheek Colour', 312)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (97, N'Chemical and biochemical manufacturing', 313)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (98, N'Chemical Disinfectants and Antiseptics', 6507)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (99, N'Chemical disinfectants and antiseptics - Hygienic hand wash - Test method and requirements (phase 2/step 2)', 5406)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (100, N'Chemical disinfectants and antiseptics. Hygienic hand rub. Test method and requirements (phase 2/step 2)', 5400)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (101, N'Chemical disinfectants and antiseptics. Quantitative suspension test for the evaluation of bactericidal activity of chemical disinfectants and antiseptics used in food, industrial, domestic and institutional areas. Test method and requirements (phase 2, step 1)', 5398)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (102, N'Chemical disinfectants and antiseptics. Surgical hand disinfection. Test method and requirements (phase 2, step 2).', 5403)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (103, N'Chest Freezer', 314)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (104, N'Chest freezers not exceeding 800 liters capacity', 3884)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (105, N'Chicken Eggs', 3338)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (106, N'Child Restrain Seats', 315)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (107, N'Child use and care articles - Drinking equipment -Part 3 :Chemical requirements', 5454)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (108, N'Child use and care articles- Drinking equipment -Part 1: General and physical requirements', 5455)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (109, N'Children Toys', 749)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (110, N'Chilled And Frozen Poultry Edible Giblets', 3359)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (111, N'Chilled chicken', 3354)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (112, N'Chilled Marinated Meats', 3362)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (113, N'Chlor or its derivatives', 316)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (114, N'Cigar Label Evaluation', 5496)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (115, N'Cigarettes Label Evaluation', 746)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (116, N'Cigarettes Label Evaluation- Voluntary', 2214)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (117, N'Cigarettes Product Evaluation', 763)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (118, N'Cigarettes Product Evaluation- Voluntary', 2215)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (119, N'Citrus-fruit', 3894)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (120, N'Citrus-Pine', 3866)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (121, N'Clean Air Suits', 6506)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (122, N'Cleaner used for clothing made from delicates synthetic fibers, wool and silk include children''s clothes.', 317)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (123, N'Cleaner used for clothing made from delicates synthetic fibers, wool and silkinclude children''s clothes.', 2213)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (124, N'Cleaner used for cotton clothing and lints and synthetic fibers or mixed', 318)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (125, N'Clocks, watches and equipment for the purpose of measuring, indicating or registering time', 585)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (126, N'Clothes dryers', 586)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (127, N'Clothes dryers', 319)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (128, N'Clothes washing machines', 320)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (129, N'Clothes Washing Machines', 3888)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (130, N'Coffee and Coffee Products - Roasted Coffee Beans', 2328)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (131, N'Coffee Grinder', 321)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (132, N'Coffee mills', 3898)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (133, N'Cologne', 322)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (134, N'Combination microwave ovens', 3926)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (135, N'Combination toasters', 3908)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (136, N'Combined refrigerator freezers not exceeding 900 liters capacity', 3880)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (137, N'Commercial Air conditioner', 323)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (138, N'Commercial air-conditioning systems', 324)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (139, N'Commercial dispensing appliances and vending machines', 325)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (140, N'Commercial kitchen machines', 326)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (141, N'Commercial microwave ovens', 327)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (142, N'Commercial refrigerating appliances', 328)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (143, N'Compact fluorescent lamps', 587)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (144, N'Computers for biking, diving, running and rowing', 588)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (145, N'Concealers', 329)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (146, N'Concentrated oils', 330)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (147, N'Conditioner', 331)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (148, N'Consumer series Desktops and Laptops Computers, All-in-one PCs', 3385)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (149, N'Control gears', 332)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (150, N'Control Gears', 5364)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (151, N'Convector heaters', 3920)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (152, N'cookers', 3932)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (153, N'Cooking', 589)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (154, N'Copying equipment', 590)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (155, N'Cord extension sets', 3955)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (156, N'Cordless telephones', 591)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (157, N'Cosmetics-Voluntary', 2191)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (158, N'COTTON CANDY MAKER', 453)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (159, N'Cream whippers', 3902)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (160, N'Creams', 333)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (161, N'Creams &Lotions', 334)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (162, N'Curling combs', 3914)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (163, N'Curling irons', 3911)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (164, N'Curling rollers with separate heaters,only for household use', 3912)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (165, N'Cuticle Oils', 335)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (166, N'D Processing 2 (Perishable vegetable products)', 336)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (167, N'Deep fat fryers, frying pans and similar appliances', 337)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (168, N'Degreaser', 5461)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (169, N'Deodorant', 338)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (170, N'Deodorant 1', 339)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (171, N'Deodorant 2', 340)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (172, N'Depilators', 341)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (173, N'Desert coolers and humidifiers', 342)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (174, N'Detergent Voluntary', 343)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (175, N'Dialysis', 592)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (176, N'Dialysis equipment', 5168)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (177, N'Diesel', 6592)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (178, N'Diesel', 745)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (179, N'Diesel-Voluntary', 2216)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (180, N'Digital still and video cameras', 3382)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (181, N'Discharge and halogen lamps', 344)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (182, N'Dish wash liquid', 5462)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (183, N'Dish washing machines', 593)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (184, N'Distribution', 345)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (185, N'DLP Projector', 481)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (186, N'Domestic electric heating apparatus', 346)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (187, N'Domestic electrical fans', 347)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (188, N'Domestic water coolers and fountains', 348)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (189, N'Domestic water pumps', 349)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (190, N'DOOR BELL', 3396)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (191, N'Door locks and door hinges', 2192)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (192, N'Double door or multi-door refrigerators combined', 3881)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (193, N'Douches', 350)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (194, N'Dressings', 351)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (195, N'Drills', 594)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (196, N'Duct fans, only for household use', 3876)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (197, N'DVD Home Theatre System', 482)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (198, N'DVD Player', 483)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (199, N'DVD PLAYER', 480)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (200, N'E Processing 3 (Products with long shelf life at room temparature)', 352)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (201, N'Eau de Cologne', 353)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (202, N'Eau de Perfumes (EDP)', 354)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (203, N'Eau de Toilettes (EDT)', 355)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (204, N'ECAS-Ex Electro-mechnical Equipment', 2193)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (205, N'E-Cigarette', 3853)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (206, N'E-Cigarettes Heating Device', 2277)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (207, N'E-Cigarettes Label Evaluation', 2274)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (208, N'E-Cigarettes Product Evaluation', 2275)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (209, N'Edible Vegetable Oils - Part 1', 6552)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (210, N'Edible Vegetable Oils – Part 2', 6553)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (211, N'Edible Vegetable Oils - Part 4 - Blended edible vegetable oils', 6555)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (212, N'EESL Washing Machine', 2248)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (213, N'Egg beaters', 3903)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (214, N'egg boilers', 3942)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (215, N'Electric fans', 356)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (216, N'Electric fans', 595)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (217, N'Electric heating appliances', 596)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (218, N'Electric hot plates', 597)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (219, N'Electric household sewing machines', 357)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (220, N'Electric instantaneous or storage water heaters and immersion heaters', 358)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (221, N'Electric iron', 3950)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (222, N'Electric irons', 359)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (223, N'Electric Kettle', 360)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (224, N'Electric knives', 598)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (225, N'Electric massage appliances for household and similar purposes', 361)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (226, N'Electric oral hygiene appliances for house hold and similar purposes', 362)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (227, N'Electric Pressure Cooker', 363)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (228, N'Electric radiators', 599)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (229, N'Electric smoothing irons', 364)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (230, N'electric space heaters', 3924)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (231, N'Electric stationary cooking ranges, hobs, ovens and similar appliances', 365)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (232, N'Electric stoves', 600)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (233, N'Electric towel rails', 366)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (234, N'Electric trains or car racing sets', 601)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (235, N'Electrical airconditioners', 284)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (236, N'Electrical and electronic typewriters', 602)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (237, N'Electrical Equipment', 2263)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (238, N'Electrical item used in exploded atmosphere', 367)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (239, N'Electrical motorcycle', 3408)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (240, N'ELECTRICAL PRODUCT', 2194)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (241, N'Electrical vehicle', 368)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (242, N'Electrical Water Dispenser', 369)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (243, N'Electrical-Voluntary', 370)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (244, N'Electronic Nicotine Devices', 3326)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (245, N'Electronic Nicotine Label Evaluation', 3327)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (246, N'Electronic Nicotine Products Evaluation', 3328)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (247, N'ELECTRONICALLY HEATED TOBACCO DEVICES', 2298)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (248, N'Electro-thermic hair-dressing apparatus and hand dryers', 373)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (249, N'Elevators', 2217)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (250, N'Elevators-Voluntary', 2218)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (251, N'Emulsion', 374)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (252, N'Energy Drinks', 771)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (253, N'Energy Drinks-Voluntary', 2219)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (254, N'Equipment for spraying, spreading, dispersing or other treatment of liquid or gaseous substances by other means', 603)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (255, N'Equipment for turning, milling, sanding, grinding, sawing, cutting, shearing, drilling, making holes, punching, folding, bending or similar processing of wood, metal and other materials', 604)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (256, N'Equipment manufacturing', 377)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (257, N'Escalators', 2227)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (258, N'Escalator-Voluntary', 2228)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (259, N'EXHAUST FAN', 770)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (260, N'exhaust fan', 378)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (261, N'Exhaust fans, only for household use', 3878)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (262, N'Extension cords', 379)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (263, N'External hard drives supplied with an external power supply', 3386)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (264, N'Eye and face protection', 2222)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (265, N'Eye care', 380)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (266, N'Eye Colour/Eye shadow', 381)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (267, N'EYE CREAM', 382)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (268, N'EYE GEL', 383)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (269, N'EYE MAKE UP', 384)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (270, N'Eye Makeup Remover', 385)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (271, N'Eyebrow Pencil', 386)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (272, N'Eyeliner', 387)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (273, N'F Feed production', 388)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (274, N'Fabric steamers', 389)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (275, N'Fabric Steamers', 3952)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (276, N'FACE CARE', 390)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (277, N'Face Cleanser', 391)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (278, N'FACE MAKE-UP', 392)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (279, N'Face Powder', 393)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (280, N'Face Scrub', 394)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (281, N'Face Wash', 395)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (282, N'FACIAL MAKE UP', 396)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (283, N'Facial Makeup', 397)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (284, N'Facial Makeup1', 398)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (285, N'Facial Sauna', 399)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (286, N'Facial Scrub', 400)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (287, N'Facial Wash', 401)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (288, N'Facsimile', 605)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (289, N'Fall management equipment', 376)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (290, N'Fan Heater', 402)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (291, N'Fan heaters', 3916)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (292, N'Farming 1(Animals)', 403)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (293, N'Farming 2 (Plants)', 404)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (294, N'Feed production', 405)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (295, N'Feminine Deodorants', 406)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (296, N'Fertilization Test', 5175)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (297, N'Fertilization tests', 606)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (298, N'Filtering Half Masks', 6500)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (299, N'Fixed immersion heaters', 3948)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (300, N'flat paint', 407)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (301, N'Flexible nipples for baby feeding bottle.', 6526)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (302, N'Floor standing fans; Box fans', 3874)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (303, N'Floor treatment machines and wet scrubbing machines', 408)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (304, N'Floor/Wall Tiles', 409)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (305, N'Floor/Wall Tiles', 741)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (306, N'Fluorescent lamps (CFL, CFLi)', 410)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (307, N'Food Contact Materials', 759)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (308, N'Food Contact Materials-Voluntary', 411)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (309, N'Food grinders', 3890)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (310, N'Food grinders and mixers, fruit or vegetable juice extractors', 412)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (311, N'Food mixers', 3892)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (312, N'Food packages - Part 1: general requirements.', 6533)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (313, N'Food packages - Part 2: plastic packages - general requirements.', 6535)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (314, N'Food Processor', 413)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (315, N'Food service', 414)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (316, N'FOOD STEAMER', 415)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (317, N'Food waste disposers', 416)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (318, N'Foods for Special Dietary Use', 5199)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (319, N'Foods for Special Medical Purposes', 5202)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (320, N'Foot Massager', 417)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (321, N'Foot protection', 2225)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (322, N'Foot warmers', 418)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (323, N'Foundation', 419)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (324, N'Freezers', 420)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (325, N'Freezers', 5174)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (326, N'Front-load washing machines', 421)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (327, N'FROZEN CHICKENS', 3355)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (328, N'Fryers', 608)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (329, N'Fuel oil', 6600)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (330, N'G Food service', 422)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (331, N'G Mark', 423)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (332, N'Game consoles', 3383)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (333, N'Garden blowers', 424)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (334, N'Gas and/or electric (combi) stationary cooking ranges, hobs, ovens and similar appliances', 425)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (335, N'General requirements for the specifications of food contact materials.', 6536)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (336, N'General use mains plugs, socket outlets, mains configuration adapters and power track systems', 426)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (337, N'Glue Guns', 428)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (338, N'Grain grinders', 3899)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (339, N'Grass shears and trimmers', 429)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (340, N'Green label Scheme', 2229)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (341, N'Grills', 3929)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (342, N'Grills and similar portable cooking appliances', 3928)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (343, N'Grills, toasters and similar portable cooking appliances', 430)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (344, N'Grinders, coffee machines and equipment for opening or sealing containers or packages', 609)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (345, N'Ground Roasted Coffee', 2329)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (346, N'GSO Authentication for Tires', 2266)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (347, N'GSO Authentication for Tires', 742)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (348, N'H Distribution', 431)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (349, N'Hair Bleaches', 432)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (350, N'HAIR CARE', 433)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (351, N'Hair care equipment', 434)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (352, N'Hair Clipper', 546)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (353, N'Hair Conditioners', 435)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (354, N'Hair Cream', 436)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (355, N'Hair Curler', 437)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (356, N'Hair Dryer', 438)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (357, N'Hair Dyes & Colours', 439)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (358, N'Hair Oil', 440)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (359, N'Hair Removal Cream', 523)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (360, N'Hair Removal Device', 441)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (361, N'Hair Shampoo', 442)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (362, N'Hair Spray', 443)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (363, N'Hair straightener', 2184)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (364, N'Hair straighteners', 3910)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (365, N'Hair Straightners& Relaxers', 444)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (366, N'Hair Tints', 445)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (367, N'Hairdryers', 3909)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (368, N'Halal National Mark- Cosmetics', 446)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (369, N'Hand dryers', 3915)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (370, N'Hand protection', 2223)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (371, N'Hand Wash', 767)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (372, N'Hand-held Food Mixer', 372)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (373, N'Hand-held massagers', 447)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (374, N'Hand-held video game consoles', 610)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (375, N'Hazardous Chemical', 2264)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (376, N'Head protection', 375)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (377, N'Hearing protection', 2224)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (378, N'Heat Gun', 448)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (379, N'Heaters for detachable curlers, only for household use', 3913)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (380, N'Heaters for use in greenhouses, only for domestic use', 3922)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (381, N'Heating pads', 449)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (382, N'Heating regulators', 611)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (383, N'Hi-fi recorders', 612)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (384, N'High intensity discharge lamps, including pressure sodium lamps and metal halide lamps', 613)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (385, N'High Pressure Cleaner', 450)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (386, N'High pressure cleaners and steamers', 451)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (387, N'Home Audio System', 484)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (388, N'Home Audio Systems', 485)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (389, N'Home Theatre System', 2414)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (390, N'Honey', 452)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (391, N'hot plates', 3931)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (392, N'Hotplate', 454)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (393, N'Household dishwashers', 457)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (394, N'Household Kerosene', 6606)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (395, N'Household microwave ovens', 458)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (396, N'Household refrigerators and/or freezers', 459)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (397, N'household synthetic detergents-High Suds (Powder with high foam used in upper lid washing machines or in hand washing', 460)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (398, N'household synthetic detergents-Low suds (powder used in front load automatic machines with low foam)', 461)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (399, N'household syntheticdetergents-High Suds (Powder with high foam used in upper lid washing machines or in hand washing', 2207)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (400, N'household syntheticdetergents-Low suds (powder used in front load automatic machines with low foam)', 2208)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (401, N'Hover Board', 2265)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (402, N'Humidifier', 462)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (403, N'I Services', 463)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (404, N'IEC CB Test', 464)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (405, N'Incandescent lamps', 465)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (406, N'Industrial measurement system', 2231)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (407, N'Industrial measurement system - Industrial measurement system', 2249)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (408, N'Industrial water coolers and fountains', 467)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (409, N'Insect killers', 468)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (410, N'Instantaneous', 3332)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (411, N'Instantaneous type', 469)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (412, N'Instantaneous water heaters', 3946)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (413, N'interior', 470)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (414, N'Ironers', 471)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (415, N'Ironers', 3951)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (416, N'J Transport and Storage', 473)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (417, N'Juicer', 474)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (418, N'Juices and Drinks', 2196)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (419, N'K Equipment manufacturing', 475)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (420, N'Kitchen machines', 476)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (421, N'L Chemical and biochemical manufacturing', 477)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (422, N'Laboratory equipment for in-vitro diagnosis', 614)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (423, N'Labortary equipment for in-vitro diagnosis', 5171)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (424, N'Laminated safety glass', 2197)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (425, N'Lamps', 5358)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (426, N'Landline phones (Corded/Cordless Phones)', 3336)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (427, N'Laptop computers (CPU, mouse, screen and keyboard included)', 615)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (428, N'Large cooling appliances', 478)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (429, N'Laser Products', 486)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (430, N'Lawnmowers', 489)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (431, N'LED lamps', 490)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (432, N'LED TELEVISION', 748)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (433, N'LED Tube', 491)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (434, N'LFL – Linear Fluorescent Lamps', 492)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (435, N'Light reflectors', 2198)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (436, N'Lighting', 737)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (437, N'Limited Series Vehicle', 493)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (438, N'LIP CARE', 494)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (439, N'LIP CARE', 496)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (440, N'Lip color', 772)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (441, N'Lip Colour', 495)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (442, N'Lipcolor', 497)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (443, N'Lipstick', 498)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (444, N'Liquid carpet Shampoos', 499)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (445, N'Liquid Chlorine for industrial purposes', 500)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (446, N'Liquid Glass Cleaner', 501)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (447, N'Liquid Petroleum Gas (LPG) filling and storage', 6581)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (448, N'Liquid-filled radiators', 3917)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (449, N'LOTION AND CREAM', 502)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (450, N'LOTION AND CREAM', 466)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (451, N'LOTION AND CREAM', 427)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (452, N'LOTION AND CREAM', 721)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (453, N'LOTION AND CREAM - GERMANY', 2185)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (454, N'LOTION AND CREAM - INDIA', 2186)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (455, N'Lotions', 503)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (456, N'Low pressure sodium lamps', 616)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (457, N'Low-pressure regulators for valves of liquefied petroleum gas cylinders', 6624)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (458, N'LPG Cylinder Accessories', 2250)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (459, N'LPG Cylinders', 739)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (460, N'LPG cylinders', 6620)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (461, N'LPG Cylinders-Voluntary', 2232)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (462, N'Lubricants, industrial oils and related products (class L) – Family E (internal combustion engine oils) – oils (categories EMA and EMB)', 6616)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (463, N'Lubricating oil', 765)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (464, N'Lubricating oil for engine', 6587)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (465, N'Lubricating oil-Voluntary', 2233)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (466, N'Luminaires', 504)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (467, N'Luminaires', 5360)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (468, N'Luminaires for fluorescent lamps with the exception of luminaires in households', 617)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (469, N'Lung ventilators — Part 4: Particular requirements for operator-powered resuscitators', 5425)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (470, N'Lung ventilators for medical use — Part 3: Particular requirements for emergency and transport ventilators', 5422)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (471, N'Lung ventilators for medical use — Particular requirements for basic safety and essential performance — Part 5: Gas-powered emergency resuscitators', 5427)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (472, N'M Packaging and wrapping matrial manufacturing', 505)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (473, N'machines, only for household use', 3901)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (474, N'Mainframes', 618)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (475, N'Make up remover', 506)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (476, N'Manicure &Pedicure Products', 507)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (477, N'Manually operated household switches, MCB and earth leakage circuit breakers', 508)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (478, N'Marine Outboard Engines', 769)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (479, N'Martadella (Luncheon) meat', 3360)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (480, N'Mascara', 509)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (481, N'Masks', 510)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (482, N'Massage appliances', 511)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (483, N'Massage beds, belts, chairs and pads', 512)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (484, N'Materials for the use and care of the child - Drinking equipment - Part 3: Chemical requirements.', 6531)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (485, N'Materials for the use and care of the child - drinking tools - Part 1: General and physical requirements.', 6530)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (486, N'Materials for the use and care of the child: cutlery and dinnerware', 6537)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (487, N'Materials for the use and care of the child: cutlery and dinnerware', 5452)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (488, N'Measuring, weighing or adjusting appliances for household or laboratory equipment', 619)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (489, N'Meat', 513)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (490, N'Meat Grinder', 514)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (491, N'Meat products-Pastrami', 3361)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (492, N'Mechanical', 515)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (493, N'Medical electrical equipment — Part 2-13: Particular requirements for basic safety and essential performance of an anaesthetic workstation [Including: ISO 806012-13:2011/Amd.1:2015, AMENDMENT 1 and ISO 80601-213:2011/Amd.2:2018, AMENDMENT  [2]', 5433)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (494, N'Medical electrical equipment — Part 2-70: Particular requirements for basic safety and essential performance of sleep apnoea breathing therapy equipment', 5435)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (495, N'Medical electrical equipment — Part 2-74: Particular requirements for basic safety and essential performance of respiratory humidifying equipment', 5437)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (496, N'Medical electrical equipment — Part 2-79: Particular requirements for basic safety and essential performance of ventilatory support equipment for ventilatory impairment', 5439)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (497, N'Medical electrical equipment — Part 2-80: Particular requirements for basic safety and essential performance of ventilatory support equipment for ventilatory insufficiency', 5441)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (498, N'Medical Face Masks', 6499)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (499, N'Medical face masks - Requirements and test methods', 5415)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (500, N'Medical face masks - Requirements and test methods', 5378)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (501, N'Medical Gloves', 6502)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (502, N'Medical gloves for single use', 5484)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (503, N'Medical Instruments', 516)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (504, N'Metrology', 669)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (505, N'Metrology - Scales', 2205)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (506, N'Metrology - Workshop registeration', 2254)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (507, N'Metrology Workshop Registration', 752)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (508, N'Microwave ovens', 517)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (509, N'Microwave ovens', 3925)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (510, N'Microwaves', 620)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (511, N'Milk and Dairy Products', 2251)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (512, N'Milk content (FTA – Tax purposes)', 5196)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (513, N'Mincer', 518)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (514, N'Mincers', 3891)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (515, N'Mini fridges and beverage coolers, for household use only', 3883)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (516, N'Minicomputers', 621)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (517, N'MIXER/GRINDER', 519)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (518, N'Moassel Label Evaluation', 762)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (519, N'Moassel Label Evaluation-Voluntary', 2234)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (520, N'Moassel Product Evaluation', 760)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (521, N'Moassel Product Evaluation-Voluntary', 2235)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (522, N'Modified Vehicle', 520)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (523, N'Monitors', 5179)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (524, N'Mouthwash', 521)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (525, N'Multifunctional food processors and kitchen', 3900)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (526, N'Multi-media Speakers', 3389)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (527, N'Musical instruments', 622)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (528, N'N Other materials manufacturing', 522)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (529, N'Nail Color', 524)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (530, N'Nail Polish', 525)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (531, N'Nail Polish Removers', 526)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (532, N'Nali Polish&Eanmels', 527)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (533, N'Non- Carbonated Beverages Products (FTA-Tax Purposes)', 5221)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (534, N'Non Sprays (concentrated perfume', 286)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (535, N'Non Sprays (concentrated perfume - alcohol free)', 2200)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (536, N'Non-Alcoholic Beverages Products (FTA-Tax Purposes)', 5223)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (537, N'Non-Energy Drinks (FTA-Tax Purposes)', 5225)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (538, N'Non-Petroleum Base Brake Fluids for Hydraulic Systems', 6612)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (539, N'Notebook computers', 623)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (540, N'Notepad computers', 624)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (541, N'Nuclear medicine', 625)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (542, N'Nuclear medicine equipment', 5170)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (543, N'Oil', 528)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (544, N'Oil and Gaz Products', 2236)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (545, N'oil based', 529)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (546, N'Oil filters', 2199)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (547, N'Oil Filters and Air Filters', 3557)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (548, N'Oils', 530)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (549, N'Oral hygiene appliances', 531)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (550, N'Organic Crop Production/Farm', 755)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (551, N'Organic Crop Production/Farm-Voluntary', 756)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (552, N'Organic Crop Production/Farm-Voluntary', 2237)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (553, N'Organic Food', 532)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (554, N'Organic Livestock', 757)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (555, N'Organic Livestock-Voluntary', 2238)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (556, N'Other', 533)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (557, N'Other appliances for cleaning', 626)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (558, N'Other appliances for detecting, preventing, monitoring, treating, alleviating illness, injury or disability', 627)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (559, N'Other appliances for detecting, preventing, monitoring,treating,alleviating illness ,injury or disability', 5176)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (560, N'Other fanning, exhaust ventilation and conditioning equipment', 628)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (561, N'Other large appliances for heating rooms, beds, seating furniture', 629)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (562, N'Other large appliances used for cooking and other processing of food', 630)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (563, N'Other large appliances used for refrigeration, conservation and storage of food', 631)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (564, N'Other lighting or equipment for the purpose of spreading or controlling light with the exception of filament bulbs', 632)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (565, N'Other materials manufacturing', 534)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (566, N'Other monitoring and control instruments used in industrial installations (for example, in control panels)', 633)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (567, N'Other ovens; cookers, cooking plates, boiling rings, grillers and roasters; Rice Cookers', 535)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (568, N'Other products and equipment for the collection, storage, processing, presentation or communication of information by electronic means user terminals and systems', 634)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (569, N'Other products or equipment for the purpose of recording or reproducing sound or images, including signals or other technologies for the distribution of sound and image than by telecommunications', 635)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (570, N'Other products or equipment of transmitting sound, images or other information by telecommunications', 636)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (571, N'Others', 536)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (572, N'Outboard marine engines', 537)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (573, N'Outdoor barbecues', 538)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (574, N'Oven', 539)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (575, N'Oven toasters', 3907)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (576, N'oven+hotplate', 540)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (577, N'Oxo-biodegradable Plastic Products', 541)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (578, N'Packaging and wrapping matrial manufacturing', 542)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (579, N'Paints and Varnished-Voluntary', 5184)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (580, N'Paints and Varnishes-Voluntary', 543)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (581, N'pancake makers', 3937)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (582, N'Panel heaters', 3919)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (583, N'Partition fans', 3877)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (584, N'Pay telephones', 637)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (585, N'Pedestal fans', 3870)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (586, N'PERFUME', 472)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (587, N'perfume wholesale', 750)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (588, N'perfume wholesale-Voluntary', 2239)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (589, N'Perfumes', 544)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (590, N'Perfumes&Fragrances-Voluntary', 545)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (591, N'Personal Cleaniless', 547)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (592, N'Personal computers (CPU, mouse, screen and keyboard included)', 638)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (593, N'Personal computing:', 639)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (594, N'Personal Eye-Protection (Face Shield and Goggles)', 6504)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (595, N'Personal Grooming Kit', 548)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (596, N'Petroleum Liquefied Gas-mixture of commercial propane and butane', 5186)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (597, N'Petroleum Products', 758)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (598, N'Petroleum products -Fuels (class F) – Specifications of marine fuels', 6609)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (599, N'Petroleum Products-Voluntary', 549)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (600, N'Pine disinfectant', 5460)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (601, N'Pizza Maker', 455)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (602, N'Plastic Products', 754)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (603, N'Plastic Products-Voluntary', 2240)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (604, N'Plugs and socketoutlets', 3953)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (605, N'Plugs, socket-outlets, adaptors, cord extension sets and chargers', 550)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (606, N'Pocket and desk calculators', 640)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (607, N'Portable Air Conditioner', 551)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (608, N'Portable hand-held tools (IEC 60745s)', 552)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (609, N'Portable heating tools', 553)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (610, N'Portable immersion heaters', 554)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (611, N'Portable immersion heaters', 3949)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (612, N'Poultry', 555)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (613, N'Powder', 556)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (614, N'Powders', 557)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (615, N'Pre shave Lotions (all types)', 558)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (616, N'Precious Stones and Metals', 2252)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (617, N'PREPARED MEAT - BURGER MEAT', 3363)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (618, N'Prepared Meat - Sausage', 3356)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (619, N'Prepared Meat Frozen Bread Crumb Enrobed Poultry Products', 3364)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (620, N'Prepared Meat Minced Chicken Meat', 3357)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (621, N'Pressure regulators, automatic change-over devices, having a maximum regulated pressure of 4 bar, with a maximum capacity of 150 kg/h, associated safety devices and adaptors for butane, propane, and their mixtures', 6523)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (622, N'primer', 559)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (623, N'Printer', 2409)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (624, N'Printer units', 641)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (625, N'Printers', 642)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (626, N'Processed meat: Poultry sausage', 3358)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (627, N'Processing 1 (Perishable animal products)-EQM', 560)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (628, N'Processing 2 (Perishable vegetable products)-EQM', 561)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (629, N'Processing 3 (Products with long shelf life at room temparature)', 562)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (630, N'Product Status Declaration', 740)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (631, N'Product Status Declaration', 2267)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (632, N'Projector', 2411)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (633, N'Projectos', 563)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (634, N'Protective Clothing', 6503)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (635, N'Protective clothing – General requirements', 5420)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (636, N'Protective Gloves', 6501)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (637, N'Protective gloves against dangerous chemicals and microorganisms - Part 5: Terminology and performance requirements for micro-organisms risks', 5418)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (638, N'Pulmonary ventilators', 5169)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (639, N'Pulmonary ventilators', 643)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (640, N'Qatar Shipment', 747)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (641, N'Radiant heaters', 3918)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (642, N'Radio sets', 644)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (643, N'Radiotherapy equipment', 645)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (644, N'Radiotherapy equipment', 5164)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (645, N'Range Hood', 564)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (646, N'Range hoods', 565)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (647, N'Ready-to-use disposable diapers.', 6532)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (648, N'Rearview mirrors', 2201)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (649, N'Rear-view Mirrors, Optical Reflectors and Safety Laminated Glass', 3555)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (650, N'refrigerator freezers not exceeding 900 liters capacity', 3882)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (651, N'Refrigerators', 646)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (652, N'Refrigerators, freezers and other refrigerating or freezing equipment', 566)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (653, N'Refrigerators-Voluntary', 2202)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (654, N'Relays and flashes', 2203)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (655, N'Requirements and testing for biological evaluation', 5487)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (656, N'Requirements and testing for freedom from holes', 5485)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (657, N'Requirements and testing for physical properties', 5486)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (658, N'Requirements and testing for shelf life determination', 5488)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (659, N'Respiratory protection', 2243)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (660, N'Respiratory protective devices. Filtering half masks to protect against particles. Requirements, testing, marking', 5369)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (661, N'Respiratory protective devices. Filtering half masks to protect against particles. Requirements, testing, marking.', 5410)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (662, N'Respiratory protective devices. Particle filters. Requirements, testing, marking', 5412)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (663, N'Retreaded Tire', 743)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (664, N'Retreaded Tire - Voluntary', 2253)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (665, N'RICE COOKER', 567)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (666, N'rice cookers', 3941)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (667, N'Rims', 2204)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (668, N'Rinses', 568)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (669, N'Rinses & Shampoos', 569)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (670, N'roasters', 3930)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (671, N'ROHS', 607)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (672, N'ROHS-Tools for riveting, nailing or screwing or removing rivets, nails, screws or similar uses tools for welding, soldering or similar use', 647)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (673, N'Room heaters', 665)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (674, N'Rubber', 666)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (675, N'Rubber hoses for household appliances using liquefied petroleum gases', 6633)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (676, N'SAJ MAKER', 456)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (677, N'Sandwich Maker', 667)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (678, N'Sandwich toasters', 3906)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (679, N'Sauna heating', 668)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (680, N'Saws', 648)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (681, N'Scales', 649)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (682, N'Scanner', 2410)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (683, N'Seat belt', 2206)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (684, N'Services', 670)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (685, N'Sewing machines', 650)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (686, N'Shampoos', 671)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (687, N'Shampoos & Rinses', 672)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (688, N'Shavers, hair clippers and similar appliances', 673)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (689, N'Shaving Balms', 674)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (690, N'Shaving Creams', 675)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (691, N'SHAVING GEL', 676)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (692, N'Shaving Oil', 677)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (693, N'Shaving Products', 678)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (694, N'Shaving Soap', 679)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (695, N'Shower Gel', 680)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (696, N'Single - Use- Disposable Baby Diapers', 5453)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (697, N'Single door refrigerators', 3879)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (698, N'Skin or hair care', 682)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (699, N'Slaughterhouse', 751)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (700, N'slow cookers', 3940)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (701, N'Smoke detector', 651)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (702, N'Soap & Body Washes', 684)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (703, N'Soap & Face Washes', 685)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (704, N'soap flakes intended for domestic purposes.', 686)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (705, N'Sodium Bicarbonate', 687)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (706, N'Soldering Iron', 5150)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (707, N'Soother for babies and toddlers - Part 1: General safety requirements.', 6527)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (708, N'Soother for babies and toddlers - Part 2: Chemical requirements and tests.', 6528)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (709, N'Soother for infants and toddlers - Part 3: Physical requirements', 6529)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (710, N'Soothers for babies and young children - Part 1:General safety requirements', 5458)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (711, N'Soothers for babies and young children - Part 2 :Chemical requirements and tests', 5457)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (712, N'Soothers for babies and young children -Part 3 : Physical requirements', 5456)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (713, N'Soundbar', 3387)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (714, N'Soy milk makers', 3944)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (715, N'Speed Limiter', 768)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (716, N'Spin Extractors', 3887)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (717, N'Splash', 688)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (718, N'Split-type', 689)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (719, N'Sports equipment with electric or electronic components coin slot machines', 652)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (720, N'Sprays', 690)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (721, N'squeezers', 3895)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (722, N'STAND MIXER', 691)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (723, N'Standard Specification for Performance of Materials Used in Medical Face Masks', 5429)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (724, N'Standard Test Method for Evaluation of Hygienic Handwash and Handrub Formulations for Virus-Eliminating Activity Using the Entire Hand', 5408)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (725, N'Stationary circulation pumps', 692)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (726, N'Stationary cooking ranges, hobs, ovens and similar appliances', 3927)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (727, N'Steam Cleaner', 693)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (728, N'Steam cookers', 3939)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (729, N'Storage type', 694)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (730, N'Storage water heaters', 3947)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (731, N'Straight fluorescent lamps', 653)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (732, N'Submersible and table fountain pumps', 695)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (733, N'Sugar', 696)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (734, N'Sugar content (FTA – Tax purposes)', 5193)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (735, N'Sunblock Cream', 697)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (736, N'Sunblock Liquid', 698)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (737, N'Sunless Tanners', 699)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (738, N'Sunscreen Gel', 700)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (739, N'Surface-cleaning appliances for household use employing liquids or steam', 701)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (740, N'Surgical Drapes and Gowns', 6505)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (741, N'Synthetic detergents  for Kitchen used for vegetables& fruits,', 2209)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (742, N'Synthetic detergents  for Kitchen used for washing cookware', 2210)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (743, N'Synthetic detergents  for Kitchen used for washing kitchen utensils', 2211)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (744, N'Synthetic detergents  for Kitchen used for washing tableware', 2212)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (745, N'Synthetic detergents for Kitchen used for vegetables& fruits,', 702)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (746, N'Synthetic detergents for Kitchen used for washing cookware', 703)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (747, N'Synthetic detergents for Kitchen used for washing kitchen utensils', 704)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (748, N'Synthetic detergents for Kitchen used for washing tableware', 705)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (749, N'Table fans', 3872)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (750, N'table-top ovens', 3934)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (751, N'Technical equipment for communication and audio and video', 3378)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (752, N'Telecommunication Cables', 706)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (753, N'Telephones', 654)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (754, N'Television sets', 655)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (755, N'Telex', 656)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (756, N'Thermal-storage room heaters', 707)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (757, N'Thermostats', 657)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (758, N'Toasters', 658)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (759, N'Toasters', 708)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (760, N'Tobacco and Tobacco Products', 709)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (761, N'TOBACCO AND TOBACCO PRODUCTS – DOKHA', 5191)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (762, N'Tobacco Pipe (Dokha) Label Evaluation', 761)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (763, N'Tobacco Pipe (Dokha) Product Evaluation', 764)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (764, N'Tonics', 710)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (765, N'Tools for mowing or other gardening activities', 659)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (766, N'Tooth brushes and oral irrigators', 711)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (767, N'Toothpaste', 712)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (768, N'Toothpastes', 713)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (769, N'Top-load washing machines', 714)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (770, N'Tower fans', 3871)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (771, N'Trailer and Semi-Trailer', 715)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (772, N'Transport and Storage', 716)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (773, N'TRIMMER', 717)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (774, N'Tubular heaters', 3921)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (775, N'Tumble Dryers', 3886)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (776, N'Tumble-dryers', 718)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (777, N'TV Decoders and Set-top boxes', 3384)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (778, N'TV Monitors', 3864)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (779, N'TV Panels', 719)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (780, N'Unleaded Gasoline', 6603)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (781, N'UPRIGHT FREEZER', 720)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (782, N'Upright freezers not exceeding 900 liters capacity', 3885)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (783, N'UV & infrared radiation', 683)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (784, N'UV & infrared radiation - skin tanning', 2195)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (785, N'Vacuum cleaners', 660)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (786, N'Vacuum cleaners and water-suction cleaning appliances', 722)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (787, N'Valves for gas cylinders', 6626)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (788, N'VCD, DVD, Blu-ray Players', 3381)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (789, N'Vehicle Batteries', 3556)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (790, N'Vehicle Radiators System', 3553)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (791, N'vertical and/or horizontal heating', 3905)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (792, N'Video cameras', 661)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (793, N'Video games', 662)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (794, N'Video recorders', 663)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (795, N'Voluntary', 723)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (796, N'Voluntary Air Condition', 2244)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (797, N'Voluntary Cables', 2245)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (798, N'Voluntary Chemical', 724)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (799, N'Voluntary Detergents', 725)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (800, N'Voluntary Food', 726)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (801, N'Voluntary Mechanical', 727)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (802, N'Voluntary-Bottled Drinkin Water', 728)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (803, N'waffle irons', 3936)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (804, N'Wall fans', 3873)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (805, N'Warming plates and similar appliances', 3943)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (806, N'Washer Dryers', 3889)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (807, N'Washer-dryer', 729)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (808, N'Washing machines', 664)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (809, N'Washing machines below 3 KG', 3404)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (810, N'Water bed heaters', 730)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (811, N'Water Dispenser', 731)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (812, N'Water filled foot massagers', 732)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (813, N'Water Fixture', 733)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (814, N'Water Heater', 766)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (815, N'Wax', 734)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (816, N'Weighing Instruments', 2246)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (817, N'Wheels/Rim, Door Locks and Hinges', 3558)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (818, N'Window AC', 735)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (819, N'Window-type', 736)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (820, N'Wireless Presentation system', 3380)
GO
INSERT [dbo].[lookup.ProductTypes] ([Id], [Name], [OldId]) VALUES (821, N'Yoghurt makers', 3945)
GO
SET IDENTITY_INSERT [dbo].[lookup.ProductTypes] OFF
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (1, N'Chemical', 5)
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (2, N'Electrical', 4)
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (3, N'Food', 3)
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (4, N'Halal', 1)
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (5, N'Metrology', 2)
GO
INSERT [dbo].[lookup.Sections] ([Id], [Name], [OldId]) VALUES (6, N'Mechanical', 6)
GO
SET IDENTITY_INSERT [dbo].[lookup.SubCategories] ON 
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (1, N'AC to DC power adaptors, power supplies, battery chargers', 85, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (2, N'AD BLU', 86, 1)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (3, N'Air Condition', 245, 2)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (4, N'Air-conditioners', 87, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (5, N'Alarm systems for buses and commercial vehicles', 2170, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (6, N'Aluminium Products', 88, 3)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (7, N'Appliances for heating liquids including tea and coffee brewing appliances', 220, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (8, N'Appliances for Skin & Hair Care', 89, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (9, N'ARGENTINA-JUICE AND BEVERAGES PRODUCTS', 5137, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (10, N'ARGENTINA-MILK AND DAIRY PRODUCTS', 5139, 57)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (11, N'Automatic Doors', 2157, 4)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (12, N'Automatic movement transfer liquid', 6594, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (13, N'Automatic Windows', 2255, 5)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (14, N'Baby Care Products
', 6525, 7)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (15, N'Baby Formula, Follow up formula/ baby food', 5205, 30)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (16, N'Baby Products', 91, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (17, N'Ballasts', 5361, 48)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (18, N'Bath Products', 92, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (19, N'Bio-Diesel', 3398, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (20, N'Body care Products', 93, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (21, N'Body Protective clothing', 186, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (22, N'Bottled Drinking Water', 275, 8)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (23, N'Brake System and Brake Pads', 3530, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (24, N'Built-in Speed Limiter', 6636, 78)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (25, N'Cables', 94, 9)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (26, N'Centrifugal clothes dryers and clothes washing machines, including machines which both wash and dry', 95, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (27, N'Chicken Eggs', 3339, 87)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (28, N'Child Restrain Seats', 96, 10)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (29, N'Children Toys', 238, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (30, N'Cigar Label Evaluation', 5495, 11)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (31, N'Cigarettes Label Evaluation', 237, 12)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (32, N'Cigarettes Label Evaluation- Voluntary', 97, 12)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (33, N'Cigarettes Product Evaluation', 255, 13)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (34, N'Cigarettes Product Evaluation- Voluntary', 98, 13)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (35, N'Clothes drying machines and electric towel rails', 225, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (36, N'Clothes washing machines and dryers', 264, 91)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (37, N'COFFEE PRODUCT', 2326, 87)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (38, N'Coloured textiles detergents', 99, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (39, N'Combined audio/video systems (non-professional)', 235, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (40, N'Commercial AC', 100, 14)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (41, N'Commercial air-conditioning systems', 229, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (42, N'Commercial dispensing appliances and vending machines', 217, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (43, N'Commercial kitchen machines', 227, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (44, N'Commercial microwave ovens', 224, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (45, N'Control Gear', 101, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (46, N'Control Gears', 5363, 48)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (47, N'Cosmetics-Voluntary', 102, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (48, N'Desert coolers and humidifiers', 246, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (49, N'Detergents-Voluntary', 103, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (50, N'Diesel', 236, 17)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (51, N'Diesel', 6590, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (52, N'Diesel-Voluntary', 104, 17)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (53, N'Domestic electric fans, air-curtains, extractors, stand-alone range hoods and air-purifiers', 241, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (54, N'Domestic electric heating apparatus', 105, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (55, N'Domestic electrical fans', 106, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (56, N'Domestic electromechanical appliances', 231, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (57, N'Domestic water pumps', 270, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (58, N'Drinking water coolers and fountains', 266, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (59, N'ECAS-Ex Electro-mechnical Equipment', 2173, 18)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (60, N'E-Cigarettes Heating Device', 2276, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (61, N'E-Cigarettes Label Evaluation', 2272, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (62, N'E-Cigarettes Product Evaluation', 2273, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (63, N'Edible Vegetable Oil- Voluntary', 6551, 87)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (64, N'EESL Washing Machine', 2174, 19)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (65, N'Electric household sewing machines', 226, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (66, N'Electric instantaneous or storage water heaters and immersion heaters', 107, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (67, N'Electric irons, ironers and fabric steamers', 244, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (68, N'Electric ranges, hob assemblies, stationary ovens, gas burning appliances', 276, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (69, N'Electric smoothing irons', 108, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (70, N'Electric water heaters', 262, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (71, N'Electrical', 109, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (72, N'Electrical Equipment', 2256, 20)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (73, N'Electrical item used in exploded atmosphere', 110, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (74, N'Electrical motorcycle', 3407, 83)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (75, N'Electrical vehicle', 111, 83)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (76, N'Electrical-Voluntary', 112, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (77, N'Electronic Nicotine Devices ', 3325, 22)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (78, N'Electronic Nicotine Label Evaluation', 3324, 23)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (79, N'Electronic Nicotine Products Evaluation', 3323, 24)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (80, N'ELECTRONICALLY HEATED TOBACCO DEVICES  ', 2282, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (81, N'Electro-thermic hair-dressing apparatus and hand dryers', 113, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (82, N'Elevators', 114, 25)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (83, N'Elevators-Voluntary', 115, 25)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (84, N'emulsion based', 116, 65)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (85, N'Energy Drinks-Voluntary', 117, 26)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (86, N'Escalators', 127, 27)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (87, N'Escalator-Voluntary', 128, 27)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (88, N'Extension cables and cable reels', 257, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (89, N'Eye and face protection', 120, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (90, N'Eye Makeup products', 129, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (91, N'Face care Products', 130, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (92, N'Facial Makeup Products', 131, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (93, N'Fall management equipment', 126, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (94, N'Floor/Wall Tiles', 132, 28)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (95, N'Food Contact Materials', 251, 29)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (96, N'Food Contact Materials-Voluntary', 133, 29)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (97, N'Food grinders and mixers, fruit or vegetable juice extractors', 134, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (98, N'Foods for Special Dietary Use', 5198, 30)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (99, N'Foods for Special Medical Purposes', 5201, 31)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (100, N'Foot care products', 135, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (101, N'Foot protection', 124, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (102, N'Fuel oil', 6598, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (103, N'G Mark', 136, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (104, N'GALVANIZED COILS AND SHEETS', 2327, 88)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (105, N'General use mains plugs, socket outlets, mains configuration adapters and power track systems', 232, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (106, N'Germicidal Liquid Detergent for general purpose', 137, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (107, N'Green label Scheme', 138, 33)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (108, N'GSO Authentication for Tires', 2259, 34)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (109, N'Hair care equipment', 271, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (110, N'Hair Care Products', 139, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (111, N'Hair Colouring Products', 140, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (112, N'Hair Removing Products', 141, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (113, N'Halal National Mark', 142, 35)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (114, N'Halal National Mark- Cosmetics', 143, 36)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (115, N'Halal Slaughtering House', 144, 37)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (116, N'Hand care Products', 145, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (117, N'Hand protection', 121, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (118, N'Hazardous Chemical', 2257, 38)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (119, N'Head protection', 122, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (120, N'Health Protection Products', 6498, 39)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (121, N'Health Protection Products', 6521, 40)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (122, N'Hearing protection', 123, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (123, N'High Pressure Cleaner', 146, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (124, N'Honey', 148, 41)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (125, N'Household dishwashers', 263, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (126, N'Household electric heaters', 260, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (127, N'Household electro-thermic cooking appliances (other than ovens)', 218, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (128, N'Household Kerosene', 6605, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (129, N'Household microwave ovens', 223, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (130, N'Household refrigerators and freezers', 234, 72)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (131, N'Hover Board', 2258, 42)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (132, N'IEC CB Test', 149, 43)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (133, N'Immersion heaters, ultraviolet and infrared sun beds, water bed heaters, electric blankets, heating pads, foot warmers, appliances and pumps for use with aquariums, garden ponds and sauna heaters', 150, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (134, N'Incandescent, flourescent, CFL, LED and discharge lamps', 259, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (135, N'Industrial measurement system', 151, 44)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (136, N'Industrial measurement system - Industrial measurement system', 2175, 44)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (137, N'Insect killers', 265, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (138, N'IT/Communication/Audio Video Equipment', 2408, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (139, N'Juices and Drinks', 2176, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (140, N'Lamps ', 5357, 48)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (141, N'Laser Products', 152, 47)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (142, N'Lighting', 222, 48)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (143, N'Limited series Vehicle', 153, 83)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (144, N'Liquid carpet Shampoos', 154, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (145, N'Liquid Chlorine for industrial purposes', 155, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (146, N'Liquid Glass Cleaner', 156, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (147, N'Liquid Petroleum Gas (LPG) Cylinder', 6619, 49)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (148, N'Liquid Petroleum Gas (LPG) filling and storage', 6580, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (149, N'Liquified Petroleum Gas', 5185, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (150, N'Low-pressure regulators for valves', 6622, 50)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (151, N'LPG Cylinder Accessories', 2177, 51)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (152, N'LPG Cylinders', 230, 17)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (153, N'LPG Cylinders-Voluntary', 157, 17)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (154, N'Lubricants, industrial oils and related products (class L) – Family E (internal combustion engine oils) – oils (categories EMA and EMB)', 6615, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (155, N'Lubricating oil', 258, 52)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (156, N'Lubricating oil for engine ', 6585, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (157, N'Lubricating oil-Voluntary', 158, 52)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (158, N'Luminaires', 240, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (159, N'Luminaires', 5359, 48)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (160, N'Maintenance of Modified vehicles', 5211, 84)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (161, N'Manually operated household switches, MCB and earth leakage circuit breakers', 272, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (162, N'Marine Outboard Engines', 269, 53)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (163, N'Massage Appliances', 159, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (164, N'Medical Instruments', 160, 55)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (165, N'Metrology', 216, 56)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (166, N'Metrology - Workshop registeration', 2181, 56)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (167, N'Microwave ovens', 161, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (168, N'Milk and Dairy Products', 2178, 57)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (169, N'Milk content (FTA – Tax purposes)', 5195, 57)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (170, N'Moassel Label Evaluation', 254, 58)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (171, N'Moassel Label Evaluation-Voluntary', 162, 58)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (172, N'Moassel Product Evaluation', 252, 59)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (173, N'Moassel Product Evaluation-Voluntary', 163, 59)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (174, N'Modified Vehicle', 164, 83)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (175, N'Nail Products', 165, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (176, N'Non- Carbonated Beverages Products (FTA-Tax Purposes)', 5220, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (177, N'Non-Alcoholic Beverages Products (FTA-Tax Purposes)', 5222, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (178, N'Non-Alcoholic Energy drinks', 166, 26)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (179, N'Non-ducted room air-conditioners', 273, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (180, N'Non-Energy Drinks (FTA-Tax Purposes)', 5224, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (181, N'Non-inductrial vacuum cleaners', 243, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (182, N'Non-Petroleum Base Brake Fluids for Hydraulic Systems', 6611, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (183, N'Normal/Routine Maintenance', 5210, 84)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (184, N'Oil and Gaz Products', 167, 61)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (185, N'oil based', 168, 65)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (186, N'Oil Filters and Air Filters', 3542, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (187, N'Oral care Products', 169, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (188, N'Oral Hygiene Appliances', 170, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (189, N'Organic Crop Production/Farm', 248, 62)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (190, N'Organic Crop Production/Farm-Voluntary', 171, 62)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (191, N'Organic Foods', 172, 63)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (192, N'Organic Foods-Voluntary', 173, 63)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (193, N'Organic Livestock', 249, 64)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (194, N'Organic Livestock-Voluntary', 174, 64)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (195, N'Other ovens; cookers, cooking plates, boiling rings, grillers and roasters; Rice Cookers', 175, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (196, N'Others', 176, 54)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (197, N'Outboard marine engines', 268, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (198, N'Paints and Varnished-Voluntary', 5183, 85)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (199, N'Paints and Varnishes-Voluntary', 177, 65)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (200, N'perfume wholesale', 239, 66)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (201, N'perfume wholesale-Voluntary', 178, 66)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (202, N'Perfumes&Fragrances', 179, 67)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (203, N'Perfumes&Fragrances-Voluntary', 180, 67)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (204, N'Personal care/grooming appliances', 219, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (205, N'Personal Cleaniless', 181, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (206, N'Petroleum products -Fuels (class F) – Specifications of marine fuels', 6608, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (207, N'Petroleum Products-Voluntary', 182, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (208, N'Plastic Products', 247, 70)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (209, N'Plastic Products-Voluntary', 183, 70)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (210, N'Plugs, socket-outlets, adaptors, cord extension sets and chargers', 184, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (211, N'Portable heating appliances', 185, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (212, N'Power tools', 221, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (213, N'Precious Stones and Metals', 2179, 71)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (214, N'Product Status Declaration', 2260, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (215, N'Rear-view Mirrors, Optical Reflectors and Safety Laminated Glass', 3540, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (216, N'Refrigerators, freezers and other refrigerating or freezing equipment', 187, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (217, N'Refrigerators-Voluntary', 188, 72)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (218, N'Relays and flashes', 2171, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (219, N'Respiratory protection', 190, 68)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (220, N'Retreaded Tire', 213, 73)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (221, N'Retreaded Tire', 233, 73)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (222, N'Retreaded Tire - Voluntary', 2180, 73)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (223, N'ROHS', 191, 74)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (224, N'RoHS – Interim', 5162, 74)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (225, N'RoHS Medical– Interim', 5163, 74)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (226, N'Rubber', 192, 75)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (227, N'Rubber hoses', 6623, 50)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (228, N'Scales', 193, 60)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (229, N'Seafood Product', 3859, 76)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (230, N'Seat belt', 2161, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (231, N'ShavingProducts', 194, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (232, N'Slaughterhouse', 242, 77)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (233, N'Soap Flakes', 195, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (234, N'Sodium Bicarbonate', 196, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (235, N'SOUND SIGNALLING DEVICES', 3395, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (236, N'Speed Limiter', 267, 78)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (237, N'Stand alone video playing and recording systems (non-professional)', 228, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (238, N'Sugar content (FTA – Tax purposes)', 5192, 45)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (239, N'Sunscreen & Sun tan products', 197, 15)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (240, N'Synthetic detergents', 198, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (241, N'Synthetic detergents  for Kitchen', 2172, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (242, N'Synthetic detergents for Kitchen', 199, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (243, N'Synthetic liquid detergents for clothing and fabric', 200, 16)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (244, N'Technical equipment for communication and audio and video', 3377, 21)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (245, N'Telecommunication Cables', 201, 79)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (246, N'Toasters', 202, 32)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (247, N'Tobacco and Tobacco Products', 203, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (248, N'TOBACCO AND TOBACCO PRODUCTS – DOKHA ', 5190, 80)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (249, N'Tobacco Pipe (Dokha) Label Evaluation', 253, 81)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (250, N'Tobacco Pipe (Dokha) Product Evaluation', 256, NULL)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (251, N'Trailer and Semi-Trailer', 204, 82)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (252, N'Unleaded Gasoline', 6602, 69)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (253, N'Vehicle Batteries', 3541, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (254, N'Vehicle Radiators System', 3539, 6)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (255, N'Vehicle Sensor', 205, 46)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (256, N'Voluntary', 206, 86)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (257, N'Voluntary Air Condition', 207, 2)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (258, N'Voluntary Bottled Drinking Water', 208, 8)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (259, N'Voluntary Cables', 209, 9)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (260, N'Voluntary Chemical', 210, 85)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (261, N'Voluntary Cosmetics and Personal Care', 5397, 85)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (262, N'Voluntary Food', 211, 87)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (263, N'Voluntary Mechanical', 212, 88)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (264, N'Voluntary Medical Electrical Equipment', 5432, 89)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (265, N'Voluntary PPE', 5395, 90)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (266, N'Water Fixture', 214, 92)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (267, N'Water Heater', 261, 93)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (268, N'Weighing Instruments', 215, 94)
GO
INSERT [dbo].[lookup.SubCategories] ([Id], [Name], [OldId], [ParentId]) VALUES (269, N'Wheels/Rim, Door Locks and Hinges', 3543, 6)
GO
SET IDENTITY_INSERT [dbo].[lookup.SubCategories] OFF
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (1, 3)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (2, 4)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (3, 9)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (3, 818)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (4, 235)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (5, 17)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (6, 20)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (7, 27)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (7, 223)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (7, 227)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (7, 316)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (7, 665)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (8, 285)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (8, 360)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (8, 363)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (8, 369)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (9, 30)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (10, 31)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (11, 40)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (12, 41)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (13, 42)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 301)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 312)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 313)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 335)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 484)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 485)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 486)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 647)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 707)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 708)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (14, 709)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (15, 46)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 50)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 160)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 455)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 543)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 571)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 613)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (16, 686)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (17, 48)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (18, 51)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (18, 52)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (18, 548)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (18, 571)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (18, 695)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (19, 56)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 63)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 64)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 66)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 161)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 169)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 281)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 449)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 450)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 451)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 452)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 453)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 454)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 481)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 614)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (20, 720)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (21, 65)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (22, 68)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (23, 72)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (24, 78)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (25, 81)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (26, 93)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (26, 129)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (26, 716)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (26, 775)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (26, 806)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (27, 105)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (28, 106)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (29, 109)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (30, 114)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (31, 115)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (32, 116)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (33, 117)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (34, 118)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (35, 126)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (35, 127)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (35, 233)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 128)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 326)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 769)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 776)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 807)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (36, 809)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (37, 130)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (37, 345)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (38, 113)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (39, 432)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (39, 778)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (39, 779)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (40, 137)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (41, 138)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (42, 139)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (43, 140)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (44, 141)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (45, 47)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (46, 150)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (47, 157)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (48, 173)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (49, 174)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (50, 178)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (51, 177)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (52, 179)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 11)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 15)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 16)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 88)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 215)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 216)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 259)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 260)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 402)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (53, 645)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 90)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 151)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 186)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 230)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 291)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 380)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 448)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 582)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 641)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (54, 774)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 14)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 89)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 187)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 196)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 261)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 302)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 583)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 585)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 749)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 770)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (55, 804)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 1)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 57)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 131)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 188)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 314)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 317)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 372)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 417)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 420)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 490)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 513)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 517)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (56, 722)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (57, 29)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (57, 725)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (57, 732)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (58, 189)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (58, 408)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (58, 811)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (59, 204)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (60, 206)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (61, 207)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (62, 208)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (63, 209)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (63, 210)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (63, 211)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (64, 212)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (65, 219)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (66, 220)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (66, 299)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (66, 412)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (66, 611)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (66, 730)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (67, 222)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (67, 274)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (67, 414)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (68, 231)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (68, 334)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (68, 646)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (69, 221)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (69, 229)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (69, 275)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (69, 415)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (70, 410)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (70, 729)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (71, 82)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (71, 240)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (71, 242)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (71, 727)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (72, 237)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (73, 238)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (74, 239)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (75, 241)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (76, 243)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (77, 244)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (78, 245)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (79, 246)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (80, 247)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 162)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 163)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 164)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 248)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 364)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 367)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 369)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (81, 379)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (82, 249)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (83, 250)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (84, 251)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (84, 300)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (84, 413)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (84, 622)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (85, 253)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (86, 257)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (87, 258)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (88, 80)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (88, 262)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (89, 264)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 266)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 267)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 268)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 269)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 270)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 271)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 272)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (90, 480)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 161)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 265)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 276)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 277)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 278)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 280)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 286)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 287)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 438)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 439)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 481)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 614)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (91, 720)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 61)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 62)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 77)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 96)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 145)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 279)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 282)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 283)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 284)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 323)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 438)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 439)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 440)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 441)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 442)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 443)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (92, 475)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (93, 289)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (94, 304)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (94, 305)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (95, 307)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (96, 308)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 55)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 58)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 94)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 119)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 132)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 159)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 213)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 309)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 310)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 311)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 338)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 473)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 514)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 525)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (97, 721)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (98, 318)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (99, 319)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (100, 161)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (100, 481)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (100, 614)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (100, 720)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (101, 321)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (102, 329)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (103, 331)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (105, 336)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (106, 799)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (107, 340)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (108, 346)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (108, 347)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (109, 351)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (109, 355)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (109, 356)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 147)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 194)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 350)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 353)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 354)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 358)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 361)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 362)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 365)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 668)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 687)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (110, 764)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (111, 349)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (111, 357)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (111, 366)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (111, 669)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (112, 160)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (112, 172)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (112, 359)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (112, 733)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (112, 815)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 97)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 184)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 256)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 292)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 293)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 294)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 315)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 565)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 578)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 627)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 628)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 629)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 684)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (113, 772)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (114, 368)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (115, 489)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (115, 612)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (116, 161)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (116, 481)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (116, 614)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (116, 720)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (117, 370)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (118, 375)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (119, 376)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 121)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 298)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 498)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 501)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 594)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 634)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 636)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (120, 740)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (121, 98)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (122, 377)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (123, 385)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (124, 390)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (125, 393)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (126, 673)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (126, 756)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 158)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 167)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 343)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 392)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 573)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 574)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 576)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 601)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 676)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (127, 677)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (128, 394)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (129, 395)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (130, 103)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (130, 142)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (130, 324)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (130, 396)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (130, 781)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (131, 401)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (132, 404)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 322)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 381)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 610)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 679)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 783)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 784)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (133, 810)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 181)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 306)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 405)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 411)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 431)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 433)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (134, 434)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (135, 406)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (136, 407)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (137, 409)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 33)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 35)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 148)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 180)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 263)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 332)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 389)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 426)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 523)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 526)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 623)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 632)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 682)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 713)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 777)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 788)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (138, 820)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (139, 418)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (140, 425)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 43)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 59)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 60)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 185)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 197)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 198)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 199)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 387)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 388)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (141, 429)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (142, 436)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (143, 437)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (144, 444)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (145, 445)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (146, 446)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (147, 460)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (148, 447)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (149, 596)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (150, 457)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (150, 787)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (151, 458)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (151, 621)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (152, 459)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (153, 461)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (154, 462)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (155, 463)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (156, 464)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (157, 465)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (158, 149)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (158, 466)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (159, 467)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (161, 477)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (162, 478)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (163, 225)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (163, 320)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (163, 373)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (163, 483)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (163, 812)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (164, 503)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (165, 507)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (166, 506)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (167, 134)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (167, 508)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (167, 509)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (168, 511)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (169, 512)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (170, 518)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (171, 519)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (172, 520)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (173, 521)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (174, 522)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 32)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 160)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 165)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 455)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 476)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 529)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 530)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 531)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (175, 532)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (176, 533)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (177, 536)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (178, 252)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (179, 607)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (179, 718)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (179, 819)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (180, 537)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (181, 303)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (181, 739)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (181, 786)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (182, 538)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (184, 544)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (185, 545)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (186, 547)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (187, 76)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (187, 524)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (187, 767)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (187, 768)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (188, 226)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (188, 766)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (189, 550)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (190, 551)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (190, 552)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (191, 553)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (192, 551)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (193, 554)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (194, 555)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 13)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 67)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 74)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 152)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 214)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 341)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 342)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 391)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 567)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 581)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 666)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 670)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 700)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 714)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 726)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 728)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 750)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 803)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 805)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (195, 821)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (196, 556)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (197, 572)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (198, 579)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (199, 580)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (200, 587)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (201, 588)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 7)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 133)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 146)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 201)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 202)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 203)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 534)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 535)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 586)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 589)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (202, 717)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (203, 590)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 352)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 482)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 549)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 595)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 688)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 698)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (204, 773)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 25)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 170)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 171)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 193)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 295)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 371)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 591)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 702)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (205, 703)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (206, 598)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (207, 599)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (208, 602)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (209, 603)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (210, 5)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (210, 53)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (210, 155)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (210, 604)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (210, 605)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (211, 95)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (211, 290)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (211, 337)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (211, 378)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (211, 706)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 333)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 339)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 386)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 430)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 608)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (212, 609)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (213, 616)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (214, 630)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (214, 631)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (215, 649)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 104)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 136)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 192)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 515)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 650)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 652)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 697)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (216, 782)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (217, 653)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (218, 654)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (219, 659)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (220, 663)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (221, 663)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (222, 664)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 10)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 18)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 23)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 24)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 26)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 28)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 34)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 36)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 37)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 38)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 39)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 85)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 87)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 91)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 92)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 125)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 126)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 127)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 143)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 144)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 153)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 154)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 156)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 175)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 183)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 195)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 205)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 215)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 216)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 217)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 218)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 224)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 228)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 232)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 234)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 236)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 254)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 255)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 288)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 297)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 328)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 344)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 374)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 382)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 383)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 384)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 422)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 427)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 428)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 456)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 468)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 474)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 488)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 510)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 516)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 527)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 539)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 540)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 541)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 557)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 558)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 560)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 561)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 562)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 563)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 564)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 566)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 568)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 569)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 570)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 584)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 592)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 593)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 606)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 624)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 625)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 639)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 642)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 643)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 651)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 671)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 672)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 680)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 681)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 685)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 701)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 719)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 731)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 753)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 754)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 755)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 757)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 758)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 759)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 765)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 785)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 792)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 793)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 794)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (223, 808)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 10)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 18)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 23)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 24)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 26)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 28)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 34)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 36)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 37)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 38)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 39)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 85)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 87)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 91)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 92)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 125)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 126)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 127)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 143)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 144)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 153)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 154)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 156)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 175)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 183)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 195)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 205)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 215)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 216)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 217)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 218)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 224)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 228)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 232)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 234)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 236)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 254)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 255)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 288)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 297)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 328)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 344)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 374)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 382)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 383)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 384)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 422)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 427)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 428)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 456)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 468)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 474)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 488)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 510)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 516)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 527)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 539)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 540)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 541)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 557)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 558)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 560)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 561)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 562)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 563)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 564)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 566)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 568)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 569)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 570)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 584)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 592)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 593)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 606)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 624)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 625)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 639)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 642)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 643)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 651)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 671)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 672)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 680)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 681)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 685)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 701)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 719)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 731)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 753)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 754)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 755)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 757)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 758)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 759)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 765)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 785)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 792)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 793)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 794)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (224, 808)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 22)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 86)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 176)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 296)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 325)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 423)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 542)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 559)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 638)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (225, 644)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (226, 674)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (227, 675)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (228, 504)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (228, 505)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (229, 49)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (230, 683)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 6)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 8)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 54)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 615)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 689)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 690)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 691)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 692)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 693)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (231, 694)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (232, 699)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (233, 704)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (234, 705)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (235, 190)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (236, 715)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (237, 633)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (238, 734)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (239, 735)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (239, 736)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (239, 737)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (239, 738)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (240, 397)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (240, 398)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (240, 399)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (240, 400)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (240, 577)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (241, 741)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (241, 742)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (241, 743)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (241, 744)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (242, 745)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (242, 746)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (242, 747)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (242, 748)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (243, 122)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (243, 123)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (243, 124)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (244, 751)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (245, 752)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 75)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 135)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 575)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 678)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 758)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 759)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (246, 791)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (247, 760)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (248, 761)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (249, 762)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (250, 763)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (251, 771)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (252, 780)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (253, 789)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (254, 790)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (255, 492)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (256, 795)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (257, 796)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (258, 802)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (259, 797)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 19)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 45)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 69)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 107)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 108)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 120)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 168)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 182)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 487)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 600)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 696)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 710)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 711)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 712)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (260, 798)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (261, 99)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (261, 100)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (261, 101)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (261, 102)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (261, 724)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 110)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 111)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 112)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 327)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 479)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 491)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 617)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 618)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 619)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 620)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 626)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (262, 800)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (263, 21)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (263, 801)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (264, 493)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (264, 494)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (264, 495)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (264, 496)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (264, 497)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 469)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 470)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 471)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 499)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 500)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 502)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 635)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 637)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 655)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 656)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 657)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 658)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 660)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 661)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 662)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (265, 723)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (266, 813)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (267, 814)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (268, 816)
GO
INSERT [dbo].[lookup.SubCategoryProductTypes] ([SubCategoryId], [ProductTypeId]) VALUES (269, 817)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 4)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 14)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 26)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 27)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 54)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 55)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 63)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 66)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 69)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 81)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 97)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 103)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 120)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 121)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 160)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 167)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 183)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 195)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 210)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 216)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 246)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 256)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 260)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 261)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 262)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 263)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 264)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (2, 265)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (6, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (6, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 14)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 16)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 18)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 20)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 22)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 25)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 27)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 31)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 33)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 38)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 50)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 63)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 82)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 84)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 86)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 90)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 91)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 92)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 94)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 95)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 98)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 99)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 100)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 107)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 110)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 111)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 112)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 124)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 169)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 176)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 177)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 180)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 200)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 202)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 205)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 208)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 220)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 221)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 231)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 232)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 233)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 238)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 239)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 240)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 243)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 247)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 249)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 250)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 251)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 260)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 261)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 262)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 263)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 264)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 265)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 266)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (7, 268)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 1)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 2)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 3)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 4)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 6)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 7)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 14)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 16)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 18)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 20)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 21)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 22)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 25)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 26)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 27)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 28)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 29)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 31)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 33)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 35)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 36)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 38)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 39)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 41)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 42)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 43)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 44)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 48)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 50)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 53)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 54)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 55)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 56)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 57)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 58)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 63)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 65)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 66)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 67)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 68)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 69)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 70)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 71)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 81)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 82)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 84)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 86)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 88)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 90)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 91)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 92)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 94)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 95)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 97)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 100)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 103)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 105)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 107)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 109)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 110)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 111)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 112)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 116)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 124)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 125)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 126)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 127)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 129)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 130)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 133)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 134)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 137)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 141)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 142)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 144)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 145)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 146)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 155)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 158)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 161)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 162)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 167)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 170)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 172)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 175)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 178)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 179)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 181)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 185)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 187)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 189)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 191)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 193)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 195)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 197)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 198)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 200)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 202)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 204)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 205)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 208)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 210)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 212)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 216)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 219)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 220)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 221)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 226)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 231)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 233)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 234)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 237)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 239)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 240)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 243)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 245)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 246)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 247)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 249)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 250)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 251)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 255)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 256)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 260)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 261)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 262)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 263)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 264)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 265)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 266)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 267)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (8, 268)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (9, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (9, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (10, 139)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (10, 168)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 1)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 3)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 7)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 14)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 16)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 18)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 20)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 22)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 25)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 27)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 29)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 31)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 33)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 35)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 36)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 38)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 39)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 41)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 42)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 43)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 44)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 48)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 50)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 53)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 56)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 57)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 58)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 63)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 65)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 67)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 68)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 70)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 71)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 82)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 84)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 86)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 88)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 90)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 91)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 92)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 95)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 100)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 105)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 107)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 109)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 110)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 111)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 112)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 116)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 125)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 126)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 127)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 129)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 130)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 133)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 134)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 137)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 141)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 142)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 144)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 145)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 146)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 155)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 158)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 161)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 162)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 170)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 172)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 175)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 178)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 179)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 181)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 185)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 187)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 189)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 191)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 193)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 197)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 200)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 202)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 204)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 205)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 208)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 212)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 220)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 221)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 231)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 233)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 234)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 237)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 239)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 240)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 243)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 247)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 249)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 250)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 251)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 256)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 260)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 262)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 263)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 264)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 265)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 266)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 267)
GO
INSERT [dbo].[lookup.SubCategoryThirdParties] ([ThirdPartyId], [SubCategoryId]) VALUES (11, 268)
GO
SET IDENTITY_INSERT [dbo].[lookup.ThirdParties] ON 
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (1, N'DCL', 5181)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (2, N'Gulftic Certification LLC', 2143)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (3, N'Gulftic Gmark', 5237)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (4, N'Gulftic Medical PPE', 6550)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (5, N'Gulftic Vehicle Workshop', 5241)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (6, N'PRIME CERTIFICATION', 3403)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (7, N'RACS', 2064)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (8, N'SGS', 2063)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (9, N'TUV RHEINLAND', 3402)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (10, N'TUV SUD', 3401)
GO
INSERT [dbo].[lookup.ThirdParties] ([Id], [Name], [OldId]) VALUES (11, N'Underwriters Laboratories Middle East', 2144)
GO
SET IDENTITY_INSERT [dbo].[lookup.ThirdParties] OFF
GO
SET IDENTITY_INSERT [dbo].[service.ActionTypes] ON 
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (1, N'Submit')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (2, N'Pay')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (3, N'Save')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (4, N'Approve')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (5, N'Reject')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (6, N'Return')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (7, N'Modify')
GO
INSERT [dbo].[service.ActionTypes] ([Id], [Name]) VALUES (8, N'Assign')
GO
SET IDENTITY_INSERT [dbo].[service.ActionTypes] OFF
GO
INSERT [dbo].[service.AttachmentConstraintTypes] ([Id], [Name]) VALUES (1, N'Required')
GO
INSERT [dbo].[service.AttachmentTypes] ([Id], [Name]) VALUES (1, N'Document')
GO
INSERT [dbo].[service.AttachmentTypes] ([Id], [Name]) VALUES (2, N'Passport')
GO
INSERT [dbo].[service.AttachmentTypes] ([Id], [Name]) VALUES (3, N'Instruction Manual')
GO
SET IDENTITY_INSERT [dbo].[service.Entities] ON 
GO
INSERT [dbo].[service.Entities] ([Id], [Name]) VALUES (1, N'ECAS Application')
GO
INSERT [dbo].[service.Entities] ([Id], [Name]) VALUES (2, N'ECAS Product')
GO
INSERT [dbo].[service.Entities] ([Id], [Name]) VALUES (3, N'ECAS Product Detail')
GO
INSERT [dbo].[service.Entities] ([Id], [Name]) VALUES (4, N'ECAS Product Report')
GO
INSERT [dbo].[service.Entities] ([Id], [Name]) VALUES (5, N'ECAS Manufacturer')
GO
SET IDENTITY_INSERT [dbo].[service.Entities] OFF
GO
SET IDENTITY_INSERT [dbo].[service.EntityFields] ON 
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (1, N'Organization Name', 6, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (2, N'Section', 5, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (3, N'Product Category', 5, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (4, N'Product Sub Category', 5, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (5, N'Handled By (Notified By)', 5, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (6, N'Product Type', 5, 1, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (7, N'Relation', 7, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (8, N'Brand', 1, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (9, N'Model Number', 1, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (10, N'Dimension', 1, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (11, N'Description', 1, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (12, N'Barcode', 1, 3, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (13, N'Report Number', 1, 4, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (15, N'Report Expiry Date', 3, 4, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (16, N'Test Report Url', 1, 4, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (17, N'Product Type', 5, 2, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (18, N'Manufacturer English Name', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (19, N'Manufacturer Arabic Name', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (20, N'Is Head Quarter', 8, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (21, N'Origin Country', 5, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (22, N'State/City', 5, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (23, N'Address ', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (24, N'Phone Number', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (25, N'Fax', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (26, N'Email', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (27, N'Website', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (28, N'PoBox', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (29, N'Does Facility in UAE?', 8, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (30, N'Facility English Name', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (31, N'Facility Arabic Name', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (32, N'Facility Emirate', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (33, N'Facility Address', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (34, N'Facility Phone Number', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (35, N'Contact Name', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (36, N'Contact Number', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (37, N'Contact Email', 1, 5, NULL)
GO
INSERT [dbo].[service.EntityFields] ([Id], [Name], [FieldTypeId], [EntityId], [Settings]) VALUES (38, N'Undertake No Facility Document Url', 1, 5, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.EntityFields] OFF
GO
INSERT [dbo].[service.EntityRelationships] ([FromEntityId], [ToEntityId], [EntityRelationshipTypeId], [EntityFieldId]) VALUES (1, 2, 2, 7)
GO
INSERT [dbo].[service.EntityRelationships] ([FromEntityId], [ToEntityId], [EntityRelationshipTypeId], [EntityFieldId]) VALUES (1, 5, 2, 7)
GO
INSERT [dbo].[service.EntityRelationships] ([FromEntityId], [ToEntityId], [EntityRelationshipTypeId], [EntityFieldId]) VALUES (2, 3, 2, 7)
GO
INSERT [dbo].[service.EntityRelationships] ([FromEntityId], [ToEntityId], [EntityRelationshipTypeId], [EntityFieldId]) VALUES (2, 4, 2, 7)
GO
INSERT [dbo].[service.EntityRelationTypes] ([Id], [Name]) VALUES (1, N'One to One')
GO
INSERT [dbo].[service.EntityRelationTypes] ([Id], [Name]) VALUES (2, N'One to Many')
GO
INSERT [dbo].[service.FieldConstraintTypes] ([Id], [Name]) VALUES (1, N'Required')
GO
INSERT [dbo].[service.FieldConstraintTypes] ([Id], [Name]) VALUES (2, N'Hide For Values')
GO
INSERT [dbo].[service.FieldConstraintTypes] ([Id], [Name]) VALUES (3, N'Cascading Load')
GO
INSERT [dbo].[service.FieldTypeConstraintType] ([FieldConstraintTypeId], [FieldTypeId]) VALUES (1, 5)
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (1, N'Text')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (2, N'Integer')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (3, N'DateTime')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (4, N'Number')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (5, N'Options')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (6, N'Reference')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (7, N'Relation')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (8, N'Boolean')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (9, N'PickRecord')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (10, N'Fees')
GO
INSERT [dbo].[service.FieldTypes] ([Id], [Name]) VALUES (11, N'TermsCondition')
GO
SET IDENTITY_INSERT [dbo].[service.FormFieldConstraints] ON 
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (4, 7, 1, NULL)
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (5, 8, 1, NULL)
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (6, 9, 1, NULL)
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (7, 10, 1, NULL)
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (8, 10, 2, N'<Settings><FieldId>7</FieldId><Values>6,7</Values></Settings>')
GO
INSERT [dbo].[service.FormFieldConstraints] ([Id], [FormSectionFieldId], [FieldConstraintTypeId], [Settings]) VALUES (9, 8, 3, N'<Settings><FieldId>7</FieldId></Settings>')
GO
SET IDENTITY_INSERT [dbo].[service.FormFieldConstraints] OFF
GO
SET IDENTITY_INSERT [dbo].[service.Forms] ON 
GO
INSERT [dbo].[service.Forms] ([Id], [Name], [Settings]) VALUES (1, N'Application Details', NULL)
GO
INSERT [dbo].[service.Forms] ([Id], [Name], [Settings]) VALUES (2, N'Product Details', NULL)
GO
INSERT [dbo].[service.Forms] ([Id], [Name], [Settings]) VALUES (3, N'Manufacturer Details', NULL)
GO
INSERT [dbo].[service.Forms] ([Id], [Name], [Settings]) VALUES (4, N'Attachments', NULL)
GO
INSERT [dbo].[service.Forms] ([Id], [Name], [Settings]) VALUES (5, N'Declarations', NULL)
GO
SET IDENTITY_INSERT [dbo].[service.Forms] OFF
GO
SET IDENTITY_INSERT [dbo].[service.FormSectionAttachments] ON 
GO
INSERT [dbo].[service.FormSectionAttachments] ([Id], [FormSectionId], [OrderNumber], [AttachmentId]) VALUES (1, 9, 1, NULL)
GO
INSERT [dbo].[service.FormSectionAttachments] ([Id], [FormSectionId], [OrderNumber], [AttachmentId]) VALUES (2, 9, 2, NULL)
GO
INSERT [dbo].[service.FormSectionAttachments] ([Id], [FormSectionId], [OrderNumber], [AttachmentId]) VALUES (3, 9, 3, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.FormSectionAttachments] OFF
GO
SET IDENTITY_INSERT [dbo].[service.FormSectionFields] ON 
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (6, 1, 1, 1, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (7, 2, 1, 2, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (8, 2, 2, 3, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (9, 2, 3, 4, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (10, 2, 4, 5, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (11, 3, 1, 6, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (12, 4, 1, 8, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (13, 4, 2, 9, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (14, 4, 3, 10, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (15, 4, 4, 11, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (16, 4, 5, 12, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (17, 5, 1, 13, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (19, 5, 2, 15, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (20, 5, 3, 16, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (21, 6, 1, 18, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (22, 6, 2, 19, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (23, 6, 3, 20, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (24, 6, 4, 21, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (25, 6, 5, 22, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (26, 6, 6, 23, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (27, 6, 7, 24, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (28, 6, 8, 25, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (29, 6, 9, 26, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (30, 6, 10, 27, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (31, 6, 11, 28, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (32, 7, 1, 38, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (33, 7, 2, 29, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (35, 7, 3, 30, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (36, 7, 4, 31, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (37, 7, 5, 32, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (38, 7, 6, 33, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (39, 7, 7, 34, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (40, 8, 1, 35, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (41, 8, 2, 36, NULL)
GO
INSERT [dbo].[service.FormSectionFields] ([Id], [FormSectionId], [OrderNumber], [EntityFieldId], [FormSectionParentId]) VALUES (43, 8, 3, 37, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.FormSectionFields] OFF
GO
SET IDENTITY_INSERT [dbo].[service.FormSections] ON 
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (1, N'Application Details', 1, 1, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (2, N'Product Category Details', 1, 2, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (3, N'Product Type', 2, 1, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (4, N'Product Details', 2, 2, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (5, N'Product Reports', 2, 3, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (6, N'Manufacturer Details', 3, 1, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (7, N'Facility Details in UAE', 3, 2, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (8, N'Contact Details', 3, 3, NULL)
GO
INSERT [dbo].[service.FormSections] ([Id], [Name], [FormId], [OrderNumber], [Settings]) VALUES (9, N'Attachments', 4, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.FormSections] OFF
GO
SET IDENTITY_INSERT [dbo].[service.Groups] ON 
GO
INSERT [dbo].[service.Groups] ([Id], [Name], [ParentId], [OrderNumber], [Description]) VALUES (1, N'ESMA', NULL, 1, NULL)
GO
INSERT [dbo].[service.Groups] ([Id], [Name], [ParentId], [OrderNumber], [Description]) VALUES (2, N'Drone', 1, 1, NULL)
GO
INSERT [dbo].[service.Groups] ([Id], [Name], [ParentId], [OrderNumber], [Description]) VALUES (3, N'ENAS', NULL, 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.Groups] OFF
GO
INSERT [dbo].[service.Languages] ([Id], [Name], [Direction]) VALUES (1, N'English', N'ltr')
GO
INSERT [dbo].[service.Languages] ([Id], [Name], [Direction]) VALUES (2, N'Arabic', N'rtl')
GO
SET IDENTITY_INSERT [dbo].[service.Roles] ON 
GO
INSERT [dbo].[service.Roles] ([Id], [Name]) VALUES (1, N'Owner')
GO
INSERT [dbo].[service.Roles] ([Id], [Name]) VALUES (2, N'Review Engineer')
GO
INSERT [dbo].[service.Roles] ([Id], [Name]) VALUES (3, N'Evaluation Egineer')
GO
INSERT [dbo].[service.Roles] ([Id], [Name]) VALUES (4, N'Head of Section')
GO
INSERT [dbo].[service.Roles] ([Id], [Name]) VALUES (5, N'Head of Department')
GO
SET IDENTITY_INSERT [dbo].[service.Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[service.Services] ON 
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (1, N'ECAS', 1, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (2, N'Emirates Quality Mark', 1, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (3, N'Halal National Mark', 1, 3, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (4, N'Efficiency Labels Issuance', 1, 4, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (5, N'Green Labels Issuance', 1, 5, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (6, N'GSO Vehicle Certification', 1, 6, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (7, N'G Mark', 1, 7, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (8, N'GSO Tire Certification', 1, 8, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (9, N'Shipment Clearance', 1, 9, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (10, N'Drone LOC', 2, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (11, N'Drone Label', 2, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (12, N'Drone Transfer', 2, 3, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (13, N'Apply for GCAA Authorization', 2, 4, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (14, N'Vehicle Workshop Certificate', 1, 10, NULL, NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (15, N'Drone LO5', 1, 8, N'Description 6', NULL, NULL)
GO
INSERT [dbo].[service.Services] ([Id], [Name], [GroupId], [OrderNumber], [Description], [Settings], [StartStageID]) VALUES (16, N'Drone LO5', 1, 8, N'Description 6', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.Services] OFF
GO
INSERT [dbo].[service.StageActionRoles] ([StageActionId], [RoleId]) VALUES (14, 1)
GO
SET IDENTITY_INSERT [dbo].[service.StageActions] ON 
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (14, N'Save as Draft', 3, 1, 1, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (15, N'Pay', 2, 3, 2, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (16, N'Give Recommendation for Evaluation Review', 2, 4, 3, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (17, N'Send Back to Applicant', 6, 4, 3, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (19, N'Give Recommendation for Certificaiton Review', 8, 5, 4, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (21, N'Send Back to Third Party Engineer', 6, 5, 4, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (23, N'Give Recommendation for Final Decision', 8, 6, 5, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (25, N'Send Back to Confirmity Engineer', 6, 6, 5, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (26, N'Approve', 4, 7, 6, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (27, N'Reject', 5, 7, 6, NULL)
GO
INSERT [dbo].[service.StageActions] ([Id], [Name], [ActionTypeId], [OrderNumber], [StageId], [ToStageID]) VALUES (29, N'Submit', 1, 2, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[service.StageActions] OFF
GO
INSERT [dbo].[service.StageForms] ([StageId], [FormId], [OrderNumber]) VALUES (1, 1, 1)
GO
INSERT [dbo].[service.StageForms] ([StageId], [FormId], [OrderNumber]) VALUES (1, 2, 2)
GO
INSERT [dbo].[service.StageForms] ([StageId], [FormId], [OrderNumber]) VALUES (1, 3, 3)
GO
INSERT [dbo].[service.StageForms] ([StageId], [FormId], [OrderNumber]) VALUES (1, 4, 4)
GO
INSERT [dbo].[service.StageForms] ([StageId], [FormId], [OrderNumber]) VALUES (1, 5, 5)
GO
SET IDENTITY_INSERT [dbo].[service.Stages] ON 
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (1, N'Application Submission', 1, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (2, N'Fee Payment', 2, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (3, N'Document Review', 3, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (4, N'Evaluation Review', 4, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (5, N'Certification Review', 5, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (6, N'Final Decision', 6, 1, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (7, N'Application Submission', 1, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (9, N'Fee Payment', 2, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (10, N'Document Review', 3, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (11, N'On Site Assessment Preparation', 4, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (12, N'On Site Assessment', 5, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (13, N'Evaluation Review', 6, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (14, N'Certification Review', 7, 2, 1)
GO
INSERT [dbo].[service.Stages] ([Id], [Name], [OrderNumber], [ServiceId], [StageTypeId]) VALUES (15, N'Final Decision', 8, 2, 1)
GO
SET IDENTITY_INSERT [dbo].[service.Stages] OFF
GO
INSERT [dbo].[service.StageTypes] ([Id], [StageTypeName]) VALUES (1, N'Create Application')
GO
SET IDENTITY_INSERT [dbo].[service.TextResourcesCategories] ON 
GO
INSERT [dbo].[service.TextResourcesCategories] ([Id], [TextResourceCategoryName]) VALUES (1, N'Menu')
GO
INSERT [dbo].[service.TextResourcesCategories] ([Id], [TextResourceCategoryName]) VALUES (2, N'Button')
GO
INSERT [dbo].[service.TextResourcesCategories] ([Id], [TextResourceCategoryName]) VALUES (3, N'PageTitle')
GO
SET IDENTITY_INSERT [dbo].[service.TextResourcesCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[service.TextResourcesKeys] ON 
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (1, N'Services', 1)
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (2, N'MyApplications', 1)
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (3, N'CreateApplication', 2)
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (4, N'Search', 2)
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (5, N'ServicesHeader', 3)
GO
INSERT [dbo].[service.TextResourcesKeys] ([Id], [TextResourcesKeyName], [TextResourceCategoryId]) VALUES (6, N'ViewApplication', 2)
GO
SET IDENTITY_INSERT [dbo].[service.TextResourcesKeys] OFF
GO
SET IDENTITY_INSERT [dbo].[service.TextResourceValues] ON 
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (1, 1, 1, N'Services')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (2, 2, 1, N'My Applications')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (3, 3, 1, N'Create Application')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (4, 4, 1, N'Search')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (5, 5, 1, N'Services & Groups')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (6, 6, 1, N'View Applications')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (7, 1, 2, N'الخدمات')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (8, 2, 2, N'طلباتي')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (9, 3, 2, N'طلب جديد')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (10, 4, 2, N'بحث')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (11, 5, 2, N'الخدمات')
GO
INSERT [dbo].[service.TextResourceValues] ([Id], [TextResourcesKeyId], [LanguageId], [Value]) VALUES (12, 6, 2, N' عرض الطلبات')
GO
SET IDENTITY_INSERT [dbo].[service.TextResourceValues] OFF
GO
SET IDENTITY_INSERT [dbo].[service.Users] ON 
GO
INSERT [dbo].[service.Users] ([Id], [ExternalId]) VALUES (1, N'1')
GO
SET IDENTITY_INSERT [dbo].[service.Users] OFF
GO
ALTER TABLE [dbo].[service.FormSectionFields] ADD  CONSTRAINT [DF_FormFields_OrderNumber]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.FormSections] ADD  CONSTRAINT [DF_FormSections_OrderNumber]  DEFAULT ((1)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.Groups] ADD  CONSTRAINT [DF_Groups_SortOrder]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.Services] ADD  CONSTRAINT [DF_Services_SortOrder]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.StageActions] ADD  CONSTRAINT [DF_Table_1_OrderBy]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.Stages] ADD  CONSTRAINT [DF_Stages_SortOrder]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[service.Stages] ADD  CONSTRAINT [DF_service.Stages_StageTypeId]  DEFAULT ((1)) FOR [StageTypeId]
GO
ALTER TABLE [dbo].[application.ActionAssignedUsers]  WITH CHECK ADD  CONSTRAINT [FK_ActionAssignedUsers_ApplicationStageActions] FOREIGN KEY([ApplicationStageActionId])
REFERENCES [dbo].[application.ApplicationStageActions] ([Id])
GO
ALTER TABLE [dbo].[application.ActionAssignedUsers] CHECK CONSTRAINT [FK_ActionAssignedUsers_ApplicationStageActions]
GO
ALTER TABLE [dbo].[application.ActionAssignedUsers]  WITH CHECK ADD  CONSTRAINT [FK_ActionAssignedUsers_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[service.Users] ([Id])
GO
ALTER TABLE [dbo].[application.ActionAssignedUsers] CHECK CONSTRAINT [FK_ActionAssignedUsers_Users]
GO
ALTER TABLE [dbo].[application.Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_Applications] FOREIGN KEY([ParentApplicationId])
REFERENCES [dbo].[application.Applications] ([Id])
GO
ALTER TABLE [dbo].[application.Applications] CHECK CONSTRAINT [FK_Applications_Applications]
GO
ALTER TABLE [dbo].[application.Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_DeviceTypes] FOREIGN KEY([DeviceTypeId])
REFERENCES [dbo].[application.DeviceTypes] ([Id])
GO
ALTER TABLE [dbo].[application.Applications] CHECK CONSTRAINT [FK_Applications_DeviceTypes]
GO
ALTER TABLE [dbo].[application.Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_Services] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[service.Services] ([Id])
GO
ALTER TABLE [dbo].[application.Applications] CHECK CONSTRAINT [FK_Applications_Services]
GO
ALTER TABLE [dbo].[application.Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_Users] FOREIGN KEY([CreatorId])
REFERENCES [dbo].[service.Users] ([Id])
GO
ALTER TABLE [dbo].[application.Applications] CHECK CONSTRAINT [FK_Applications_Users]
GO
ALTER TABLE [dbo].[application.ApplicationStageActions]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStageActions_ApplicationStages] FOREIGN KEY([ApplicationStageId])
REFERENCES [dbo].[application.ApplicationStages] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStageActions] CHECK CONSTRAINT [FK_ApplicationStageActions_ApplicationStages]
GO
ALTER TABLE [dbo].[application.ApplicationStageActions]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStageActions_StageActions] FOREIGN KEY([StageActionId])
REFERENCES [dbo].[service.StageActions] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStageActions] CHECK CONSTRAINT [FK_ApplicationStageActions_StageActions]
GO
ALTER TABLE [dbo].[application.ApplicationStageActions]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStageActions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[service.Users] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStageActions] CHECK CONSTRAINT [FK_ApplicationStageActions_Users]
GO
ALTER TABLE [dbo].[application.ApplicationStages]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStages_Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[application.Applications] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStages] CHECK CONSTRAINT [FK_ApplicationStages_Applications]
GO
ALTER TABLE [dbo].[application.ApplicationStages]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStages_ApplicationStages] FOREIGN KEY([PreviousStageId])
REFERENCES [dbo].[application.ApplicationStages] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStages] CHECK CONSTRAINT [FK_ApplicationStages_ApplicationStages]
GO
ALTER TABLE [dbo].[application.ApplicationStages]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStages_StageStatuses] FOREIGN KEY([StageStatusId])
REFERENCES [dbo].[application.StageStatuses] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStages] CHECK CONSTRAINT [FK_ApplicationStages_StageStatuses]
GO
ALTER TABLE [dbo].[application.ApplicationStages]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationStages_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[service.Users] ([Id])
GO
ALTER TABLE [dbo].[application.ApplicationStages] CHECK CONSTRAINT [FK_ApplicationStages_Users]
GO
ALTER TABLE [dbo].[lookup.Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Sections] FOREIGN KEY([SectionId])
REFERENCES [dbo].[lookup.Sections] ([Id])
GO
ALTER TABLE [dbo].[lookup.Categories] CHECK CONSTRAINT [FK_Categories_Sections]
GO
ALTER TABLE [dbo].[lookup.CategoryNotifyBodies]  WITH CHECK ADD  CONSTRAINT [FK_CategoryNotifyBodies_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[lookup.Categories] ([Id])
GO
ALTER TABLE [dbo].[lookup.CategoryNotifyBodies] CHECK CONSTRAINT [FK_CategoryNotifyBodies_Categories]
GO
ALTER TABLE [dbo].[lookup.CategoryNotifyBodies]  WITH CHECK ADD  CONSTRAINT [FK_CategoryNotifyBodies_NotifyBodies] FOREIGN KEY([NotifyBodyId])
REFERENCES [dbo].[lookup.NotifyBodies] ([Id])
GO
ALTER TABLE [dbo].[lookup.CategoryNotifyBodies] CHECK CONSTRAINT [FK_CategoryNotifyBodies_NotifyBodies]
GO
ALTER TABLE [dbo].[lookup.Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[lookup.Countries] ([Id])
GO
ALTER TABLE [dbo].[lookup.Cities] CHECK CONSTRAINT [FK_Cities_Countries]
GO
ALTER TABLE [dbo].[lookup.SubCategories]  WITH CHECK ADD  CONSTRAINT [FK_SubCategories_Categories] FOREIGN KEY([ParentId])
REFERENCES [dbo].[lookup.Categories] ([Id])
GO
ALTER TABLE [dbo].[lookup.SubCategories] CHECK CONSTRAINT [FK_SubCategories_Categories]
GO
ALTER TABLE [dbo].[lookup.SubCategoryProductTypes]  WITH CHECK ADD  CONSTRAINT [FK_SubCategoryProductTypes_ProductTypes] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[lookup.ProductTypes] ([Id])
GO
ALTER TABLE [dbo].[lookup.SubCategoryProductTypes] CHECK CONSTRAINT [FK_SubCategoryProductTypes_ProductTypes]
GO
ALTER TABLE [dbo].[lookup.SubCategoryProductTypes]  WITH CHECK ADD  CONSTRAINT [FK_SubCategoryProductTypes_SubCategories] FOREIGN KEY([SubCategoryId])
REFERENCES [dbo].[lookup.SubCategories] ([Id])
GO
ALTER TABLE [dbo].[lookup.SubCategoryProductTypes] CHECK CONSTRAINT [FK_SubCategoryProductTypes_SubCategories]
GO
ALTER TABLE [dbo].[lookup.SubCategoryThirdParties]  WITH CHECK ADD  CONSTRAINT [FK_SubCategoryThirdParties_SubCategories] FOREIGN KEY([SubCategoryId])
REFERENCES [dbo].[lookup.SubCategories] ([Id])
GO
ALTER TABLE [dbo].[lookup.SubCategoryThirdParties] CHECK CONSTRAINT [FK_SubCategoryThirdParties_SubCategories]
GO
ALTER TABLE [dbo].[lookup.SubCategoryThirdParties]  WITH CHECK ADD  CONSTRAINT [FK_SubCategoryThirdParties_ThirdParties] FOREIGN KEY([ThirdPartyId])
REFERENCES [dbo].[lookup.ThirdParties] ([Id])
GO
ALTER TABLE [dbo].[lookup.SubCategoryThirdParties] CHECK CONSTRAINT [FK_SubCategoryThirdParties_ThirdParties]
GO
ALTER TABLE [dbo].[service.ActionForms]  WITH CHECK ADD  CONSTRAINT [FK_ActionForms_ActionTypes] FOREIGN KEY([ActionId])
REFERENCES [dbo].[service.ActionTypes] ([Id])
GO
ALTER TABLE [dbo].[service.ActionForms] CHECK CONSTRAINT [FK_ActionForms_ActionTypes]
GO
ALTER TABLE [dbo].[service.ActionForms]  WITH CHECK ADD  CONSTRAINT [FK_ActionForms_Forms] FOREIGN KEY([FormId])
REFERENCES [dbo].[service.Forms] ([Id])
GO
ALTER TABLE [dbo].[service.ActionForms] CHECK CONSTRAINT [FK_ActionForms_Forms]
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_service.ApplicationFieldValues_application.Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[application.Applications] ([Id])
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues] CHECK CONSTRAINT [FK_service.ApplicationFieldValues_application.Applications]
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_service.ApplicationFieldValues_service.ApplicationFieldValues] FOREIGN KEY([ParentId])
REFERENCES [dbo].[service.ApplicationFieldValues] ([Id])
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues] CHECK CONSTRAINT [FK_service.ApplicationFieldValues_service.ApplicationFieldValues]
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_service.ApplicationFieldValues_service.EntityFields] FOREIGN KEY([EntityFieldId])
REFERENCES [dbo].[service.EntityFields] ([Id])
GO
ALTER TABLE [dbo].[service.ApplicationFieldValues] CHECK CONSTRAINT [FK_service.ApplicationFieldValues_service.EntityFields]
GO
ALTER TABLE [dbo].[service.AttachmentConstraints]  WITH CHECK ADD  CONSTRAINT [FK_AttachmentConstraints_AttachmentConstraintTypes] FOREIGN KEY([AttachmentConstraintTypeId])
REFERENCES [dbo].[service.AttachmentConstraintTypes] ([Id])
GO
ALTER TABLE [dbo].[service.AttachmentConstraints] CHECK CONSTRAINT [FK_AttachmentConstraints_AttachmentConstraintTypes]
GO
ALTER TABLE [dbo].[service.AttachmentConstraints]  WITH CHECK ADD  CONSTRAINT [FK_AttachmentConstraints_Attachments] FOREIGN KEY([FormSectionAttachmentId])
REFERENCES [dbo].[service.FormSectionAttachments] ([Id])
GO
ALTER TABLE [dbo].[service.AttachmentConstraints] CHECK CONSTRAINT [FK_AttachmentConstraints_Attachments]
GO
ALTER TABLE [dbo].[service.EntityFields]  WITH CHECK ADD  CONSTRAINT [FK_EntityFields_Entities] FOREIGN KEY([EntityId])
REFERENCES [dbo].[service.Entities] ([Id])
GO
ALTER TABLE [dbo].[service.EntityFields] CHECK CONSTRAINT [FK_EntityFields_Entities]
GO
ALTER TABLE [dbo].[service.EntityFields]  WITH CHECK ADD  CONSTRAINT [FK_EntityFields_FieldTypes] FOREIGN KEY([FieldTypeId])
REFERENCES [dbo].[service.FieldTypes] ([Id])
GO
ALTER TABLE [dbo].[service.EntityFields] CHECK CONSTRAINT [FK_EntityFields_FieldTypes]
GO
ALTER TABLE [dbo].[service.EntityRelationships]  WITH CHECK ADD  CONSTRAINT [FK_EntityRelationship_Entities] FOREIGN KEY([FromEntityId])
REFERENCES [dbo].[service.Entities] ([Id])
GO
ALTER TABLE [dbo].[service.EntityRelationships] CHECK CONSTRAINT [FK_EntityRelationship_Entities]
GO
ALTER TABLE [dbo].[service.EntityRelationships]  WITH CHECK ADD  CONSTRAINT [FK_EntityRelationship_Entities1] FOREIGN KEY([ToEntityId])
REFERENCES [dbo].[service.Entities] ([Id])
GO
ALTER TABLE [dbo].[service.EntityRelationships] CHECK CONSTRAINT [FK_EntityRelationship_Entities1]
GO
ALTER TABLE [dbo].[service.EntityRelationships]  WITH CHECK ADD  CONSTRAINT [FK_EntityRelationship_EntityFields] FOREIGN KEY([EntityFieldId])
REFERENCES [dbo].[service.EntityFields] ([Id])
GO
ALTER TABLE [dbo].[service.EntityRelationships] CHECK CONSTRAINT [FK_EntityRelationship_EntityFields]
GO
ALTER TABLE [dbo].[service.EntityRelationships]  WITH CHECK ADD  CONSTRAINT [FK_EntityRelationships_EntityRelationTypes] FOREIGN KEY([EntityRelationshipTypeId])
REFERENCES [dbo].[service.EntityRelationTypes] ([Id])
GO
ALTER TABLE [dbo].[service.EntityRelationships] CHECK CONSTRAINT [FK_EntityRelationships_EntityRelationTypes]
GO
ALTER TABLE [dbo].[service.FieldTypeConstraintType]  WITH CHECK ADD  CONSTRAINT [FK_FieldTypeConstraintType_FieldConstraintTypes] FOREIGN KEY([FieldConstraintTypeId])
REFERENCES [dbo].[service.FieldConstraintTypes] ([Id])
GO
ALTER TABLE [dbo].[service.FieldTypeConstraintType] CHECK CONSTRAINT [FK_FieldTypeConstraintType_FieldConstraintTypes]
GO
ALTER TABLE [dbo].[service.FieldTypeConstraintType]  WITH CHECK ADD  CONSTRAINT [FK_FieldTypeConstraintType_FieldTypes] FOREIGN KEY([FieldTypeId])
REFERENCES [dbo].[service.FieldTypes] ([Id])
GO
ALTER TABLE [dbo].[service.FieldTypeConstraintType] CHECK CONSTRAINT [FK_FieldTypeConstraintType_FieldTypes]
GO
ALTER TABLE [dbo].[service.FormFieldConstraints]  WITH CHECK ADD  CONSTRAINT [FK_FormFieldConstraints_FieldConstraintTypes] FOREIGN KEY([FieldConstraintTypeId])
REFERENCES [dbo].[service.FieldConstraintTypes] ([Id])
GO
ALTER TABLE [dbo].[service.FormFieldConstraints] CHECK CONSTRAINT [FK_FormFieldConstraints_FieldConstraintTypes]
GO
ALTER TABLE [dbo].[service.FormFieldConstraints]  WITH CHECK ADD  CONSTRAINT [FK_FormFieldConstraints_FormFields] FOREIGN KEY([FormSectionFieldId])
REFERENCES [dbo].[service.FormSectionFields] ([Id])
GO
ALTER TABLE [dbo].[service.FormFieldConstraints] CHECK CONSTRAINT [FK_FormFieldConstraints_FormFields]
GO
ALTER TABLE [dbo].[service.FormSectionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_Attachments_Forms] FOREIGN KEY([FormSectionId])
REFERENCES [dbo].[service.FormSections] ([Id])
GO
ALTER TABLE [dbo].[service.FormSectionAttachments] CHECK CONSTRAINT [FK_Attachments_Forms]
GO
ALTER TABLE [dbo].[service.FormSectionAttachments]  WITH CHECK ADD  CONSTRAINT [FK_FormSectionAttachments_Attachments] FOREIGN KEY([AttachmentId])
REFERENCES [dbo].[service.Attachments] ([Id])
GO
ALTER TABLE [dbo].[service.FormSectionAttachments] CHECK CONSTRAINT [FK_FormSectionAttachments_Attachments]
GO
ALTER TABLE [dbo].[service.FormSectionFields]  WITH CHECK ADD  CONSTRAINT [FK_FormFields_Forms] FOREIGN KEY([FormSectionId])
REFERENCES [dbo].[service.FormSections] ([Id])
GO
ALTER TABLE [dbo].[service.FormSectionFields] CHECK CONSTRAINT [FK_FormFields_Forms]
GO
ALTER TABLE [dbo].[service.FormSectionFields]  WITH CHECK ADD  CONSTRAINT [FK_FormSectionFields_EntityFields] FOREIGN KEY([EntityFieldId])
REFERENCES [dbo].[service.EntityFields] ([Id])
GO
ALTER TABLE [dbo].[service.FormSectionFields] CHECK CONSTRAINT [FK_FormSectionFields_EntityFields]
GO
ALTER TABLE [dbo].[service.FormSectionFields]  WITH CHECK ADD  CONSTRAINT [FK_service.FormSectionFields_service.FormSectionFields] FOREIGN KEY([FormSectionParentId])
REFERENCES [dbo].[service.FormSectionFields] ([Id])
GO
ALTER TABLE [dbo].[service.FormSectionFields] CHECK CONSTRAINT [FK_service.FormSectionFields_service.FormSectionFields]
GO
ALTER TABLE [dbo].[service.FormSections]  WITH CHECK ADD  CONSTRAINT [FK_FormSections_Forms] FOREIGN KEY([FormId])
REFERENCES [dbo].[service.Forms] ([Id])
GO
ALTER TABLE [dbo].[service.FormSections] CHECK CONSTRAINT [FK_FormSections_Forms]
GO
ALTER TABLE [dbo].[service.Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Groups] FOREIGN KEY([ParentId])
REFERENCES [dbo].[service.Groups] ([Id])
GO
ALTER TABLE [dbo].[service.Groups] CHECK CONSTRAINT [FK_Groups_Groups]
GO
ALTER TABLE [dbo].[service.LookupFieldsValues]  WITH CHECK ADD  CONSTRAINT [FK_service.LookupFieldsValues_service.EntityFields] FOREIGN KEY([EntityFieldId])
REFERENCES [dbo].[service.EntityFields] ([Id])
GO
ALTER TABLE [dbo].[service.LookupFieldsValues] CHECK CONSTRAINT [FK_service.LookupFieldsValues_service.EntityFields]
GO
ALTER TABLE [dbo].[service.LookupFieldsValues]  WITH CHECK ADD  CONSTRAINT [FK_service.LookupFieldsValues_service.LookupFieldsValues] FOREIGN KEY([ParentId])
REFERENCES [dbo].[service.LookupFieldsValues] ([Id])
GO
ALTER TABLE [dbo].[service.LookupFieldsValues] CHECK CONSTRAINT [FK_service.LookupFieldsValues_service.LookupFieldsValues]
GO
ALTER TABLE [dbo].[service.Services]  WITH CHECK ADD  CONSTRAINT [FK_Services_Groups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[service.Groups] ([Id])
GO
ALTER TABLE [dbo].[service.Services] CHECK CONSTRAINT [FK_Services_Groups]
GO
ALTER TABLE [dbo].[service.StageActionRoles]  WITH CHECK ADD  CONSTRAINT [FK_StageActionRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[service.Roles] ([Id])
GO
ALTER TABLE [dbo].[service.StageActionRoles] CHECK CONSTRAINT [FK_StageActionRoles_Roles]
GO
ALTER TABLE [dbo].[service.StageActionRoles]  WITH CHECK ADD  CONSTRAINT [FK_StageActionRoles_StageActions] FOREIGN KEY([StageActionId])
REFERENCES [dbo].[service.StageActions] ([Id])
GO
ALTER TABLE [dbo].[service.StageActionRoles] CHECK CONSTRAINT [FK_StageActionRoles_StageActions]
GO
ALTER TABLE [dbo].[service.StageActions]  WITH CHECK ADD  CONSTRAINT [FK_ServiceActions_Stages] FOREIGN KEY([StageId])
REFERENCES [dbo].[service.Stages] ([Id])
GO
ALTER TABLE [dbo].[service.StageActions] CHECK CONSTRAINT [FK_ServiceActions_Stages]
GO
ALTER TABLE [dbo].[service.StageActions]  WITH CHECK ADD  CONSTRAINT [FK_StageActions_ActionType] FOREIGN KEY([ActionTypeId])
REFERENCES [dbo].[service.ActionTypes] ([Id])
GO
ALTER TABLE [dbo].[service.StageActions] CHECK CONSTRAINT [FK_StageActions_ActionType]
GO
ALTER TABLE [dbo].[service.StageForms]  WITH CHECK ADD  CONSTRAINT [FK_StageForms_Forms] FOREIGN KEY([FormId])
REFERENCES [dbo].[service.Forms] ([Id])
GO
ALTER TABLE [dbo].[service.StageForms] CHECK CONSTRAINT [FK_StageForms_Forms]
GO
ALTER TABLE [dbo].[service.StageForms]  WITH CHECK ADD  CONSTRAINT [FK_StageForms_Stages] FOREIGN KEY([StageId])
REFERENCES [dbo].[service.Stages] ([Id])
GO
ALTER TABLE [dbo].[service.StageForms] CHECK CONSTRAINT [FK_StageForms_Stages]
GO
ALTER TABLE [dbo].[service.Stages]  WITH CHECK ADD  CONSTRAINT [FK_service.Stages_service.StageTypes] FOREIGN KEY([StageTypeId])
REFERENCES [dbo].[service.StageTypes] ([Id])
GO
ALTER TABLE [dbo].[service.Stages] CHECK CONSTRAINT [FK_service.Stages_service.StageTypes]
GO
ALTER TABLE [dbo].[service.Stages]  WITH CHECK ADD  CONSTRAINT [FK_Stages_Services] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[service.Services] ([Id])
GO
ALTER TABLE [dbo].[service.Stages] CHECK CONSTRAINT [FK_Stages_Services]
GO
ALTER TABLE [dbo].[service.TextResourcesKeys]  WITH CHECK ADD  CONSTRAINT [FK_TextResourcesKeys_TextResourcesCategories] FOREIGN KEY([TextResourceCategoryId])
REFERENCES [dbo].[service.TextResourcesCategories] ([Id])
GO
ALTER TABLE [dbo].[service.TextResourcesKeys] CHECK CONSTRAINT [FK_TextResourcesKeys_TextResourcesCategories]
GO
ALTER TABLE [dbo].[service.TextResourceValues]  WITH CHECK ADD  CONSTRAINT [FK_TextResourceValues_TextResourcesKeys] FOREIGN KEY([TextResourcesKeyId])
REFERENCES [dbo].[service.TextResourcesKeys] ([Id])
GO
ALTER TABLE [dbo].[service.TextResourceValues] CHECK CONSTRAINT [FK_TextResourceValues_TextResourcesKeys]
GO
ALTER TABLE [dbo].[service.Translations]  WITH CHECK ADD  CONSTRAINT [FK_Translations_Languages] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[service.Languages] ([Id])
GO
ALTER TABLE [dbo].[service.Translations] CHECK CONSTRAINT [FK_Translations_Languages]
GO
ALTER TABLE [dbo].[service.Translations]  WITH CHECK ADD  CONSTRAINT [FK_Translations_TranslationKeys] FOREIGN KEY([TranslationKeyId])
REFERENCES [dbo].[service.TranslationKeys] ([Id])
GO
ALTER TABLE [dbo].[service.Translations] CHECK CONSTRAINT [FK_Translations_TranslationKeys]
GO
/****** Object:  StoredProcedure [dbo].[AddService]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec AddService 'Sample','Desc'
-- =============================================
CREATE PROCEDURE [dbo].[AddService]
	-- Add the parameters for the stored procedure here
	@Name NVARCHAR(100),
	@Description NVARCHAR(400)
AS
BEGIN
DECLARE @ServiceID AS INT
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO [service.Services](Name, GroupId, OrderNumber, Description) VALUES(@Name,1,8,@Description)

	SET @ServiceID = SCOPE_IDENTITY();

	print  @ServiceID

	SELECT @ServiceID AS Id, 200 as Status,'Success' as SuccessMessage;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddApplications]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec sp_AddApplications 1,1,'12/12/2016','ClientIP',NULL
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddApplications]
	@ServiceId INT,
	@CreatorId INT,
	@UserAgent NVARCHAR(500),
	@ClientIP NVARCHAR(50),
	@ParentApplication INT
AS
BEGIN

DECLARE @ApplicationId AS INT
DECLARE @CurrentDate AS DATETIME
SET @CurrentDate = GETDATE();

BEGIN TRY
	BEGIN TRAN

		INSERT INTO [application.Applications](ServiceId, CreatorId, CreatedOn, DeviceTypeId, ApplicationNumber, UserAgent, ClientIPAddress, ParentApplicationId)
		VALUES(@ServiceId,@CreatorId,@CurrentDate,1,1,@UserAgent,@ClientIP,Null)

		SET @ApplicationId = SCOPE_IDENTITY()

		INSERT INTO [application.ApplicationStages](ApplicationId,UserId, StageId, CreatedOn, StageStatusId, PreviousStageId)
		VALUES(@ApplicationId,1,1,@CurrentDate,1,NULL)

		SELECT @ApplicationId AS Id, 200 as Status,'Success' as SuccessMessage;

	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT @ApplicationId AS Id, 500 as Status,'Not Saved' as ErrorMessage;
END CATCH


END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllLanguages]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllLanguages] 
AS
    BEGIN
        SELECT L.Id AS 'Id', 
               L.Name AS 'LanguageName',
			   L.Direction AS 'Direction'
        FROM [service.Languages] AS L
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetResourceKeyValues]    Script Date: 11/26/2020 10:59:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetResourceKeyValues] @categoryname VARCHAR(100), 
                                         @languageid   INT
AS
    BEGIN
        SELECT TRV.Id AS 'Id', 
               TRK.TextresourcesKeyName AS 'Key', 
               TRV.Value AS 'Value'
        FROM dbo.[service.TextResourceValues] AS TRV
             INNER JOIN dbo.[service.TextResourcesKeys] AS TRK ON TRK.Id = TRV.TextResourcesKeyId
             INNER JOIN dbo.[service.TextResourcesCategories] AS TRC ON TRC.Id = TRK.TextResourceCategoryId
             INNER JOIN dbo.[service.Languages] AS L ON L.Id = TRV.LanguageId
        WHERE TRC.TextResourceCategoryName = @categoryname
              AND TRV.LanguageId = @languageid;
    END;
GO
