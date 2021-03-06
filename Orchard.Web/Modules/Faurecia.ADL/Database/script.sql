USE [master]
GO
/****** Object:  Database [FaureciaBM]    Script Date: 2017/3/18 23:01:28 ******/
CREATE DATABASE [FaureciaBM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FaureciaBM', FILENAME = N'E:\Mine\projects\FaureciaBM.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FaureciaBM_log', FILENAME = N'E:\Mine\projects\FaureciaBM_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FaureciaBM] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FaureciaBM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FaureciaBM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FaureciaBM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FaureciaBM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FaureciaBM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FaureciaBM] SET ARITHABORT OFF 
GO
ALTER DATABASE [FaureciaBM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FaureciaBM] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [FaureciaBM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FaureciaBM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FaureciaBM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FaureciaBM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FaureciaBM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FaureciaBM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FaureciaBM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FaureciaBM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FaureciaBM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FaureciaBM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FaureciaBM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FaureciaBM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FaureciaBM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FaureciaBM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FaureciaBM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FaureciaBM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FaureciaBM] SET RECOVERY FULL 
GO
ALTER DATABASE [FaureciaBM] SET  MULTI_USER 
GO
ALTER DATABASE [FaureciaBM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FaureciaBM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FaureciaBM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FaureciaBM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'FaureciaBM', N'ON'
GO
USE [FaureciaBM]
GO
/****** Object:  Table [dbo].[Common_BodyPartRecord]    Script Date: 2017/3/18 23:01:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Common_BodyPartRecord](
	[Id] [int] NOT NULL,
	[ContentItemRecord_id] [int] NULL,
	[Text] [nvarchar](max) NULL,
	[Format] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Common_CommonPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Common_CommonPartRecord](
	[Id] [int] NOT NULL,
	[OwnerId] [int] NULL,
	[CreatedUtc] [datetime] NULL,
	[PublishedUtc] [datetime] NULL,
	[ModifiedUtc] [datetime] NULL,
	[Container_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Common_CommonPartVersionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Common_CommonPartVersionRecord](
	[Id] [int] NOT NULL,
	[ContentItemRecord_id] [int] NULL,
	[CreatedUtc] [datetime] NULL,
	[PublishedUtc] [datetime] NULL,
	[ModifiedUtc] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Common_IdentityPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Common_IdentityPartRecord](
	[Id] [int] NOT NULL,
	[Identifier] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Containers_ContainablePartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Containers_ContainablePartRecord](
	[Id] [int] NOT NULL,
	[Position] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Containers_ContainerPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Containers_ContainerPartRecord](
	[Id] [int] NOT NULL,
	[Paginated] [bit] NULL,
	[PageSize] [int] NULL,
	[ItemContentTypes] [nvarchar](255) NULL,
	[ItemsShown] [bit] NOT NULL,
	[ShowOnAdminMenu] [bit] NOT NULL,
	[AdminMenuText] [nvarchar](50) NULL,
	[AdminMenuPosition] [nvarchar](50) NULL,
	[AdminMenuImageSet] [nvarchar](50) NULL,
	[EnablePositioning] [bit] NULL,
	[AdminListViewName] [nvarchar](50) NULL,
	[ItemCount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Containers_ContainerWidgetPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Containers_ContainerWidgetPartRecord](
	[Id] [int] NOT NULL,
	[ContainerId] [int] NULL,
	[PageSize] [int] NULL,
	[OrderByProperty] [nvarchar](64) NULL,
	[OrderByDirection] [int] NULL,
	[ApplyFilter] [bit] NULL,
	[FilterByProperty] [nvarchar](64) NULL,
	[FilterByOperator] [nvarchar](4) NULL,
	[FilterByValue] [nvarchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ActivityTypeRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ActivityTypeRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ActivityType] [nvarchar](255) NULL,
	[CostCenter] [nvarchar](255) NULL,
	[RMBHour] [nvarchar](255) NULL,
	[Comment] [nvarchar](255) NULL,
	[DisplayGroup] [nvarchar](255) NULL,
	[TotalGroup] [nvarchar](255) NULL,
	[IsUsed] [bit] NULL,
	[CreateTime] [datetime] NULL,
	[Creator] [nvarchar](255) NULL,
	[EditTime] [datetime] NULL,
	[Editor] [nvarchar](255) NULL,
	[VersionNo] [int] NULL,
	[OriginalRecordId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ActualCostRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ActualCostRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[YearMonth] [nvarchar](255) NULL,
	[WBSID] [nvarchar](255) NULL,
	[WBSElement] [nvarchar](255) NULL,
	[CostValue] [float] NULL,
	[Creator] [nvarchar](255) NULL,
	[CreateTime] [datetime] NULL,
	[Editor] [nvarchar](255) NULL,
	[EditTime] [datetime] NULL,
 CONSTRAINT [PK__Faurecia__3214EC0758573203] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLCostRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLCostRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[ActivityTypeRecord_Id] [int] NULL,
	[ADLRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLHeadCountRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLHeadCountRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[ActivityTypeRecord_Id] [int] NULL,
	[ADLRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLHourRatioRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLHourRatioRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[ActivityTypeRecord_Id] [int] NULL,
	[ADLRecord_Id] [int] NULL,
	[VersionNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLKickOffRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLKickOffRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Content] [nvarchar](255) NULL,
	[CreateTime] [datetime] NULL,
	[Creator] [nvarchar](255) NULL,
	[ADLRecord_Id] [int] NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNo] [nvarchar](255) NULL,
	[VersionNo] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[Currency] [nvarchar](255) NULL,
	[ProgramManager] [nvarchar](255) NULL,
	[ProgramController] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[StartDate] [datetime] NULL,
	[OfferDate] [datetime] NULL,
	[ProtoDate] [datetime] NULL,
	[PTRDate] [datetime] NULL,
	[SOPDate] [datetime] NULL,
	[MockUp] [datetime] NULL,
	[Award] [datetime] NULL,
	[MileStoneComments] [nvarchar](500) NULL,
	[Variant1] [nvarchar](255) NULL,
	[Variant2] [nvarchar](255) NULL,
	[Variant3] [nvarchar](255) NULL,
	[FrameMaturity] [nvarchar](255) NULL,
	[VehicelComments] [nvarchar](500) NULL,
	[Tracks] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Phase] [nvarchar](255) NULL,
	[Recliner] [nvarchar](255) NULL,
	[HA] [nvarchar](255) NULL,
	[Ballfix] [nvarchar](255) NULL,
	[KEZE] [nvarchar](255) NULL,
	[QuotationComments] [nvarchar](500) NULL,
	[Quotation] [nvarchar](255) NULL,
	[QuotationTime] [datetime] NULL,
	[IBPComments] [nvarchar](500) NULL,
	[IBP] [nvarchar](255) NULL,
	[IBPTime] [datetime] NULL,
	[IsLastest] [bit] NULL,
	[Creator] [nvarchar](255) NULL,
	[CreateTime] [datetime] NULL,
	[Editor] [nvarchar](255) NULL,
	[EditTime] [datetime] NULL,
	[WBSID] [nvarchar](255) NULL,
	[ProgramKickOff] [datetime] NULL,
	[DV] [datetime] NULL,
	[ToolingKickOff] [datetime] NULL,
	[PV] [datetime] NULL,
 CONSTRAINT [PK__Faurecia__3214EC07814FAC64] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_ADLWorkingHourRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_ADLWorkingHourRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[ADLRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_HeadCountRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_HeadCountRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[IsUsed] [bit] NULL,
	[CreateTime] [datetime] NULL,
	[Creator] [nvarchar](255) NULL,
	[EditTime] [datetime] NULL,
	[Editor] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_HourRatioRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_HourRatioRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[ActivityTypeRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faurecia_ADL_WorkingHourRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faurecia_ADL_WorkingHourRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dev] [float] NULL,
	[IsUsed] [bit] NULL,
	[CreateTime] [datetime] NULL,
	[Creator] [nvarchar](255) NULL,
	[EditTime] [datetime] NULL,
	[Editor] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Navigation_AdminMenuPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Navigation_AdminMenuPartRecord](
	[Id] [int] NOT NULL,
	[AdminMenuText] [nvarchar](255) NULL,
	[AdminMenuPosition] [nvarchar](255) NULL,
	[OnAdminMenu] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Navigation_MenuPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Navigation_MenuPartRecord](
	[Id] [int] NOT NULL,
	[MenuText] [nvarchar](255) NULL,
	[MenuPosition] [nvarchar](255) NULL,
	[MenuId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Alias_ActionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Alias_ActionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Area] [nvarchar](255) NULL,
	[Controller] [nvarchar](255) NULL,
	[Action] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Alias_AliasRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Alias_AliasRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](2048) NULL,
	[Action_id] [int] NULL,
	[RouteValues] [nvarchar](max) NULL,
	[Source] [nvarchar](256) NULL,
	[IsManaged] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Autoroute_AutoroutePartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Autoroute_AutoroutePartRecord](
	[Id] [int] NOT NULL,
	[ContentItemRecord_id] [int] NULL,
	[CustomPattern] [nvarchar](2048) NULL,
	[UseCustomPattern] [bit] NULL,
	[UseCulturePattern] [bit] NULL,
	[DisplayAlias] [nvarchar](2048) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Blogs_BlogArchivesPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Blogs_BlogArchivesPartRecord](
	[Id] [int] NOT NULL,
	[BlogId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Blogs_BlogPartArchiveRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Blogs_BlogPartArchiveRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[PostCount] [int] NULL,
	[BlogPart_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Blogs_RecentBlogPostsPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Blogs_RecentBlogPostsPartRecord](
	[Id] [int] NOT NULL,
	[BlogId] [int] NULL,
	[Count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Comments_CommentPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Comments_CommentPartRecord](
	[Id] [int] NOT NULL,
	[Author] [nvarchar](255) NULL,
	[SiteName] [nvarchar](255) NULL,
	[UserName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[CommentDateUtc] [datetime] NULL,
	[CommentText] [nvarchar](max) NULL,
	[CommentedOn] [int] NULL,
	[CommentedOnContainer] [int] NULL,
	[RepliedOn] [int] NULL,
	[Position] [decimal](19, 5) NULL,
	[CommentsPartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Comments_CommentsPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Comments_CommentsPartRecord](
	[Id] [int] NOT NULL,
	[CommentsShown] [bit] NULL,
	[CommentsActive] [bit] NULL,
	[ThreadedComments] [bit] NULL,
	[CommentsCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_ContentPicker_ContentMenuItemPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_ContentPicker_ContentMenuItemPartRecord](
	[Id] [int] NOT NULL,
	[ContentMenuItemRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_ContentItemRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_ContentItemRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[ContentType_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_ContentItemVersionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_ContentItemVersionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NULL,
	[Published] [bit] NULL,
	[Latest] [bit] NULL,
	[Data] [nvarchar](max) NULL,
	[ContentItemRecord_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_ContentTypeRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_ContentTypeRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_CultureRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_CultureRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Culture] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_DataMigrationRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_DataMigrationRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataMigrationClass] [nvarchar](255) NULL,
	[Version] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Framework_DistributedLockRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Framework_DistributedLockRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](512) NOT NULL,
	[MachineName] [nvarchar](256) NULL,
	[CreatedUtc] [datetime] NULL,
	[ValidUntilUtc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Layouts_ElementBlueprint]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Layouts_ElementBlueprint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BaseElementTypeName] [nvarchar](256) NULL,
	[ElementTypeName] [nvarchar](256) NULL,
	[ElementDisplayName] [nvarchar](256) NULL,
	[ElementDescription] [nvarchar](2048) NULL,
	[ElementCategory] [nvarchar](256) NULL,
	[BaseElementState] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Layouts_LayoutPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Layouts_LayoutPartRecord](
	[Id] [int] NOT NULL,
	[ContentItemRecord_id] [int] NULL,
	[TemplateId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_MediaLibrary_MediaPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_MediaLibrary_MediaPartRecord](
	[Id] [int] NOT NULL,
	[MimeType] [nvarchar](255) NULL,
	[Caption] [nvarchar](max) NULL,
	[AlternateText] [nvarchar](max) NULL,
	[FolderPath] [nvarchar](2048) NULL,
	[FileName] [nvarchar](2048) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_MediaProcessing_FileNameRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_MediaProcessing_FileNameRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](max) NULL,
	[FileName] [nvarchar](max) NULL,
	[ImageProfilePartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_MediaProcessing_FilterRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_MediaProcessing_FilterRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](64) NULL,
	[Type] [nvarchar](64) NULL,
	[Description] [nvarchar](255) NULL,
	[State] [nvarchar](max) NULL,
	[Position] [int] NULL,
	[ImageProfilePartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_MediaProcessing_ImageProfilePartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_MediaProcessing_ImageProfilePartRecord](
	[Name] [nvarchar](255) NULL,
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_OutputCache_CacheParameterRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_OutputCache_CacheParameterRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Duration] [int] NULL,
	[GraceTime] [int] NULL,
	[RouteKey] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Packaging_PackagingSource]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Packaging_PackagingSource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FeedTitle] [nvarchar](255) NULL,
	[FeedUrl] [nvarchar](2048) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_DecimalFieldIndexRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_DecimalFieldIndexRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [nvarchar](255) NULL,
	[Value] [decimal](19, 5) NULL,
	[FieldIndexPartRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_DoubleFieldIndexRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_DoubleFieldIndexRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [nvarchar](255) NULL,
	[Value] [float] NULL,
	[FieldIndexPartRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_FieldIndexPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_FieldIndexPartRecord](
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_FilterGroupRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_FilterGroupRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QueryPartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_FilterRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_FilterRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](64) NULL,
	[Type] [nvarchar](64) NULL,
	[Description] [nvarchar](255) NULL,
	[State] [nvarchar](max) NULL,
	[Position] [int] NULL,
	[FilterGroupRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_IntegerFieldIndexRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_IntegerFieldIndexRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [nvarchar](255) NULL,
	[Value] [bigint] NULL,
	[FieldIndexPartRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_LayoutRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_LayoutRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](64) NULL,
	[Type] [nvarchar](64) NULL,
	[Description] [nvarchar](255) NULL,
	[State] [nvarchar](max) NULL,
	[DisplayType] [nvarchar](64) NULL,
	[Display] [int] NULL,
	[QueryPartRecord_id] [int] NULL,
	[GroupProperty_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_MemberBindingRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_MemberBindingRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NULL,
	[Member] [nvarchar](64) NULL,
	[Description] [nvarchar](500) NULL,
	[DisplayName] [nvarchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_NavigationQueryPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_NavigationQueryPartRecord](
	[Id] [int] NOT NULL,
	[Items] [int] NULL,
	[Skip] [int] NULL,
	[QueryPartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_ProjectionPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_ProjectionPartRecord](
	[Id] [int] NOT NULL,
	[Items] [int] NULL,
	[ItemsPerPage] [int] NULL,
	[Skip] [int] NULL,
	[PagerSuffix] [nvarchar](255) NULL,
	[MaxItems] [int] NULL,
	[DisplayPager] [bit] NULL,
	[QueryPartRecord_id] [int] NULL,
	[LayoutRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_PropertyRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_PropertyRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](64) NULL,
	[Type] [nvarchar](64) NULL,
	[Description] [nvarchar](255) NULL,
	[State] [nvarchar](max) NULL,
	[Position] [int] NULL,
	[LayoutRecord_id] [int] NULL,
	[ExcludeFromDisplay] [bit] NULL,
	[CreateLabel] [bit] NULL,
	[Label] [nvarchar](255) NULL,
	[LinkToContent] [bit] NULL,
	[CustomizePropertyHtml] [bit] NULL,
	[CustomPropertyTag] [nvarchar](64) NULL,
	[CustomPropertyCss] [nvarchar](64) NULL,
	[CustomizeLabelHtml] [bit] NULL,
	[CustomLabelTag] [nvarchar](64) NULL,
	[CustomLabelCss] [nvarchar](64) NULL,
	[CustomizeWrapperHtml] [bit] NULL,
	[CustomWrapperTag] [nvarchar](64) NULL,
	[CustomWrapperCss] [nvarchar](64) NULL,
	[NoResultText] [nvarchar](max) NULL,
	[ZeroIsEmpty] [bit] NULL,
	[HideEmpty] [bit] NULL,
	[RewriteOutput] [bit] NULL,
	[RewriteText] [nvarchar](max) NULL,
	[StripHtmlTags] [bit] NULL,
	[TrimLength] [bit] NULL,
	[AddEllipsis] [bit] NULL,
	[MaxLength] [int] NULL,
	[TrimOnWordBoundary] [bit] NULL,
	[PreserveLines] [bit] NULL,
	[TrimWhiteSpace] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_QueryPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_QueryPartRecord](
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_SortCriterionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_SortCriterionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](64) NULL,
	[Type] [nvarchar](64) NULL,
	[Description] [nvarchar](255) NULL,
	[State] [nvarchar](max) NULL,
	[Position] [int] NULL,
	[QueryPartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Projections_StringFieldIndexRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Projections_StringFieldIndexRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [nvarchar](255) NULL,
	[Value] [nvarchar](4000) NULL,
	[FieldIndexPartRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Recipes_RecipeStepResultRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Recipes_RecipeStepResultRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionId] [nvarchar](128) NOT NULL,
	[RecipeName] [nvarchar](256) NULL,
	[StepId] [nvarchar](32) NOT NULL,
	[StepName] [nvarchar](256) NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[IsSuccessful] [bit] NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Roles_PermissionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Roles_PermissionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[FeatureName] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Roles_RoleRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Roles_RoleRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Roles_RolesPermissionsRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Roles_RolesPermissionsRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role_id] [int] NULL,
	[Permission_id] [int] NULL,
	[RoleRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Roles_UserRolesPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Roles_UserRolesPartRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Role_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Tags_ContentTagRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Tags_ContentTagRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagRecord_Id] [int] NULL,
	[TagsPartRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Tags_TagRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Tags_TagRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Tags_TagsPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Tags_TagsPartRecord](
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Taxonomies_TaxonomyPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Taxonomies_TaxonomyPartRecord](
	[Id] [int] NOT NULL,
	[TermTypeName] [nvarchar](255) NULL,
	[IsInternal] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Taxonomies_TermContentItem]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Taxonomies_TermContentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Field] [nvarchar](50) NULL,
	[TermRecord_id] [int] NULL,
	[TermsPartRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Taxonomies_TermPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Taxonomies_TermPartRecord](
	[Id] [int] NOT NULL,
	[Path] [nvarchar](255) NULL,
	[TaxonomyId] [int] NULL,
	[Count] [int] NULL,
	[Weight] [int] NULL,
	[Selectable] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Taxonomies_TermsPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Taxonomies_TermsPartRecord](
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Users_UserPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Users_UserPartRecord](
	[Id] [int] NOT NULL,
	[UserName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[NormalizedUserName] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[PasswordFormat] [nvarchar](255) NULL,
	[HashAlgorithm] [nvarchar](255) NULL,
	[PasswordSalt] [nvarchar](255) NULL,
	[RegistrationStatus] [nvarchar](255) NULL,
	[EmailStatus] [nvarchar](255) NULL,
	[EmailChallengeToken] [nvarchar](255) NULL,
	[CreatedUtc] [datetime] NULL,
	[LastLoginUtc] [datetime] NULL,
	[LastLogoutUtc] [datetime] NULL,
	[LastPasswordChangeUtc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Widgets_LayerPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Widgets_LayerPartRecord](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[LayerRule] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Widgets_WidgetPartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Widgets_WidgetPartRecord](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Position] [nvarchar](255) NULL,
	[Zone] [nvarchar](255) NULL,
	[RenderTitle] [bit] NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Workflows_ActivityRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Workflows_ActivityRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[X] [int] NULL,
	[Y] [int] NULL,
	[State] [nvarchar](max) NULL,
	[Start] [bit] NULL,
	[WorkflowDefinitionRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Workflows_AwaitingActivityRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Workflows_AwaitingActivityRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ActivityRecord_id] [int] NULL,
	[WorkflowRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Workflows_TransitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Workflows_TransitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SourceEndpoint] [nvarchar](255) NULL,
	[DestinationEndpoint] [nvarchar](255) NULL,
	[SourceActivityRecord_id] [int] NULL,
	[DestinationActivityRecord_id] [int] NULL,
	[WorkflowDefinitionRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Workflows_WorkflowDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Workflows_WorkflowDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Enabled] [bit] NULL,
	[Name] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orchard_Workflows_WorkflowRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orchard_Workflows_WorkflowRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[State] [nvarchar](max) NULL,
	[WorkflowDefinitionRecord_id] [int] NULL,
	[ContentItemRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Scheduling_ScheduledTaskRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scheduling_ScheduledTaskRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskType] [nvarchar](255) NULL,
	[ScheduledUtc] [datetime] NULL,
	[ContentItemVersionRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ContentFieldDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ContentFieldDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ContentPartDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ContentPartDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Hidden] [bit] NULL,
	[Settings] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ContentPartFieldDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ContentPartFieldDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Settings] [nvarchar](max) NULL,
	[ContentFieldDefinitionRecord_id] [int] NULL,
	[ContentPartDefinitionRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ContentTypeDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ContentTypeDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[DisplayName] [nvarchar](255) NULL,
	[Hidden] [bit] NULL,
	[Settings] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ContentTypePartDefinitionRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ContentTypePartDefinitionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Settings] [nvarchar](max) NULL,
	[ContentPartDefinitionRecord_id] [int] NULL,
	[ContentTypeDefinitionRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ShellDescriptorRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ShellDescriptorRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialNumber] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ShellFeatureRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ShellFeatureRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ShellDescriptorRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ShellFeatureStateRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ShellFeatureStateRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[InstallState] [nvarchar](255) NULL,
	[EnableState] [nvarchar](255) NULL,
	[ShellStateRecord_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ShellParameterRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ShellParameterRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Component] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[ShellDescriptorRecord_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings_ShellStateRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings_ShellStateRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Unused] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Title_TitlePartRecord]    Script Date: 2017/3/18 23:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title_TitlePartRecord](
	[Id] [int] NOT NULL,
	[ContentItemRecord_id] [int] NULL,
	[Title] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (3, 2, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (4, 2, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (5, 2, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (6, 2, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (7, 2, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (8, 0, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (9, 2, CAST(0x0000A6EC00527D30 AS DateTime), CAST(0x0000A6EC00527D30 AS DateTime), CAST(0x0000A6EC0052DFA0 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (10, 2, CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EF0104C2B0 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (11, 2, CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), 3)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (12, 2, CAST(0x0000A6EF0102FD2C AS DateTime), CAST(0x0000A6EF0102FD2C AS DateTime), CAST(0x0000A6EF0102FD2C AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (13, 2, CAST(0x0000A6EF01032630 AS DateTime), CAST(0x0000A72500A26A20 AS DateTime), CAST(0x0000A72500A26A20 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (14, 2, CAST(0x0000A6EF01035C18 AS DateTime), CAST(0x0000A72500A27A88 AS DateTime), CAST(0x0000A72500A27A88 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (15, 2, CAST(0x0000A6EF0103851C AS DateTime), CAST(0x0000A6F8002F646C AS DateTime), CAST(0x0000A6F8002F646C AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (16, 2, CAST(0x0000A6EF0103A970 AS DateTime), CAST(0x0000A6EF0103A970 AS DateTime), CAST(0x0000A6EF0103A970 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (17, 2, CAST(0x0000A6EF0103BC30 AS DateTime), CAST(0x0000A72500A038CC AS DateTime), CAST(0x0000A72500A038CC AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (18, 2, CAST(0x0000A6F0002E6AD0 AS DateTime), CAST(0x0000A6F0002EC2B4 AS DateTime), CAST(0x0000A6F0002EC2B4 AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartRecord] ([Id], [OwnerId], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [Container_id]) VALUES (19, 2, CAST(0x0000A726015E1EDC AS DateTime), CAST(0x0000A726015E1EDC AS DateTime), CAST(0x0000A726015E1EDC AS DateTime), NULL)
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (3, 3, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (4, 4, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (5, 5, CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), CAST(0x0000A6EC00527AD8 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (6, 6, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (7, 7, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (8, 8, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527C04 AS DateTime), N'')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (9, 9, CAST(0x0000A6EC00527C04 AS DateTime), CAST(0x0000A6EC00527D30 AS DateTime), CAST(0x0000A6EC0052DFA0 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (10, 10, CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EF0104C2B0 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (11, 11, CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), CAST(0x0000A6EC00527E5C AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (12, 12, CAST(0x0000A6EF0102FD2C AS DateTime), CAST(0x0000A6EF0102FD2C AS DateTime), CAST(0x0000A6EF0102FD2C AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (13, 13, CAST(0x0000A6EF01032630 AS DateTime), CAST(0x0000A6EF01032630 AS DateTime), CAST(0x0000A6EF01032630 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (14, 14, CAST(0x0000A6EF01035C18 AS DateTime), CAST(0x0000A6EF01035C18 AS DateTime), CAST(0x0000A6EF01035C18 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (15, 15, CAST(0x0000A6EF0103851C AS DateTime), CAST(0x0000A6EF0103851C AS DateTime), CAST(0x0000A6EF0103851C AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (16, 16, CAST(0x0000A6EF0103A970 AS DateTime), CAST(0x0000A6EF0103A970 AS DateTime), CAST(0x0000A6EF0103A970 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (17, 17, CAST(0x0000A6EF0103BC30 AS DateTime), CAST(0x0000A6EF0103BC30 AS DateTime), CAST(0x0000A6EF0103BC30 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (18, 18, CAST(0x0000A6F0002E99B0 AS DateTime), CAST(0x0000A6F0002E99B0 AS DateTime), CAST(0x0000A6F0002E99B0 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (19, 18, CAST(0x0000A6F0002EC2B4 AS DateTime), CAST(0x0000A6F0002EC2B4 AS DateTime), CAST(0x0000A6F0002EC2B4 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (20, 15, CAST(0x0000A6F8002F6340 AS DateTime), CAST(0x0000A6F8002F646C AS DateTime), CAST(0x0000A6F8002F646C AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (21, 13, CAST(0x0000A6F8002F8E9C AS DateTime), CAST(0x0000A6F8002F8E9C AS DateTime), CAST(0x0000A6F8002F8E9C AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (22, 17, CAST(0x0000A72500A037A0 AS DateTime), CAST(0x0000A72500A038CC AS DateTime), CAST(0x0000A72500A038CC AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (23, 13, CAST(0x0000A72500A23A14 AS DateTime), CAST(0x0000A72500A23A14 AS DateTime), CAST(0x0000A72500A23A14 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (24, 13, CAST(0x0000A72500A26A20 AS DateTime), CAST(0x0000A72500A26A20 AS DateTime), CAST(0x0000A72500A26A20 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (25, 14, CAST(0x0000A72500A27A88 AS DateTime), CAST(0x0000A72500A27A88 AS DateTime), CAST(0x0000A72500A27A88 AS DateTime), N'admin')
INSERT [dbo].[Common_CommonPartVersionRecord] ([Id], [ContentItemRecord_id], [CreatedUtc], [PublishedUtc], [ModifiedUtc], [ModifiedBy]) VALUES (26, 19, CAST(0x0000A726015E1EDC AS DateTime), CAST(0x0000A726015E1EDC AS DateTime), CAST(0x0000A726015E1EDC AS DateTime), N'admin')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (8, N'2adb01dc436644a4b4667cda3ff9b513')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (10, N'ccd1f156d4374a58af22b624cdb3f9f3')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (11, N'MenuWidget1')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (12, N'ae1b7df5e8c14a089bab56c4e94bf122')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (13, N'ff5ce931527c4dd8baac9e7891313f11')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (14, N'576410e5ee4b423f98ec9e8b36a2a467')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (15, N'4f50d9b5091f4acd99dec607ab48a971')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (16, N'a89b1c566b0b40db9aab2820e7eacf45')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (17, N'4c1328d61035454191aea29b4ddf742f')
INSERT [dbo].[Common_IdentityPartRecord] ([Id], [Identifier]) VALUES (19, N'a017f5aca70c46679f0c2d8636484592')
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ON 

INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (1, N'HDEVA', N'SH13R001', N'Material', NULL, N'DD', N'DD', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72D00F1E30C AS DateTime), N'admin', 0, 1)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (2, N'HDEVA', N'SH13R011', N'Product Design Mech', NULL, N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300015C1EC AS DateTime), N'admin', 2, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (3, N'HDEVB', N'SH13R011', N'Product Design Mech', NULL, N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300015CDA4 AS DateTime), N'admin', 2, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (4, N'HDEVA', N'Wuxi 1772R002', N'ENG_SPG_Design_Mechanism', NULL, N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300031C374 AS DateTime), N'admin', 2, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (5, N'HDEVB', N'Wuxi 1772R002', N'ENG_SPG_Design_Mechanism', NULL, N'DD', N'DD', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72D00F011D0 AS DateTime), N'admin', 0, 1)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (6, N'HDEVA', N'Wuxi 1772R006', N'ENG_SPG_TESTING_Mechanism  Pilot', N'engineer', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (7, N'HDEVA', N'Wuxi 1772R006', N'ENG_SPG_TESTING_Mechanism', N'engineer', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (8, N'HDEVC', N'Wuxi 1772R006', N'ENG_SPG_TESTING_Mechanism', N'engineer', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (9, N'HDEVA', N'Wuxi 1772R007', N'ENG_SPG_PROTOTYPE_Mechanism', N'engineer', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (10, N'HDEVC', N'Wuxi 1772R007', N'ENG_SPG_PROTOTYPE_Mechanism', N'engineer', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (11, N'HDEVB', N'Wuxi 1772R008', N'ENG_SPG_FEA_Mechanism', N'engineer90', N'DD', N'DD', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (13, N'HDEVA', N'Wuxi 1772R003', N'PML Mecha', NULL, N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (14, N'HDEVA', N'Wuxi 1772R004', N'ME: Press', N'engineer', N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (15, N'HDEVA', N'Wuxi 1772R005', N'ME: Pre-assy', N'engineer', N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (16, N'HDEVA', N'Wuxi 1772R006', N'ME: Laser welding', N'engineer', N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (17, N'HDEVA', N'Wuxi 1772R007', N'ME: Assy line', N'engineer', N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (18, N'HDEVA', N'Wuxi 1772R008', N'ME: Post assy (HDM)', N'engineer', N'DD', N'ME', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (23, N'HDEVB', N'SH11P001', N'Buyer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A725014DC294 AS DateTime), N'admin', 0, 1)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (24, N'HDEVA', N'SH11Q001', N'Quality Engineer', NULL, N'DD', N'otherCT', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300011BF5C AS DateTime), N'admin', 3, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (25, N'HDEVA', N'SH11R003', N'Program Manager-Mech', NULL, N'DD', N'otherCT', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (26, N'HDEVA', N'SH11S002', N'Acquisition Manager-Mech', NULL, N'DD', N'otherCT', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (27, N'', N'', N'Travel (ME)', N'', N'Travel', N'Travel', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (28, N'', N'', N'Travel (Design)', N'', N'Travel', N'Travel', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (29, N'', N'', N'Travel (Core Team)', N'', N'Travel', N'Travel', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (30, N'', N'', N'Prototypes for DV', N'', N'DV', N'DV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (31, N'', N'', N'Jigs and Toolings for DV prototypes', N'', N'DV', N'DV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (32, N'', N'', N'Jigs for testing', N'', N'DV', N'DV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (33, N'', N'', N'DV validation testing costs', N'', N'DV', N'DV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (34, N'', N'', N'OTS for PV', N'', N'PV', N'PV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (35, N'', N'', N'PV validation testing costs', N'', N'PV', N'PV', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (36, N'', N'', N'External Support', N'', N'ExternalSupport', N'None', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (37, N'', N'', N'Capitalized', N'', N'Capitalized', N'None', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (38, N'', N'', N'FEA', N'', N'ExternalSupport', N'FEA', 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (52, N'HDEVB', N'SH11P001', N'Buyer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A725014DC294 AS DateTime), N'admin', CAST(0x0000A725014E1BA4 AS DateTime), N'admin', 0, 1)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (53, N'HDEVB', N'SH11P001', N'Buyer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A725014E1BA4 AS DateTime), N'admin', CAST(0x0000A7250150C930 AS DateTime), N'admin', 0, 1)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (54, N'HDEVB', N'SH11P001', N'Buyer', NULL, N'DD', N'otherCT', 1, CAST(0x0000A7250150C930 AS DateTime), N'admin', CAST(0x0000A7300010FBA8 AS DateTime), N'admin', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (55, N'HDEVB', N'Wuxi 1772R002', N'ENG_SPG_Design_Mechanism', NULL, N'DD', N'DD', 1, CAST(0x0000A72D00F011D0 AS DateTime), N'admin', CAST(0x0000A72D00F011D0 AS DateTime), N'admin', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (56, N'HDEVA', N'SH13R001', N'Material', NULL, N'DD', N'DD', 1, CAST(0x0000A72D00F1E30C AS DateTime), N'admin', CAST(0x0000A72D00F1E30C AS DateTime), N'admin', 1, 0)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (57, N'HDEVB', N'SH11P001', N'Buyer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A7250150C930 AS DateTime), N'admin', CAST(0x0000A7300010FBA8 AS DateTime), N'admin', 1, 54)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (58, N'HDEVA', N'SH11Q001', N'Quality Engineer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A73000110C10 AS DateTime), N'admin', 1, 24)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (59, N'HDEVA', N'SH11Q001', N'Quality Engineer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300011907C AS DateTime), N'admin', 1, 24)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (60, N'HDEVA', N'SH11Q001', N'Quality Engineer', NULL, N'DD', N'otherCT', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300011BF5C AS DateTime), N'admin', 2, 24)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (61, N'HDEVA', N'SH13R011', N'Product Design Mech', NULL, N'DD', N'DD', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300015C1EC AS DateTime), N'admin', 1, 2)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (62, N'HDEVB', N'SH13R011', N'Product Design Mech', NULL, N'DD', N'DD', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300015CDA4 AS DateTime), N'admin', 1, 3)
INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] ([Id], [ActivityType], [CostCenter], [RMBHour], [Comment], [DisplayGroup], [TotalGroup], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor], [VersionNo], [OriginalRecordId]) VALUES (63, N'HDEVA', N'Wuxi 1772R002', N'ENG_SPG_Design_Mechanism', NULL, N'DD', N'DD', 0, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A7300031C374 AS DateTime), N'admin', 1, 4)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ActivityTypeRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ON 

INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (33, N'201701', N'SA7064', N'SA7064.EB1772.R1D0001', 5888, N'admin', CAST(0x0000A727004914FC AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (34, N'201701', N'SA7067', N'SA7067.EB1772.R1D0001', 35056, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (35, N'201701', N'SA7068', N'SA7068.EB1772.R1D0001', 8832, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (36, N'201701', N'SA7071', N'SA7071.EB1772.R1D0001', 38640, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (37, N'201701', N'SA7072', N'SA7072.EB1772.R100001', 4416, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (38, N'201701', N'SA7074', N'SA7074.EB1772.R1D0001', 10304, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (39, N'201701', N'SA7123', N'SA7123.EB1772.R1D0001', 103000, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (40, N'201701', N'SA7124', N'SA7124.EB1772.R1D0001', 10304, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (41, N'201701', N'SA7126', N'SA7126.EB1772.R1D0001', 22816, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (42, N'201701', N'SA7127', N'SA7127.EB1772.R1D0001', 53176, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (43, N'201701', N'SD7053', N'SD7053.EB1772.R1D0001', 32384, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (44, N'201701', N'SD7058', N'SD7058.EB1772.R1D0001', 3680, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (45, N'201701', N'SD7116', N'SD7116.EB1772.R1D0001', 4416, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (46, N'201701', N'SD7123', N'SD7123.EB1772.DFMR1D1000', 21344, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (47, N'201701', N'SD7125', N'SD7125.EB1772.R1D0001', 15792, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (48, N'201701', N'SD7160', N'SD7160.EB1772.R1D0001', 35340, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (49, N'201701', N'SD7167', N'SD7167.EB1772.R1D00012', 9568, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (50, N'201701', N'SD7168', N'SD7168.EB1772.DFMR1D1000', 10304, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (51, N'201701', N'SD7173', N'SD7173.EB1772.DFMR1D1000', 18400, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (52, N'201701', N'SD7180', N'SD7180.EB1772.R1D0001', 16192, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (53, N'201701', N'SD7185', N'SD7185.EB1772.R2D0001', 10304, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (54, N'201701', N'SD7188', N'SD7188.EB1772.R2D0001', 2944, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (55, N'201701', N'SD7189', N'SD7189.EB1772.R2D0001', 2208, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (56, N'201701', N'SD7190', N'SD7190.EB1772.R2D0001', 9024, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (57, N'201701', N'SD7191', N'SD7191.EB1772.R2D0001', 39344, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (58, N'201701', N'SD7194', N'SD7194.EB1772.R2D0001', 17664, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (59, N'201701', N'SD7195', N'SD7195.EB1772.R2D0001', 38272, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (60, N'201701', N'SD7196', N'SD7196.EB1772.R1D0001', 10304, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (61, N'201701', N'SP0040', N'SP0040.EC1772.DMSI100141', 33732, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (62, N'201701', N'SP0143', N'SP0143.EB1772.1179', 52992, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (63, N'201701', N'SP0143', N'SP0143.EB1772.1188', 2208, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ActualCostRecord] ([Id], [YearMonth], [WBSID], [WBSElement], [CostValue], [Creator], [CreateTime], [Editor], [EditTime]) VALUES (64, N'201701', N'SP0212', N'SP0212.EC1772.DMS100011', 13248, N'admin', CAST(0x0000A72700493824 AS DateTime), N'admin', CAST(0x0000A73000355584 AS DateTime))
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ActualCostRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (730, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (731, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (732, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (733, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (734, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (735, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (736, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (737, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (738, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (739, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (740, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (741, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (742, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (743, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (744, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (745, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (746, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (747, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (748, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (749, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (750, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (751, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (752, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (753, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (754, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (755, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (756, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (757, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (758, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (759, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (760, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (761, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (762, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (763, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (764, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (765, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (766, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (767, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (768, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (769, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (770, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (771, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (772, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (773, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (774, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (775, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (776, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (777, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (778, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (779, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (780, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (781, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (782, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (783, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (784, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (785, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (786, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (787, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (788, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (789, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 14)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2137, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2138, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2139, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2140, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2141, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2142, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2143, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2144, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2145, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2146, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2147, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2148, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2149, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2150, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2151, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2152, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2153, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2154, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2155, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2156, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2157, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2158, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2159, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2160, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2161, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2162, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2163, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2164, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2165, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2166, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2167, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2168, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2169, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2170, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2171, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2172, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2173, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2174, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2175, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 37)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2176, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2177, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2178, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2179, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2180, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2181, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2182, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2183, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2184, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2185, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2186, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2187, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2188, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2189, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2190, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2191, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2192, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2193, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2194, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2195, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2196, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2197, 2017, 2112, 1920, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2198, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2199, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2200, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2201, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2202, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2203, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2204, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2205, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2206, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2207, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2208, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2209, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2210, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2211, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2212, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2213, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2214, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2215, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2216, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2217, 2017, 2112, 1920, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2218, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2219, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2220, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2221, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2222, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2223, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2224, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2225, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2226, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2227, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2228, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2229, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2230, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2231, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2232, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2233, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2234, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2235, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2236, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2237, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2238, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2239, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2240, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2241, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2242, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2243, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2244, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2245, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2246, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2247, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2248, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2249, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2250, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2251, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2252, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2253, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2254, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2255, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2256, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2257, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2258, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2259, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2260, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2261, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2262, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2263, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2264, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2265, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2266, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2267, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2268, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2269, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2270, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2271, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2272, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2273, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2274, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2275, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 38)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2276, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2277, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2278, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2279, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2280, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2281, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2282, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2283, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2284, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2285, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2286, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2287, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2288, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2289, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2290, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2291, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2292, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2293, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2294, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2295, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2296, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 38)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2297, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2298, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2299, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2300, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2301, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2302, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2303, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2304, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2305, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2306, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2307, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2308, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2309, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2310, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2311, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2312, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2313, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2314, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2315, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2316, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2317, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2318, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2319, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2320, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2321, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2322, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2323, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2324, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2325, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2326, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2327, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2328, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2329, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2330, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2331, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2332, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2333, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2334, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2335, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2336, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2337, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2338, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2339, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2340, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2341, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2342, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2343, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2344, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2345, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2346, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2347, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2348, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2349, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2350, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2351, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2352, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2353, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2354, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2355, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2356, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 39)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2357, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2358, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2359, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2360, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2361, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2362, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2363, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2364, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2365, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2366, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2367, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2368, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2369, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2370, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2371, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2372, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2373, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2374, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2375, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 40)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2376, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2377, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2378, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2379, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2380, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2381, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2382, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2383, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2384, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2385, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2386, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2387, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2388, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2389, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2390, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2391, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2392, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2393, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2394, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2395, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2396, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2397, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2398, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2399, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2400, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2401, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2402, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2403, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2404, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2405, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2406, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2407, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2408, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2409, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2410, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2411, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2412, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2413, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2414, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2415, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2416, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 40)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2497, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2498, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2499, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2500, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2501, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2502, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2503, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2504, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2505, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2506, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2507, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2508, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2509, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2510, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2511, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2512, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2513, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2514, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2515, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2516, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2517, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2518, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2519, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2520, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2521, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2522, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2523, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2524, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2525, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2526, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2527, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2528, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2529, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2530, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2531, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2532, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2533, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2534, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2535, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2536, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2537, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2538, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2539, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2540, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2541, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2542, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2543, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2544, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2545, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2546, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2547, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2548, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2549, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2550, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2551, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2552, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2553, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2554, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2555, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 42)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (2556, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 42)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3177, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3178, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3179, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3180, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3181, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3182, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3183, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3184, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3185, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3186, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3187, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3188, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3189, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3190, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3191, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3192, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3193, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3194, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3195, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3196, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3197, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3198, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3199, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3200, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3201, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3202, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3203, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3204, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3205, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3206, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3207, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3208, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3209, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3210, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3211, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3212, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3213, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3214, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3215, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3216, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3217, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3218, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3219, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3220, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3221, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3222, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3223, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3224, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3225, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3226, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3227, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3228, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3229, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3230, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3231, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3232, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3233, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3234, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3235, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3236, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 53)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3237, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3238, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3239, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3240, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3241, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3242, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3243, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3244, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3245, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3246, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3247, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3248, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3249, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3250, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3251, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3252, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3253, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3254, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3255, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3256, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3257, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3258, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3259, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3260, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3261, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3262, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3263, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3264, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3265, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3266, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3267, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3268, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3269, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3270, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3271, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3272, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3273, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3274, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3275, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 54)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3276, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3277, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3278, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3279, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3280, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3281, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3282, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3283, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3284, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3285, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3286, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3287, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3288, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3289, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3290, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3291, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3292, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3293, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3294, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3295, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3296, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 54)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3357, 2017, 2112, 1920, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3358, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3359, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3360, 2017, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3361, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3362, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3363, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3364, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3365, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3366, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3367, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3368, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3369, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3370, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3371, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3372, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3373, 2018, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3374, 2018, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3375, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3376, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3377, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3378, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3379, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3380, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3381, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3382, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3383, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3384, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3385, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3386, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3387, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3388, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3389, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3390, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3391, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3392, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3393, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3394, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3395, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3396, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3397, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3398, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3399, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3400, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3401, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3402, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3403, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3404, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3405, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3406, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3407, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3408, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3409, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3410, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3411, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3412, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3413, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3414, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3415, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3416, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3417, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3418, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3419, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3420, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3421, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3422, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3423, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3424, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3425, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3426, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3427, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3428, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3429, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3430, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3431, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3432, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3433, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3434, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3435, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 56)
GO
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3436, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 56)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3807, 2017, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3808, 2017, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3809, 2017, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3810, 2017, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3811, 2017, 54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3812, 2017, 64, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3813, 2017, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3814, 2017, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3815, 2017, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3816, 2017, 74, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3817, 2017, 84, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3818, 2017, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3819, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3820, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3821, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3822, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3823, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3824, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3825, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3826, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3827, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3828, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3829, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3830, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3831, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3832, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3833, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3834, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3835, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3836, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3837, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3838, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3839, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3840, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3841, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3842, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3843, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3844, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3845, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3846, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3847, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3848, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3849, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3850, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3851, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3852, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3853, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3854, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3855, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 30, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3856, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 31, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3857, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 32, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3858, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3859, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 34, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3860, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3861, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 27, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3862, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3863, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3864, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 36, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3865, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (3866, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 37, 62)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5237, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5238, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5239, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5240, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5241, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5242, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5243, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5244, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5245, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5246, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5247, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5248, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5249, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5250, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLCostRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (5251, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLCostRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (37, 2017, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (38, 2017, 2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (39, 2017, 3, 3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (40, 2017, 4, 4, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (41, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (42, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (43, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (44, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (45, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (46, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (47, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (48, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (49, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (50, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (51, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (52, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (53, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (54, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (55, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (56, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (57, 2017, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (58, 2017, 2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (59, 2017, 3, 3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (60, 2017, 4, 4, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (61, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (62, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (63, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (64, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (65, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (66, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (67, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (68, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (69, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (70, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (71, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (72, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (73, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (74, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (75, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (76, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (117, 2017, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (118, 2017, 2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (119, 2017, 3, 3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (120, 2017, 4, 4, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (121, 2018, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (122, 2018, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (123, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (124, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (125, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (126, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (127, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (128, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (129, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (130, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (131, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (132, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (133, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (134, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (135, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (136, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (192, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (193, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (194, 2017, 31, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (195, 2018, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (196, 2018, 32, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (197, 2018, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (198, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (199, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (200, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (201, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (202, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (203, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (204, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (205, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61)
INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id]) VALUES (206, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLHeadCountRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (41, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (42, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (43, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (44, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (45, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (46, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (47, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (48, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (49, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (50, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (51, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (52, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (53, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (54, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (55, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (56, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (57, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (58, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (59, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (60, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 37, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (61, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (62, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (63, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (64, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (65, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (66, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (67, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (68, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (69, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (70, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (71, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (72, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (73, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (74, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (75, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (76, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (77, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (78, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (79, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (80, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 38, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (121, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (122, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (123, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (124, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (125, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (126, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (127, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (128, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (129, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (130, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (131, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (132, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (133, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (134, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (135, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (136, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (137, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (138, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (139, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (140, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 56, 1)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (196, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 2, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (197, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 3, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (198, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 4, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (199, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 2, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (200, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 3, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (201, 2018, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (202, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (203, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (204, 2019, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (205, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (206, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (207, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (208, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (209, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 61, 2)
INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id], [ADLRecord_Id], [VersionNo]) VALUES (210, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 61, 2)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLHourRatioRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (11, 2017, 2, N'123', CAST(0x0000A7270011907C AS DateTime), N'admin', 37, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (12, 2017, 2, N'AAAD', CAST(0x0000A72700119B08 AS DateTime), N'admin', 37, N'Head_Mockup')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (13, 2017, 2, N'EEEE', CAST(0x0000A7270016BA5C AS DateTime), N'admin', 39, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (14, 2017, 2, N'EEEE', CAST(0x0000A7270016BDE0 AS DateTime), N'admin', 39, N'Head_Mockup')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (15, 2017, 2, N'123', CAST(0x0000A7270018CF90 AS DateTime), N'admin', 38, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (16, 2017, 2, N'1234', CAST(0x0000A7270018D440 AS DateTime), N'admin', 38, N'Head_Mockup')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (17, 2017, 2, N'12344', CAST(0x0000A727001945EC AS DateTime), N'admin', 42, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (18, 2017, 2, N'12344', CAST(0x0000A727001F12B0 AS DateTime), N'admin', 53, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (19, 2017, 2, N'12344', CAST(0x0000A727001F2DA4 AS DateTime), N'admin', 54, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (21, 2017, 2, N'123', CAST(0x0000A727004C1238 AS DateTime), N'admin', 56, N'Head_StartDate')
INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] ([Id], [Year], [Month], [Content], [CreateTime], [Creator], [ADLRecord_Id], [Name]) VALUES (22, 2017, 2, N'1234', CAST(0x0000A727004C1238 AS DateTime), N'admin', 56, N'Head_Mockup')
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLKickOffRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (37, N'TEST0001', 1, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A71400000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A71400000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Creating', N'N/A', N'N/A', NULL, N'N/A', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'admin', CAST(0x0000A72700117C90 AS DateTime), N'admin', CAST(0x0000A72700146CE8 AS DateTime), N'SA7064', NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (38, N'TEST0001', 2, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A71400000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A71400000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A7270018F18C AS DateTime), NULL, NULL, NULL, 0, N'admin', CAST(0x0000A72700146CE8 AS DateTime), N'admin', CAST(0x0000A727004C1238 AS DateTime), N'SA7064', NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (39, N'TEST0002', 1, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A7270016F74C AS DateTime), NULL, NULL, NULL, 0, N'admin', CAST(0x0000A7270016B0FC AS DateTime), N'admin', CAST(0x0000A72700170430 AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (40, N'TEST0002', 2, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A72700170430 AS DateTime), NULL, N'admin', CAST(0x0000A727001928A0 AS DateTime), 0, N'admin', CAST(0x0000A72700170430 AS DateTime), N'admin', CAST(0x0000A72700193458 AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (42, N'TEST0002', 3, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A72700197274 AS DateTime), NULL, N'admin', CAST(0x0000A72700197F58 AS DateTime), 0, N'admin', CAST(0x0000A72700193458 AS DateTime), N'admin', CAST(0x0000A727001F1184 AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (53, N'TEST0002', 4, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A727001F12B0 AS DateTime), NULL, NULL, NULL, 0, N'admin', CAST(0x0000A727001F12B0 AS DateTime), N'admin', CAST(0x0000A727001F2DA4 AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (54, N'TEST0002', 5, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A70D00000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A727001F2DA4 AS DateTime), NULL, N'admin', CAST(0x0000A727001F4640 AS DateTime), 0, N'admin', CAST(0x0000A727001F2DA4 AS DateTime), N'admin', CAST(0x0000A727001F51F8 AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (56, N'TEST0001', 3, N'TEST', N'TEST', N'RMB', N'TESTER', N'TESTER', N'Program phase', CAST(0x0000A71400000000 AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A71400000000 AS DateTime), NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Frozen', N'Quotation', N'N/A', N'N/A', NULL, N'N/A', NULL, N'admin', CAST(0x0000A72D00F15798 AS DateTime), NULL, NULL, NULL, 0, N'admin', CAST(0x0000A727004C1238 AS DateTime), N'admin', CAST(0x0000A72D00F1692C AS DateTime), N'SA7064', NULL, NULL, NULL, NULL)
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (61, N'10001', 1, N'1', N'test', N'RMB', N'test', N'test', N'Program phase', CAST(0x0000A72900000000 AS DateTime), CAST(0x0000A77200000000 AS DateTime), CAST(0x0000A7CC00000000 AS DateTime), CAST(0x0000A74800000000 AS DateTime), CAST(0x0000A8C000000000 AS DateTime), CAST(0x0000A74D00000000 AS DateTime), CAST(0x0000A78600000000 AS DateTime), NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', NULL, N'N/A', N'Inwork', N'Creating', N'N/A', N'N/A', NULL, N'N/A', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'admin', CAST(0x0000A730002C7FCC AS DateTime), N'admin', CAST(0x0000A7350133704C AS DateTime), N'SA7067', CAST(0x0000A7A800000000 AS DateTime), CAST(0x0000A7EE00000000 AS DateTime), CAST(0x0000A80A00000000 AS DateTime), CAST(0x0000A8A400000000 AS DateTime))
INSERT [dbo].[Faurecia_ADL_ADLRecord] ([Id], [ProjectNo], [VersionNo], [Name], [Customer], [Currency], [ProgramManager], [ProgramController], [Type], [StartDate], [OfferDate], [ProtoDate], [PTRDate], [SOPDate], [MockUp], [Award], [MileStoneComments], [Variant1], [Variant2], [Variant3], [FrameMaturity], [VehicelComments], [Tracks], [Status], [Phase], [Recliner], [HA], [Ballfix], [KEZE], [QuotationComments], [Quotation], [QuotationTime], [IBPComments], [IBP], [IBPTime], [IsLastest], [Creator], [CreateTime], [Editor], [EditTime], [WBSID], [ProgramKickOff], [DV], [ToolingKickOff], [PV]) VALUES (62, N'20001', 1, N'2', N'test2', N'RMB', N'test', N'tester', N'Program phase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1st Row', N'2nd Row', N'3rd Row', N'New', N'由于时间关系，展现层没有在本文中介绍，将放到以后的文章介绍。后续文章中也将会详细介绍每一层的具体知识要点。

如果想立即看到更多展示，可以查看我以前的文章《新思想、新技术、新架构——更好更快的开发现代ASP.NET应用程序（续1）》，比较完整的演示了一个简单模块的开发，包括前后端各层的代码。（我自己项目用的ABP框架是在原作者的基础上做了一些修改，所以有些地方可能跟原作者的ABP不完全相同。）

 

由于演示一个完整的开发流程工作量巨大，写文章很难说得清楚，忙过这段时间我会准备用视频或YY在线的方式来分享，到时也可以分享我使用VS2013的Scaffolder+T4开发的代码生成器。', N'N/A', N'Inwork', N'Creating', N'N/A', N'N/A', NULL, N'N/A', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'admin', CAST(0x0000A730002EE5DC AS DateTime), N'admin', CAST(0x0000A73600A682F4 AS DateTime), N'SA7067', CAST(0x0000A73000000000 AS DateTime), NULL, CAST(0x0000A78300000000 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ON 

INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (66, 2017, 22, 23, 21, 22, 23, 24, 24, 21, 23, 14, 15, 17, 14)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (67, 2018, 21, 23, 11, 12, 13, 14, 15, 17, 19, 10, 21, 22, 14)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (68, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (69, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (70, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (181, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 37)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (182, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 37)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (183, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 37)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (184, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 37)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (185, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 37)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (186, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 38)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (187, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 38)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (188, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 38)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (189, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 38)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (190, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 38)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (191, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 39)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (192, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 39)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (193, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 39)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (194, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 39)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (195, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 39)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (196, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 40)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (197, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 40)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (198, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 40)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (199, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 40)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (200, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 40)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (206, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 42)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (207, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 42)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (208, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 42)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (209, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 42)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (210, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 42)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (261, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 53)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (262, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 53)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (263, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 53)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (264, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 53)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (265, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 53)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (266, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 54)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (267, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 54)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (268, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 54)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (269, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 54)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (270, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 54)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (276, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 56)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (277, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 56)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (278, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 56)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (279, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 56)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (280, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 56)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (301, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 61)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (302, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 61)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (303, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 61)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (304, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 61)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (305, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 61)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (306, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 62)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (307, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 62)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (308, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 62)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (309, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 62)
INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ADLRecord_Id]) VALUES (310, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 62)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_ADLWorkingHourRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ON 

INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (1, 2017, 120, 12, 123, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(0x0000A64A00000000 AS DateTime), NULL, CAST(0x0000A72700563268 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (5, 2017, 120, 12, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(0x0000A7270055FED8 AS DateTime), N'admin', CAST(0x0000A728000263B8 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (6, 2018, 120, 12, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(0x0000A7270056106C AS DateTime), N'admin', CAST(0x0000A72800026E44 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (7, 2019, 120, 12, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(0x0000A7270056151C AS DateTime), N'admin', CAST(0x0000A728000271C8 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (8, 2017, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A728000263B8 AS DateTime), N'admin', CAST(0x0000A72800026868 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (9, 2017, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A72800026868 AS DateTime), N'admin', CAST(0x0000A7280003564C AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (10, 2018, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A72800026E44 AS DateTime), N'admin', CAST(0x0000A728000359D0 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (11, 2019, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A728000271C8 AS DateTime), N'admin', CAST(0x0000A72800035C28 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (12, 2020, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A728000277A4 AS DateTime), N'admin', CAST(0x0000A72800035D54 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (13, 2017, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 0, CAST(0x0000A7280003564C AS DateTime), N'admin', CAST(0x0000A728000360D8 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (14, 2018, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 1, CAST(0x0000A728000359D0 AS DateTime), N'admin', CAST(0x0000A728000359D0 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (15, 2019, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 1, CAST(0x0000A72800035C28 AS DateTime), N'admin', CAST(0x0000A72800035C28 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (16, 2020, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 1, CAST(0x0000A72800035D54 AS DateTime), N'admin', CAST(0x0000A72800035D54 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (17, 2017, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 0, CAST(0x0000A728000360D8 AS DateTime), N'admin', CAST(0x0000A72D00EEAC64 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (1014, 2017, 1, 2, 3, 4, 5, 8, 6, 7, 9, 10, 11, 12, 1, CAST(0x0000A72D00EEAC64 AS DateTime), N'admin', CAST(0x0000A72D00EEAC64 AS DateTime), N'admin')
INSERT [dbo].[Faurecia_ADL_HeadCountRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (1015, 2021, 120, 120, 120, 120, 120, 120, 0, 120, 120, 120, 120, 120, 0, CAST(0x0000A72D00EEDEC8 AS DateTime), N'admin', CAST(0x0000A72D00EF1E10 AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_HeadCountRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ON 

INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (1, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (2, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (3, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (124, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (125, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (126, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (127, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (128, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (129, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (130, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (131, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (132, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (133, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (154, 2017, 123, 123, 123, 123, 123, 123, 123, 123, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (155, 2018, 123, 123, 123, 123, 123, 123, 123, 123, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (156, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (157, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (158, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (159, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (160, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (161, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (162, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (163, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (164, 2017, 12, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (165, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (166, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (167, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (168, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (169, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (170, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (171, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (172, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (173, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (174, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (175, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (176, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (177, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (178, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (179, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (180, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (181, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (182, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (183, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (184, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (185, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (186, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (187, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (188, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (189, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (190, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (191, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (192, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (193, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (194, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (195, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (196, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (197, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (198, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (199, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (200, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (201, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (202, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (203, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (204, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (205, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (206, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (207, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (208, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (209, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (210, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (211, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (212, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (213, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (214, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (215, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (216, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (217, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (218, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (219, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (220, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (221, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (222, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (223, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (224, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (225, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (226, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (227, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (228, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (229, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (230, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (231, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (232, 2018, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (233, 2019, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (234, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (235, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (236, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (237, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (238, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (239, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
GO
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (240, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (241, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (242, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (243, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (244, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (245, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (246, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (247, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (248, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (249, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (250, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (251, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (252, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (253, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (254, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (255, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (256, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (257, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (258, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (259, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (260, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (261, 2014, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (262, 2015, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (263, 2016, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (264, 2017, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (265, 2018, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (266, 2019, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (267, 2020, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (268, 2021, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (269, 2022, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (270, 2023, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (271, 2024, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (272, 2025, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (273, 2026, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (274, 2027, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (275, 2028, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (276, 2029, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (277, 2030, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (278, 2031, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (279, 2032, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (280, 2033, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 52)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (281, 2014, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (282, 2015, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (283, 2016, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (284, 2017, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (285, 2018, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (286, 2019, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (287, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (288, 2021, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (289, 2022, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (290, 2023, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (291, 2024, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (292, 2025, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (293, 2026, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (294, 2027, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (295, 2028, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (296, 2029, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (297, 2030, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (298, 2031, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (299, 2032, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (300, 2033, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 53)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (301, 2014, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (302, 2015, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (303, 2016, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (304, 2017, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (305, 2018, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (306, 2019, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (307, 2020, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (308, 2021, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (309, 2022, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (310, 2023, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (311, 2024, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (312, 2025, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (313, 2026, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (314, 2027, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (315, 2028, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (316, 2029, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (317, 2030, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (318, 2031, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (319, 2032, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (320, 2033, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 54)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (321, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (322, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (323, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (324, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (325, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (326, 2019, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (327, 2020, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (328, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (329, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (330, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (331, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (332, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (333, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (334, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (335, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (336, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (337, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (338, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (339, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
GO
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (340, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 55)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (341, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (342, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (343, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (344, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (345, 2018, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (346, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (347, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (348, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (349, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (350, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (351, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (352, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (353, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (354, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (355, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (356, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (357, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (358, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (359, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (360, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 56)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (361, 2014, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (362, 2015, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (363, 2016, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (364, 2017, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (365, 2018, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (366, 2019, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (367, 2020, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (368, 2021, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (369, 2022, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (370, 2023, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (371, 2024, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (372, 2025, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (373, 2026, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (374, 2027, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (375, 2028, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (376, 2029, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (377, 2030, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (378, 2031, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (379, 2032, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (380, 2033, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 57)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (381, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (382, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (383, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (384, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (385, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (386, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (387, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (388, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (389, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (390, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (391, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (392, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (393, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (394, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (395, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (396, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (397, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (398, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (399, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (400, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (401, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (402, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (403, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (404, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (405, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (406, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (407, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (408, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (409, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (410, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (411, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (412, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (413, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (414, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (415, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (416, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (417, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (418, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (419, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (420, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 59)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (421, 2017, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (422, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (423, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (424, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (425, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (426, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (427, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (428, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (429, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (430, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (431, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (432, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (433, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (434, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (435, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (436, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (437, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (438, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (439, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
GO
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (440, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (441, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (442, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (443, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (444, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (445, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (446, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (447, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (448, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (449, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (450, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 61)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (451, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (452, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (453, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (454, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (455, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (456, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (457, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (458, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (459, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (460, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (461, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (462, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (463, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (464, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (465, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (466, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (467, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (468, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (469, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (470, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (471, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (472, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (473, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (474, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (475, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (476, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (477, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (478, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (479, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (480, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (481, 2017, 12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (482, 2018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (483, 2019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (484, 2020, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (485, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (486, 2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (487, 2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (488, 2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (489, 2025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (490, 2026, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 63)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (491, 2014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (492, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (493, 2016, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (494, 2027, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (495, 2028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (496, 2029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (497, 2030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (498, 2031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (499, 2032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[Faurecia_ADL_HourRatioRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [ActivityTypeRecord_Id]) VALUES (500, 2033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4)
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_HourRatioRecord] OFF
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ON 

INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (30, 2017, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (31, 2018, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (32, 2019, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (33, 2020, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (34, 2021, 176, 160, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (36, 2023, 176, 169, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (37, 2024, 176, 169, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] ([Id], [Year], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dev], [IsUsed], [CreateTime], [Creator], [EditTime], [Editor]) VALUES (42, 2025, 176, 169, 176, 168, 176, 168, 176, 176, 168, 176, 168, 176, 1, CAST(0x0000A72500000000 AS DateTime), N'', CAST(0x0000A72500000000 AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[Faurecia_ADL_WorkingHourRecord] OFF
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (9, N'', NULL, 0)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (10, N'Home', N'1', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (12, N'Base', N'1', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (13, N'Maintain hour rate baseline', N'1.2', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (14, N'Maintain working hour', N'1.3', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (15, N'Users & Roles', N'1.1', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (16, N'Workflow', N'2', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (17, N'Budget Home', N'2.1', 8)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (18, NULL, NULL, 0)
INSERT [dbo].[Navigation_MenuPartRecord] ([Id], [MenuText], [MenuPosition], [MenuId]) VALUES (19, N'Maintain head count', N'1.4', 8)
SET IDENTITY_INSERT [dbo].[Orchard_Alias_ActionRecord] ON 

INSERT [dbo].[Orchard_Alias_ActionRecord] ([Id], [Area], [Controller], [Action]) VALUES (1, N'Contents', N'Item', N'Display')
SET IDENTITY_INSERT [dbo].[Orchard_Alias_ActionRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Alias_AliasRecord] ON 

INSERT [dbo].[Orchard_Alias_AliasRecord] ([Id], [Path], [Action_id], [RouteValues], [Source], [IsManaged]) VALUES (4, N'home-page', 1, N'<v Id="18" />', N'Autoroute:View', 1)
INSERT [dbo].[Orchard_Alias_AliasRecord] ([Id], [Path], [Action_id], [RouteValues], [Source], [IsManaged]) VALUES (5, N'', 1, N'<v Id="18" />', N'Autoroute:Home', 0)
SET IDENTITY_INSERT [dbo].[Orchard_Alias_AliasRecord] OFF
INSERT [dbo].[Orchard_Autoroute_AutoroutePartRecord] ([Id], [ContentItemRecord_id], [CustomPattern], [UseCustomPattern], [UseCulturePattern], [DisplayAlias]) VALUES (9, 9, NULL, 0, 0, N'welcome-to-orchard')
INSERT [dbo].[Orchard_Autoroute_AutoroutePartRecord] ([Id], [ContentItemRecord_id], [CustomPattern], [UseCustomPattern], [UseCulturePattern], [DisplayAlias]) VALUES (18, 18, NULL, 0, 0, N'home-page')
INSERT [dbo].[Orchard_Autoroute_AutoroutePartRecord] ([Id], [ContentItemRecord_id], [CustomPattern], [UseCustomPattern], [UseCulturePattern], [DisplayAlias]) VALUES (19, 18, NULL, 0, 0, N'home-page')
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentItemRecord] ON 

INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (1, N'<Data><SiteSettingsPart SiteSalt="c23b6b1cda9a45ea9d8de31d581ee18f" SiteName="Faurecia BM" PageTitleSeparator=" - " SiteTimeZone="China Standard Time" SuperUser="admin" SiteCulture="en-US" BaseUrl="http://localhost:30321" /><ThemeSiteSettingsPart CurrentThemeName="Faurecia.BM" /><BootstrapThemeSettingsPart Swatch="default" UseFluidLayout="true" UseFixedNav="true" UseInverseNav="false" UseNavSearch="false" UseHoverMenus="false" UseStickyFooter="false" /></Data>', 2)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (2, N'<Data><UserPart UserName="admin" Email="" NormalizedUserName="admin" HashAlgorithm="PBKDF2" CreatedUtc="2016-12-30T05:00:09.0091634Z" PasswordFormat="Hashed" Password="AIItX4NB0WZV4WbVmP/2J7iZbwc2bddNoukjbG4cTWBCz43zNFdpmVaOxwxQHjIHXg==" PasswordSalt="oXDA3zgFCmaImriODIQNLw==" LastPasswordChangeUtc="2016-12-30T05:00:09.073167Z" RegistrationStatus="Approved" EmailStatus="Approved" LastLogoutUtc="2017-01-11T15:11:19.7738185Z" LastLoginUtc="2017-03-14T04:56:38.3499573Z" /></Data>', 3)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (3, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:18.164687Z" ModifiedUtc="2016-12-30T05:00:18.164687Z" PublishedUtc="2016-12-30T05:00:18.3927001Z" /><LayerPart Name="Default" LayerRule="true" Description="The widgets in this layer are displayed on all pages" /></Data>', 4)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (4, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:18.7037179Z" ModifiedUtc="2016-12-30T05:00:18.7037179Z" PublishedUtc="2016-12-30T05:00:18.7377198Z" /><LayerPart Name="Authenticated" LayerRule="authenticated" Description="The widgets in this layer are displayed when the user is authenticated" /></Data>', 4)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (5, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:18.8737276Z" ModifiedUtc="2016-12-30T05:00:18.8737276Z" PublishedUtc="2016-12-30T05:00:18.9707332Z" /><LayerPart Name="Anonymous" LayerRule="not authenticated" Description="The widgets in this layer are displayed when the user is anonymous" /></Data>', 4)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (6, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:19.3247534Z" ModifiedUtc="2016-12-30T05:00:19.3247534Z" PublishedUtc="2016-12-30T05:00:19.3617555Z" /><LayerPart Name="Disabled" LayerRule="false" Description="The widgets in this layer are never displayed" /></Data>', 4)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (7, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:19.4467604Z" ModifiedUtc="2016-12-30T05:00:19.4467604Z" PublishedUtc="2016-12-30T05:00:19.4627613Z" /><LayerPart Name="TheHomepage" LayerRule="url ''~/''" Description="The widgets in this layer are displayed on the home page" /></Data>', 4)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (8, N'<Data><IdentityPart Identifier="2adb01dc436644a4b4667cda3ff9b513" /><CommonPart CreatedUtc="2016-12-30T05:00:19.7307766Z" ModifiedUtc="2016-12-30T05:00:19.7307766Z" PublishedUtc="2016-12-30T05:00:19.7817795Z" /></Data>', 1)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (9, N'<Data><CommonPart CreatedUtc="2016-12-30T05:00:20.2468061Z" ModifiedUtc="2016-12-30T05:01:44.0446211Z" PublishedUtc="2016-12-30T05:00:20.2468061Z" /><TagsPart CurrentTags="" /></Data>', 5)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (10, N'<Data><IdentityPart Identifier="ccd1f156d4374a58af22b624cdb3f9f3" /><CommonPart CreatedUtc="2016-12-30T05:00:21.1728591Z" ModifiedUtc="2017-01-02T15:49:24.7498446Z" PublishedUtc="2016-12-30T05:00:21.2388629Z" /><MenuItemPart Url="~/" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (11, N'<Data><IdentityPart Identifier="MenuWidget1" /><CommonPart CreatedUtc="2016-12-30T05:00:21.36387Z" ModifiedUtc="2016-12-30T05:00:21.36387Z" PublishedUtc="2016-12-30T05:00:21.4718762Z" /><WidgetPart RenderTitle="false" Title="Main Menu" Position="1" Zone="Navigation" Name="" /><MenuWidgetPart StartLevel="1" MenuContentItemId="8" /></Data>', 7)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (12, N'<Data><IdentityPart Identifier="ae1b7df5e8c14a089bab56c4e94bf122" /><CommonPart CreatedUtc="2017-01-02T15:42:57.3983802Z" ModifiedUtc="2017-01-02T15:42:57.5313878Z" PublishedUtc="2017-01-02T15:42:57.6233931Z" /><MenuItemPart Url="#" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (13, N'<Data><IdentityPart Identifier="ff5ce931527c4dd8baac9e7891313f11" /><CommonPart CreatedUtc="2017-01-02T15:43:32.819034Z" ModifiedUtc="2017-02-25T09:51:20.4606626Z" PublishedUtc="2017-02-25T09:51:20.4636642Z" /><MenuItemPart Url="~/ADL/ActivityType" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (14, N'<Data><IdentityPart Identifier="576410e5ee4b423f98ec9e8b36a2a467" /><CommonPart CreatedUtc="2017-01-02T15:44:18.9573564Z" ModifiedUtc="2017-02-25T09:51:34.7057313Z" PublishedUtc="2017-02-25T09:51:34.7097337Z" /><MenuItemPart Url="~/ADL/WorkingHour" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (15, N'<Data><IdentityPart Identifier="4f50d9b5091f4acd99dec607ab48a971" /><CommonPart CreatedUtc="2017-01-02T15:44:53.8329235Z" ModifiedUtc="2017-01-11T02:52:33.1649685Z" PublishedUtc="2017-01-11T02:52:33.1719734Z" /><MenuItemPart Url="~/ADL/UserRole" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (16, N'<Data><IdentityPart Identifier="a89b1c566b0b40db9aab2820e7eacf45" /><CommonPart CreatedUtc="2017-01-02T15:45:24.769144Z" ModifiedUtc="2017-01-02T15:45:24.7771445Z" PublishedUtc="2017-01-02T15:45:24.7921453Z" /><MenuItemPart Url="#" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (17, N'<Data><IdentityPart Identifier="4c1328d61035454191aea29b4ddf742f" /><CommonPart CreatedUtc="2017-01-02T15:45:40.2945038Z" ModifiedUtc="2017-02-25T09:43:21.1800502Z" PublishedUtc="2017-02-25T09:43:21.1890533Z" /><MenuItemPart Url="~/ADL" /></Data>', 6)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (18, N'<Data><CommonPart CreatedUtc="2017-01-03T02:49:00Z" ModifiedUtc="2017-01-03T02:50:15.6190332Z" PublishedUtc="2017-01-03T02:50:15.6310417Z" /><AutoroutePart PromoteToHomePage="true" /><LayoutPart SessionKey="981a6d6d-6f08-4d1f-bb35-49fa6c91f515" /><TagsPart CurrentTags="" /></Data>', 5)
INSERT [dbo].[Orchard_Framework_ContentItemRecord] ([Id], [Data], [ContentType_id]) VALUES (19, N'<Data><IdentityPart Identifier="a017f5aca70c46679f0c2d8636484592" /><CommonPart CreatedUtc="2017-02-26T21:14:45.7524525Z" ModifiedUtc="2017-02-26T21:14:45.8155009Z" PublishedUtc="2017-02-26T21:14:45.8915357Z" /><MenuItemPart Url="~/ADL/HeadCount" /></Data>', 6)
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentItemRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ON 

INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (1, 1, 1, 1, NULL, 1)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (2, 1, 1, 1, NULL, 2)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (3, 1, 1, 1, NULL, 3)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (4, 1, 1, 1, NULL, 4)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (5, 1, 1, 1, NULL, 5)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (6, 1, 1, 1, NULL, 6)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (7, 1, 1, 1, NULL, 7)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (8, 1, 1, 1, N'<Data><TitlePart Title="Main Menu" /></Data>', 8)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (9, 1, 0, 0, N'<Data><TitlePart Title="Welcome to Orchard!" /><AutoroutePart DisplayAlias="welcome-to-orchard" UseCustomPattern="false" /><LayoutPart LayoutData="{&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Canvas&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Grid&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Row&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;: &quot;Width=12&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Html&quot;,&quot;data&quot;: &quot;Content=%3cp%3eYou%27ve+successfully+setup+your+Orchard+Site+and+this+is+the+homepage+of+your+new+site.%0aHere+are+a+few+things+you+can+look+at+to+get+familiar+with+the+application.%0aOnce+you+feel+confident+you+don%27t+need+this+anymore%2c+you+can%0a%3ca+href%3d%22Admin%2fContents%2fEdit%2f9%22%3eremove+it+by+going+into+editing+mode%3c%2fa%3e%0aand+replacing+it+with+whatever+you+want.%3c%2fp%3e%0a%3cp%3eFirst+things+first+-+You%27ll+probably+want+to+%3ca+href%3d%22Admin%2fSettings%22%3emanage+your+settings%3c%2fa%3e%0aand+configure+Orchard+to+your+liking.+After+that%2c+you+can+head+over+to%0a%3ca+href%3d%22Admin%2fThemes%22%3emanage+themes+to+change+or+install+new+themes%3c%2fa%3e%0aand+really+make+it+your+own.+Once+you%27re+happy+with+a+look+and+feel%2c+it%27s+time+for+some+content.%0aYou+can+start+creating+new+custom+content+types+or+start+from+the+built-in+ones+by%0a%3ca+href%3d%22Admin%2fContents%2fCreate%2fPage%22%3eadding+a+page%3c%2fa%3e%2c+or+%3ca+href%3d%22Admin%2fNavigation%22%3emanaging+your+menus.%3c%2fa%3e%3c%2fp%3e%0a%3cp%3eFinally%2c+Orchard+has+been+designed+to+be+extended.+It+comes+with+a+few+built-in%0amodules+such+as+pages+and+blogs+or+themes.+If+you%27re+looking+to+add+additional+functionality%2c%0ayou+can+do+so+by+creating+your+own+module+or+by+installing+one+that+somebody+else+built.%0aModules+are+created+by+other+users+of+Orchard+just+like+you+so+if+you+feel+up+to+it%2c%0a%3ca+href%3d%22http%3a%2f%2forchardproject.net%2fcontribution%22%3eplease+consider+participating%3c%2fa%3e.%3c%2fp%3e%0a%3cp%3eThanks+for+using+Orchard+%e2%80%93+The+Orchard+Team+%3c%2fp%3e&quot;}]}]},{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Row&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;: &quot;Width=4&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Html&quot;,&quot;data&quot;: &quot;Content=%3ch2%3eFirst+Leader+Aside%3c%2fh2%3e%0a%3cp%3eLorem+ipsum+dolor+sit+amet%2c+consectetur+adipiscing+elit.+Curabitur+a+nibh+ut+tortor+dapibus+vestibulum.%0aAliquam+vel+sem+nibh.+Suspendisse+vel+condimentum+tellus.%3c%2fp%3e&quot;}]},{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;: &quot;Width=4&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Html&quot;,&quot;data&quot;: &quot;Content=%3ch2%3eSecond+Leader+Aside%3c%2fh2%3e%0a%3cp%3eLorem+ipsum+dolor+sit+amet%2c+consectetur+adipiscing+elit.+Curabitur+a+nibh+ut+tortor+dapibus+vestibulum.%0aAliquam+vel+sem+nibh.+Suspendisse+vel+condimentum+tellus.%3c%2fp%3e&quot;}]},{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;: &quot;Width=4&quot;,&quot;elements&quot;: [{&quot;typeName&quot;: &quot;Orchard.Layouts.Elements.Html&quot;,&quot;data&quot;: &quot;Content=%3ch2%3eThird+Leader+Aside%3c%2fh2%3e%0a%3cp%3eLorem+ipsum+dolor+sit+amet%2c+consectetur+adipiscing+elit.+Curabitur+a+nibh+ut+tortor+dapibus+vestibulum.%0aAliquam+vel+sem+nibh.+Suspendisse+vel+condimentum+tellus.%3c%2fp%3e&quot;}]}]}]}]}]}" /></Data>', 9)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (10, 1, 0, 0, NULL, 10)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (11, 1, 1, 1, NULL, 11)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (12, 1, 1, 1, NULL, 12)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (13, 1, 0, 0, NULL, 13)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (14, 1, 0, 0, NULL, 14)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (15, 1, 0, 0, NULL, 15)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (16, 1, 1, 1, NULL, 16)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (17, 1, 0, 0, NULL, 17)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (18, 1, 0, 0, N'<Data><AutoroutePart DisplayAlias="home-page" UseCustomPattern="false" /><TitlePart Title="Home Page" /><LayoutPart TemplateId="null" LayoutData="{&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Canvas&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Grid&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Row&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;:&quot;Width=12&amp;Offset=0&amp;Collapsible=null&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}]}" /></Data>', 18)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (19, 2, 1, 1, N'<Data><AutoroutePart DisplayAlias="home-page" UseCustomPattern="false" /><TitlePart Title="Welcome" /><LayoutPart TemplateId="null" LayoutData="{&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Canvas&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Grid&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Row&quot;,&quot;data&quot;:&quot;&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[{&quot;typeName&quot;:&quot;Orchard.Layouts.Elements.Column&quot;,&quot;data&quot;:&quot;Width=12&amp;Offset=0&amp;Collapsible=null&quot;,&quot;exportableData&quot;:&quot;&quot;,&quot;index&quot;:0,&quot;elements&quot;:[],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}],&quot;isTemplated&quot;:false,&quot;htmlId&quot;:&quot;&quot;,&quot;htmlClass&quot;:&quot;&quot;,&quot;htmlStyle&quot;:&quot;&quot;,&quot;rule&quot;:&quot;&quot;}]}" /></Data>', 18)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (20, 2, 1, 1, NULL, 15)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (21, 2, 0, 0, NULL, 13)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (22, 2, 1, 1, NULL, 17)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (23, 3, 0, 0, NULL, 13)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (24, 4, 1, 1, NULL, 13)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (25, 2, 1, 1, NULL, 14)
INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] ([Id], [Number], [Published], [Latest], [Data], [ContentItemRecord_id]) VALUES (26, 1, 1, 1, NULL, 19)
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentItemVersionRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ON 

INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (8, N'Blog')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (11, N'ImageProfile')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (4, N'Layer')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (9, N'Layout')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (1, N'Menu')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (6, N'MenuItem')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (7, N'MenuWidget')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (5, N'Page')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (10, N'ProjectionPage')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (2, N'Site')
INSERT [dbo].[Orchard_Framework_ContentTypeRecord] ([Id], [Name]) VALUES (3, N'User')
SET IDENTITY_INSERT [dbo].[Orchard_Framework_ContentTypeRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Framework_CultureRecord] ON 

INSERT [dbo].[Orchard_Framework_CultureRecord] ([Id], [Culture]) VALUES (1, N'en-US')
SET IDENTITY_INSERT [dbo].[Orchard_Framework_CultureRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ON 

INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (31, N'Faurecia.ADL.Migrations', 10)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (9, N'Orchard.Alias.Migrations', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (10, N'Orchard.Autoroute.Migrations', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (26, N'Orchard.Blogs.Migrations', 7)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (22, N'Orchard.Comments.Migrations', 6)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (2, N'Orchard.ContentManagement.DataMigrations.FrameworkDataMigration', 4)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (8, N'Orchard.ContentPicker.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (17, N'Orchard.ContentTypes.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (3, N'Orchard.Core.Common.Migrations', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (4, N'Orchard.Core.Containers.Migrations', 7)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (6, N'Orchard.Core.Navigation.Migrations', 7)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (7, N'Orchard.Core.Scheduling.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (1, N'Orchard.Core.Settings.Migrations', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (5, N'Orchard.Core.Title.Migrations', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (28, N'Orchard.Layouts.Migrations', 3)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (25, N'Orchard.MediaLibrary.MediaDataMigration', 7)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (19, N'Orchard.MediaProcessing.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (18, N'Orchard.OutputCache.Migrations', 7)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (15, N'Orchard.Packaging.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (11, N'Orchard.Pages.Migrations', 3)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (24, N'Orchard.Projections.Migrations', 4)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (20, N'Orchard.PublishLater.Migrations', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (16, N'Orchard.Recipes.Migrations', 1)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (14, N'Orchard.Roles.RolesDataMigration', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (29, N'Orchard.Tags.TagsDataMigration', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (23, N'Orchard.Taxonomies.Migrations', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (12, N'Orchard.Themes.ThemesDataMigration', 2)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (13, N'Orchard.Users.UsersDataMigration', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (21, N'Orchard.Widgets.WidgetsDataMigration', 5)
INSERT [dbo].[Orchard_Framework_DataMigrationRecord] ([Id], [DataMigrationClass], [Version]) VALUES (27, N'Orchard.Workflows.Migrations', 1)
SET IDENTITY_INSERT [dbo].[Orchard_Framework_DataMigrationRecord] OFF
INSERT [dbo].[Orchard_Layouts_LayoutPartRecord] ([Id], [ContentItemRecord_id], [TemplateId]) VALUES (9, 9, NULL)
INSERT [dbo].[Orchard_Layouts_LayoutPartRecord] ([Id], [ContentItemRecord_id], [TemplateId]) VALUES (18, 18, NULL)
INSERT [dbo].[Orchard_Layouts_LayoutPartRecord] ([Id], [ContentItemRecord_id], [TemplateId]) VALUES (19, 18, NULL)
SET IDENTITY_INSERT [dbo].[Orchard_Packaging_PackagingSource] ON 

INSERT [dbo].[Orchard_Packaging_PackagingSource] ([Id], [FeedTitle], [FeedUrl]) VALUES (1, N'Orchard Gallery', N'https://gallery.orchardproject.net/api/FeedService')
SET IDENTITY_INSERT [dbo].[Orchard_Packaging_PackagingSource] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ON 

INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ([Id], [Type], [Member], [Description], [DisplayName]) VALUES (1, N'Orchard.Core.Common.Models.CommonPartRecord', N'CreatedUtc', N'When the content item was created', N'Creation date')
INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ([Id], [Type], [Member], [Description], [DisplayName]) VALUES (2, N'Orchard.Core.Common.Models.CommonPartRecord', N'ModifiedUtc', N'When the content item was modified', N'Modification date')
INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ([Id], [Type], [Member], [Description], [DisplayName]) VALUES (3, N'Orchard.Core.Common.Models.CommonPartRecord', N'PublishedUtc', N'When the content item was published', N'Publication date')
INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ([Id], [Type], [Member], [Description], [DisplayName]) VALUES (4, N'Orchard.Core.Title.Models.TitlePartRecord', N'Title', N'The title assigned using the Title part', N'Title Part Title')
INSERT [dbo].[Orchard_Projections_MemberBindingRecord] ([Id], [Type], [Member], [Description], [DisplayName]) VALUES (5, N'Orchard.Core.Common.Models.BodyPartRecord', N'Text', N'The text from the Body part', N'Body Part Text')
SET IDENTITY_INSERT [dbo].[Orchard_Projections_MemberBindingRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ON 

INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (1, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'1', N'Feature', 1, 1, NULL)
INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (2, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'2', N'ContentDefinition', 1, 1, NULL)
INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (3, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'3', N'Settings', 1, 1, NULL)
INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (4, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'4', N'Migration', 1, 1, NULL)
INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (5, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'5', N'Command', 1, 1, NULL)
INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] ([Id], [ExecutionId], [RecipeName], [StepId], [StepName], [IsCompleted], [IsSuccessful], [ErrorMessage]) VALUES (6, N'55494fd24d3c4e51b0e3e8495114636f', N'Default', N'19eb19972fc2470b9ebe46d83ab8f1a9', N'ActivateShell', 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Orchard_Recipes_RecipeStepResultRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Roles_PermissionRecord] ON 

INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (1, N'ManageSettings', N'Settings', N'Manage Settings')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (2, N'ManageUsers', N'Orchard.Users', N'Managing Users')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (3, N'ManageRoles', N'Orchard.Roles', N'Managing Roles')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (4, N'AssignRoles', N'Orchard.Roles', N'Assign Roles')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (5, N'PublishContent', N'Contents', N'Publish or unpublish content for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (6, N'EditContent', N'Contents', N'Edit content for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (7, N'DeleteContent', N'Contents', N'Delete content for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (8, N'PreviewContent', N'Contents', N'Preview content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (9, N'PublishOwnContent', N'Contents', N'Publish or unpublish own content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (10, N'EditOwnContent', N'Contents', N'Edit own content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (11, N'DeleteOwnContent', N'Contents', N'Delete own content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (12, N'PreviewOwnContent', N'Contents', N'Preview own content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (13, N'ViewContent', N'Contents', N'View all content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (14, N'SetHomePage', N'Orchard.Autoroute', N'Set Home Page')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (15, N'ApplyTheme', N'Orchard.Themes', N'Apply a Theme')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (16, N'ManageMenus', N'Navigation', N'Manage all menus')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (17, N'ManageFeatures', N'Orchard.Modules', N'Manage Features')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (18, N'SiteOwner', N'Orchard.Framework', N'Site Owners Permission')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (19, N'AccessAdminPanel', N'Orchard.Framework', N'Access admin panel')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (20, N'AccessFrontEnd', N'Orchard.Framework', N'Access site front-end')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (21, N'ViewContentTypes', N'Orchard.ContentTypes', N'View content types.')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (22, N'EditContentTypes', N'Orchard.ContentTypes', N'Edit content types.')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (23, N'ManageWidgets', N'Orchard.Widgets', N'Managing Widgets')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (24, N'ManageComments', N'Orchard.Comments', N'Manage comments')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (25, N'AddComment', N'Orchard.Comments', N'Add comment')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (26, N'ManageTaxonomies', N'Orchard.Taxonomies', N'Manage taxonomies')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (27, N'CreateTaxonomy', N'Orchard.Taxonomies', N'Create taxonomy')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (28, N'ManageQueries', N'Orchard.Projections', N'Manage queries')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (29, N'ManageMediaContent', N'Orchard.MediaLibrary', N'Manage Media')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (30, N'ManageOwnMedia', N'Orchard.MediaLibrary', N'Manage Own Media')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (31, N'ManageBlogs', N'Orchard.Blogs', N'Manage blogs for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (32, N'PublishBlogPost', N'Orchard.Blogs', N'Publish or unpublish blog post for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (33, N'EditBlogPost', N'Orchard.Blogs', N'Edit blog posts for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (34, N'DeleteBlogPost', N'Orchard.Blogs', N'Delete blog post for others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (35, N'ManageOwnBlogs', N'Orchard.Blogs', N'Manage own blogs')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (36, N'EditOwnBlogPost', N'Orchard.Blogs', N'Edit own blog posts')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (37, N'ManageLayouts', N'Orchard.Layouts', N'Managing Layouts')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (38, N'ManageTags', N'Orchard.Tags', N'Manage tags')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (39, N'ViewOwnContent', N'Contents', N'View own content')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (40, N'View_Page', N'Contents', N'View Page by others')
INSERT [dbo].[Orchard_Roles_PermissionRecord] ([Id], [Name], [FeatureName], [Description]) VALUES (41, N'ViewOwn_Page', N'Contents', N'View own Page')
SET IDENTITY_INSERT [dbo].[Orchard_Roles_PermissionRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Roles_RoleRecord] ON 

INSERT [dbo].[Orchard_Roles_RoleRecord] ([Id], [Name]) VALUES (4, N'Author')
INSERT [dbo].[Orchard_Roles_RoleRecord] ([Id], [Name]) VALUES (6, N'Authenticated')
INSERT [dbo].[Orchard_Roles_RoleRecord] ([Id], [Name]) VALUES (7, N'Anonymous')
INSERT [dbo].[Orchard_Roles_RoleRecord] ([Id], [Name]) VALUES (8, N'Administrator')
SET IDENTITY_INSERT [dbo].[Orchard_Roles_RoleRecord] OFF
SET IDENTITY_INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ON 

INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (13, 4, 9, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (14, 4, 10, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (15, 4, 11, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (16, 4, 12, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (19, 6, 13, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (29, 6, 20, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (32, 4, 19, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (40, 6, 25, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (44, 4, 25, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (49, 4, 27, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (54, 4, 30, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (60, 4, 35, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (71, 7, 40, NULL)
INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] ([Id], [Role_id], [Permission_id], [RoleRecord_Id]) VALUES (72, 7, 41, NULL)
SET IDENTITY_INSERT [dbo].[Orchard_Roles_RolesPermissionsRecord] OFF
INSERT [dbo].[Orchard_Tags_TagsPartRecord] ([Id]) VALUES (9)
INSERT [dbo].[Orchard_Tags_TagsPartRecord] ([Id]) VALUES (18)
INSERT [dbo].[Orchard_Users_UserPartRecord] ([Id], [UserName], [Email], [NormalizedUserName], [Password], [PasswordFormat], [HashAlgorithm], [PasswordSalt], [RegistrationStatus], [EmailStatus], [EmailChallengeToken], [CreatedUtc], [LastLoginUtc], [LastLogoutUtc], [LastPasswordChangeUtc]) VALUES (2, N'admin', N'', N'admin', N'AIItX4NB0WZV4WbVmP/2J7iZbwc2bddNoukjbG4cTWBCz43zNFdpmVaOxwxQHjIHXg==', N'Hashed', N'PBKDF2', N'oXDA3zgFCmaImriODIQNLw==', N'Approved', N'Approved', NULL, CAST(0x0000A6EC0052704C AS DateTime), CAST(0x0000A73600517908 AS DateTime), CAST(0x0000A6F800FA4CF4 AS DateTime), CAST(0x0000A6EC0052704C AS DateTime))
INSERT [dbo].[Orchard_Widgets_LayerPartRecord] ([Id], [Name], [Description], [LayerRule]) VALUES (3, N'Default', N'The widgets in this layer are displayed on all pages', N'true')
INSERT [dbo].[Orchard_Widgets_LayerPartRecord] ([Id], [Name], [Description], [LayerRule]) VALUES (4, N'Authenticated', N'The widgets in this layer are displayed when the user is authenticated', N'authenticated')
INSERT [dbo].[Orchard_Widgets_LayerPartRecord] ([Id], [Name], [Description], [LayerRule]) VALUES (5, N'Anonymous', N'The widgets in this layer are displayed when the user is anonymous', N'not authenticated')
INSERT [dbo].[Orchard_Widgets_LayerPartRecord] ([Id], [Name], [Description], [LayerRule]) VALUES (6, N'Disabled', N'The widgets in this layer are never displayed', N'false')
INSERT [dbo].[Orchard_Widgets_LayerPartRecord] ([Id], [Name], [Description], [LayerRule]) VALUES (7, N'TheHomepage', N'The widgets in this layer are displayed on the home page', N'url ''~/''')
INSERT [dbo].[Orchard_Widgets_WidgetPartRecord] ([Id], [Title], [Position], [Zone], [RenderTitle], [Name]) VALUES (11, N'Main Menu', N'1', N'Navigation', 0, NULL)
SET IDENTITY_INSERT [dbo].[Settings_ContentPartDefinitionRecord] ON 

INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (1, N'BodyPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Allows the editing of text using an editor provided by the configured flavor (e.g. html, text, markdown)." ContentPartLayoutSettings.Placeable="True" BodyPartSettings.FlavorDefault="html" />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (2, N'CommonPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common information about a content item, such as Owner, Date Created, Date Published and Date Modified." ContentPartLayoutSettings.Placeable="True" />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (3, N'IdentityPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Automatically generates a unique identity for the content item, which is required in import/export scenarios where one content item references another." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (4, N'WidgetPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Turns a content type into a Widget. Note: you need to set the stereotype to &quot;Widget&quot; as well." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (5, N'ContainerWidgetPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (6, N'ContainerPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Turns your content item into a container that is capable of containing content items that have the ContainablePart attached." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (7, N'ContainablePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Allows your content item to be contained by a content item that has the ContainerPart attached." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (8, N'TitlePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides a Title for your content item." ContentPartLayoutSettings.Placeable="True" />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (9, N'MenuPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides an easy way to create a ContentMenuItem from the content editor." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (10, N'MenuWidgetPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (11, N'AdminMenuPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Adds a menu item to the Admin menu that links to this content item." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (12, N'ShapeMenuItemPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (13, N'ContentMenuItemPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (14, N'NavigationPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Allows the management of Content Menu Items associated with a Content Item." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (15, N'AutoroutePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Adds advanced url configuration options to your content type to completely customize the url pattern for a content item." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (16, N'PublishLaterPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Adds the ability to delay the publication of a content item to a later date and time." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (17, N'LayoutPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Adds a layout designer to your content type." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (18, N'DisableThemePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="When attached to a content type, disables the theme when a content item of this type is displayed." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (19, N'ImageProfilePart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (20, N'LayerPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (21, N'CommentPart', 0, N'<settings ContentPartSettings.Description="Used by the Comment content type." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (22, N'CommentsContainerPart', 0, N'<settings ContentPartSettings.Description="Adds support to a content type to contain comments." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (23, N'CommentsPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Allows content items to be commented on." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (24, N'TaxonomyPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (25, N'TaxonomyNavigationPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (26, N'QueryPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (27, N'ProjectionPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (28, N'NavigationQueryPart', 0, NULL)
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (29, N'MediaPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Turns a content type into a Media. Note: you need to set the stereotype to &quot;Media&quot; as well." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (30, N'ImagePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for an Image Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (31, N'VectorImagePart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for a Vector Image Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (32, N'VideoPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for a Video Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (33, N'AudioPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for an Audio Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (34, N'DocumentPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for a Document Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (35, N'OEmbedPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Provides common metadata for an OEmbed Media." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (36, N'BlogPart', 0, N'<settings ContentPartSettings.Description="Turns content types into a Blog." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (37, N'BlogPostPart', 0, N'<settings ContentPartSettings.Description="Turns content types into a BlogPost." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (38, N'RecentBlogPostsPart', 0, N'<settings ContentPartSettings.Description="Renders a list of recent blog posts." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (39, N'BlogArchivesPart', 0, N'<settings ContentPartSettings.Description="Renders an archive of posts for a blog." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (40, N'TagsPart', 0, N'<settings ContentPartLayoutSettings.Placeable="True" ContentPartSettings.Attachable="True" ContentPartSettings.Description="Allows to describe your content using non-hierarchical keywords." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (41, N'ElementWrapperPart', 0, N'<settings ContentPartSettings.Attachable="True" ContentPartSettings.Description="Turns elements into content items." />')
INSERT [dbo].[Settings_ContentPartDefinitionRecord] ([Id], [Name], [Hidden], [Settings]) VALUES (42, N'LocalizationPart', 0, NULL)
SET IDENTITY_INSERT [dbo].[Settings_ContentPartDefinitionRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ON 

INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (1, N'Site', N'Site', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (2, N'ContainerWidget', N'Container Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (3, N'MenuItem', N'Custom Link', 0, N'<settings Description="Represents a simple custom link with a text and an url." Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (4, N'Menu', N'Menu', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (5, N'MenuWidget', N'Menu Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (6, N'HtmlMenuItem', N'Html Menu Item', 0, N'<settings Description="Renders some custom HTML in the menu." BodyPartSettings.FlavorDefault="html" Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (7, N'ShapeMenuItem', N'Shape Link', 0, N'<settings Description="Injects menu items from a Shape" Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (8, N'ContentMenuItem', N'Content Menu Item', 0, N'<settings Description="Adds a Content Item to the menu." Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (9, N'Page', N'Page', 0, N'<settings ContentTypeSettings.Creatable="True" ContentTypeSettings.Listable="True" ContentTypeSettings.Securable="True" ContentTypeSettings.Draftable="True" TypeIndexing.Indexes="Search" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (10, N'User', N'User', 0, N'<settings ContentTypeSettings.Creatable="False" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (11, N'ImageProfile', N'Image Profile', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (12, N'Layer', N'Layer', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (13, N'HtmlWidget', N'Html Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (14, N'Comment', N'Comment', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (15, N'Blog', N'Blog', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (16, N'Taxonomy', N'Taxonomy', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (17, N'TaxonomyNavigationMenuItem', N'Taxonomy Link', 0, N'<settings Description="Injects menu items from a Taxonomy" Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (18, N'Query', N'Query', 0, N'<settings />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (19, N'ProjectionWidget', N'Projection Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (20, N'ProjectionPage', N'Projection', 0, N'<settings ContentTypeSettings.Creatable="True" ContentTypeSettings.Listable="True" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (21, N'NavigationQueryMenuItem', N'Query Link', 0, N'<settings Description="Injects menu items from a Query" Stereotype="MenuItem" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (22, N'Image', N'Image', 0, N'<settings MediaFileNameEditorSettings.ShowFileNameEditor="True" Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (23, N'VectorImage', N'Vector Image', 0, N'<settings MediaFileNameEditorSettings.ShowFileNameEditor="True" Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (24, N'Video', N'Video', 0, N'<settings MediaFileNameEditorSettings.ShowFileNameEditor="True" Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (25, N'Audio', N'Audio', 0, N'<settings MediaFileNameEditorSettings.ShowFileNameEditor="True" Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (26, N'Document', N'Document', 0, N'<settings MediaFileNameEditorSettings.ShowFileNameEditor="True" Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (27, N'OEmbed', N'External Media', 0, N'<settings Stereotype="Media" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (28, N'BlogPost', N'Blog Post', 0, N'<settings ContentTypeSettings.Draftable="True" TypeIndexing.Indexes="Search" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (29, N'RecentBlogPosts', N'Recent Blog Posts', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (30, N'BlogArchives', N'Blog Archives', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (31, N'Layout', N'Layout', 0, N'<settings ContentTypeSettings.Draftable="True" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (32, N'LayoutWidget', N'Layout Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (33, N'TextWidget', N'Text Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (34, N'MediaWidget', N'Media Widget', 0, N'<settings Stereotype="Widget" />')
INSERT [dbo].[Settings_ContentTypeDefinitionRecord] ([Id], [Name], [DisplayName], [Hidden], [Settings]) VALUES (35, N'ContentWidget', N'Content Widget', 0, N'<settings Stereotype="Widget" />')
SET IDENTITY_INSERT [dbo].[Settings_ContentTypeDefinitionRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ON 

INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (1, N'<settings />', 2, 2)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (2, N'<settings />', 4, 2)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (3, N'<settings />', 5, 2)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (4, N'<settings />', 3, 2)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (5, N'<settings />', 9, 3)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (6, N'<settings />', 3, 3)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (7, N'<settings />', 2, 3)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (8, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" />', 2, 4)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (9, N'<settings />', 8, 4)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (10, N'<settings />', 2, 5)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (11, N'<settings />', 3, 5)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (12, N'<settings />', 4, 5)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (13, N'<settings />', 10, 5)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (14, N'<settings />', 9, 6)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (15, N'<settings />', 1, 6)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (16, N'<settings />', 2, 6)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (17, N'<settings />', 3, 6)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (18, N'<settings />', 12, 7)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (19, N'<settings />', 9, 7)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (20, N'<settings />', 2, 7)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (21, N'<settings />', 3, 4)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (22, N'<settings />', 3, 7)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (23, N'<settings />', 9, 8)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (24, N'<settings />', 2, 8)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (25, N'<settings />', 3, 8)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (26, N'<settings />', 13, 8)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (27, N'<settings DateEditorSettings.ShowDateEditor="True" />', 2, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (28, N'<settings />', 16, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (29, N'<settings />', 8, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (30, N'<settings AutorouteSettings.AllowCustomPattern="True" AutorouteSettings.AutomaticAdjustmentOnEdit="False" AutorouteSettings.PatternDefinitions="[{&quot;Name&quot;:&quot;Title&quot;,&quot;Pattern&quot;:&quot;{Content.Slug}&quot;,&quot;Description&quot;:&quot;my-page&quot;}]" />', 15, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (31, N'<settings LayoutTypePartSettings.IsTemplate="False" />', 17, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (32, N'<settings />', 19, 11)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (33, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" />', 2, 11)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (34, N'<settings />', 3, 11)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (35, N'<settings />', 20, 12)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (36, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" />', 2, 12)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (37, N'<settings />', 1, 13)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (38, N'<settings />', 2, 13)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (39, N'<settings />', 4, 13)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (40, N'<settings />', 3, 13)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (41, N'<settings />', 21, 14)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (42, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 14)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (43, N'<settings />', 3, 14)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (44, N'<settings />', 22, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (45, N'<settings />', 24, 16)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (46, N'<settings />', 2, 16)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (47, N'<settings />', 8, 16)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (48, N'<settings AutorouteSettings.AllowCustomPattern="True" AutorouteSettings.AutomaticAdjustmentOnEdit="False" AutorouteSettings.PatternDefinitions="[{&quot;Name&quot;:&quot;Title&quot;,&quot;Pattern&quot;:&quot;{Content.Slug}&quot;,&quot;Description&quot;:&quot;my-taxonomy&quot;}]" />', 15, 16)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (49, N'<settings />', 25, 17)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (50, N'<settings />', 9, 17)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (51, N'<settings />', 2, 17)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (52, N'<settings />', 3, 17)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (53, N'<settings />', 26, 18)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (54, N'<settings />', 8, 18)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (55, N'<settings />', 3, 18)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (56, N'<settings />', 4, 19)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (57, N'<settings />', 2, 19)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (58, N'<settings />', 3, 19)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (59, N'<settings />', 27, 19)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (60, N'<settings />', 2, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (61, N'<settings />', 8, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (62, N'<settings AutorouteSettings.AllowCustomPattern="True" AutorouteSettings.AutomaticAdjustmentOnEdit="False" AutorouteSettings.PatternDefinitions="[{&quot;Name&quot;:&quot;Title&quot;,&quot;Pattern&quot;:&quot;{Content.Slug}&quot;,&quot;Description&quot;:&quot;my-projections&quot;}]" />', 15, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (63, N'<settings />', 9, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (64, N'<settings />', 27, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (65, N'<settings AdminMenuPartTypeSettings.DefaultPosition="5" />', 11, 20)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (66, N'<settings />', 28, 21)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (67, N'<settings />', 9, 21)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (68, N'<settings />', 2, 21)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (69, N'<settings />', 3, 21)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (70, N'<settings />', 2, 22)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (71, N'<settings />', 29, 22)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (72, N'<settings />', 8, 22)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (73, N'<settings />', 30, 22)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (74, N'<settings />', 3, 22)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (75, N'<settings />', 2, 23)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (76, N'<settings />', 29, 23)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (77, N'<settings />', 8, 23)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (78, N'<settings />', 31, 23)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (79, N'<settings />', 3, 23)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (80, N'<settings />', 2, 24)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (81, N'<settings />', 29, 24)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (82, N'<settings />', 8, 24)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (83, N'<settings />', 32, 24)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (84, N'<settings />', 3, 24)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (85, N'<settings />', 2, 25)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (86, N'<settings />', 29, 25)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (87, N'<settings />', 8, 25)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (88, N'<settings />', 33, 25)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (89, N'<settings />', 3, 25)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (90, N'<settings />', 2, 26)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (91, N'<settings />', 29, 26)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (92, N'<settings />', 8, 26)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (93, N'<settings />', 34, 26)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (94, N'<settings />', 3, 26)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (95, N'<settings />', 3, 27)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (96, N'<settings />', 2, 27)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (97, N'<settings />', 29, 27)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (98, N'<settings />', 35, 27)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (99, N'<settings />', 8, 27)
GO
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (100, N'<settings />', 36, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (101, N'<settings />', 2, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (102, N'<settings />', 8, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (103, N'<settings AutorouteSettings.AllowCustomPattern="True" AutorouteSettings.AutomaticAdjustmentOnEdit="False" AutorouteSettings.PatternDefinitions="[{&quot;Name&quot;:&quot;Title&quot;,&quot;Pattern&quot;:&quot;{Content.Slug}&quot;,&quot;Description&quot;:&quot;my-blog&quot;}]" />', 15, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (104, N'<settings />', 9, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (105, N'<settings AdminMenuPartTypeSettings.DefaultPosition="2" />', 11, 15)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (106, N'<settings />', 37, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (107, N'<settings DateEditorSettings.ShowDateEditor="True" />', 2, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (108, N'<settings />', 16, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (109, N'<settings />', 8, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (110, N'<settings AutorouteSettings.AllowCustomPattern="True" AutorouteSettings.AutomaticAdjustmentOnEdit="False" AutorouteSettings.PatternDefinitions="[{&quot;Name&quot;:&quot;Blog and Title&quot;,&quot;Pattern&quot;:&quot;{Content.Container.Path}/{Content.Slug}&quot;,&quot;Description&quot;:&quot;my-blog/my-post&quot;}]" />', 15, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (111, N'<settings />', 1, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (112, N'<settings />', 38, 29)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (113, N'<settings />', 2, 29)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (114, N'<settings />', 4, 29)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (115, N'<settings />', 3, 29)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (116, N'<settings />', 39, 30)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (117, N'<settings />', 2, 30)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (118, N'<settings />', 4, 30)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (119, N'<settings />', 3, 30)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (120, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 31)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (121, N'<settings />', 8, 31)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (122, N'<settings />', 3, 31)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (123, N'<settings LayoutTypePartSettings.IsTemplate="True" />', 17, 31)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (124, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 32)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (125, N'<settings />', 3, 32)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (126, N'<settings />', 4, 32)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (127, N'<settings />', 17, 32)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (128, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 33)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (129, N'<settings />', 4, 33)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (130, N'<settings />', 3, 33)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (131, N'<settings ElementWrapperPartSettings.ElementTypeName="Orchard.Layouts.Elements.Text" />', 41, 33)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (132, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 34)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (133, N'<settings />', 4, 34)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (134, N'<settings />', 3, 34)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (135, N'<settings ElementWrapperPartSettings.ElementTypeName="Orchard.Layouts.Elements.MediaItem" />', 41, 34)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (136, N'<settings OwnerEditorSettings.ShowOwnerEditor="false" DateEditorSettings.ShowDateEditor="false" />', 2, 35)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (137, N'<settings />', 4, 35)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (138, N'<settings />', 3, 35)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (139, N'<settings ElementWrapperPartSettings.ElementTypeName="Orchard.Layouts.Elements.ContentItem" />', 41, 35)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (140, N'<settings />', 40, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (141, N'<settings />', 42, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (142, N'<settings />', 9, 9)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (143, N'<settings />', 23, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (144, N'<settings />', 40, 28)
INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] ([Id], [Settings], [ContentPartDefinitionRecord_id], [ContentTypeDefinitionRecord_Id]) VALUES (145, N'<settings />', 42, 28)
SET IDENTITY_INSERT [dbo].[Settings_ContentTypePartDefinitionRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ShellDescriptorRecord] ON 

INSERT [dbo].[Settings_ShellDescriptorRecord] ([Id], [SerialNumber]) VALUES (1, 11)
SET IDENTITY_INSERT [dbo].[Settings_ShellDescriptorRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ShellFeatureRecord] ON 

INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (512, N'Orchard.Framework', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (513, N'Common', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (514, N'Containers', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (515, N'Contents', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (516, N'Dashboard', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (517, N'Feeds', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (518, N'Navigation', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (519, N'Scheduling', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (520, N'Settings', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (521, N'Shapes', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (522, N'Title', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (523, N'Orchard.Pages', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (524, N'Orchard.ContentPicker', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (525, N'Orchard.Themes', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (526, N'Orchard.Users', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (527, N'Orchard.Roles', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (528, N'Orchard.Modules', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (529, N'PackagingServices', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (530, N'Orchard.Packaging', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (531, N'Gallery', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (532, N'Orchard.Recipes', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (533, N'Orchard.Alias', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (534, N'Orchard.Tokens', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (535, N'Orchard.Autoroute', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (536, N'Orchard.Resources', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (537, N'Orchard.Blogs', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (538, N'Orchard.Widgets', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (539, N'Orchard.PublishLater', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (540, N'Orchard.Conditions', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (541, N'Orchard.Scripting', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (542, N'Orchard.Comments', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (543, N'Orchard.Tags', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (544, N'Orchard.Alias', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (545, N'Orchard.Autoroute', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (546, N'TinyMce', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (547, N'Orchard.MediaLibrary', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (548, N'Orchard.MediaProcessing', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (549, N'Orchard.Forms', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (550, N'Orchard.ContentPicker', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (551, N'Orchard.Resources', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (552, N'Orchard.ContentTypes', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (553, N'Orchard.Scripting.Lightweight', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (554, N'PackagingServices', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (555, N'Orchard.Packaging', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (556, N'Orchard.Projections', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (557, N'Orchard.Fields', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (558, N'Orchard.OutputCache', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (559, N'Orchard.Taxonomies', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (560, N'Orchard.Workflows', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (561, N'Orchard.Layouts', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (562, N'Orchard.Layouts.Tokens', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (563, N'TheThemeMachine', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (564, N'PJS.Bootstrap', 1)
INSERT [dbo].[Settings_ShellFeatureRecord] ([Id], [Name], [ShellDescriptorRecord_id]) VALUES (565, N'Faurecia.BM', 1)
SET IDENTITY_INSERT [dbo].[Settings_ShellFeatureRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ShellFeatureStateRecord] ON 

INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (1, N'Orchard.Framework', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (2, N'Common', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (3, N'Containers', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (4, N'Contents', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (5, N'Dashboard', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (6, N'Feeds', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (7, N'Navigation', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (8, N'Scheduling', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (9, N'Settings', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (10, N'Shapes', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (11, N'Title', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (12, N'Orchard.Pages', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (13, N'Orchard.ContentPicker', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (14, N'Orchard.Themes', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (15, N'Orchard.Users', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (16, N'Orchard.Roles', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (17, N'Orchard.Modules', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (18, N'PackagingServices', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (19, N'Orchard.Packaging', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (20, N'Gallery', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (21, N'Orchard.Recipes', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (22, N'Orchard.Alias', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (23, N'Orchard.Tokens', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (24, N'Orchard.Autoroute', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (25, N'Orchard.Resources', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (26, N'Orchard.Blogs', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (27, N'Orchard.Widgets', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (28, N'Orchard.PublishLater', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (29, N'Orchard.Conditions', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (30, N'Orchard.Scripting', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (31, N'Orchard.Comments', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (32, N'Orchard.Tags', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (33, N'TinyMce', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (34, N'Orchard.MediaLibrary', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (35, N'Orchard.MediaProcessing', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (36, N'Orchard.Forms', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (37, N'Orchard.ContentTypes', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (38, N'Orchard.Scripting.Lightweight', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (39, N'Orchard.Projections', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (40, N'Orchard.Fields', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (41, N'Orchard.OutputCache', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (42, N'Orchard.Taxonomies', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (43, N'Orchard.Workflows', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (44, N'Orchard.Layouts', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (45, N'Orchard.Layouts.Tokens', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (46, N'TheThemeMachine', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (47, N'PJS.Bootstrap', N'Up', N'Up', 1)
INSERT [dbo].[Settings_ShellFeatureStateRecord] ([Id], [Name], [InstallState], [EnableState], [ShellStateRecord_Id]) VALUES (48, N'Faurecia.BM', N'Up', N'Up', 1)
SET IDENTITY_INSERT [dbo].[Settings_ShellFeatureStateRecord] OFF
SET IDENTITY_INSERT [dbo].[Settings_ShellStateRecord] ON 

INSERT [dbo].[Settings_ShellStateRecord] ([Id], [Unused]) VALUES (1, NULL)
SET IDENTITY_INSERT [dbo].[Settings_ShellStateRecord] OFF
INSERT [dbo].[Title_TitlePartRecord] ([Id], [ContentItemRecord_id], [Title]) VALUES (8, 8, N'Main Menu')
INSERT [dbo].[Title_TitlePartRecord] ([Id], [ContentItemRecord_id], [Title]) VALUES (9, 9, N'Welcome to Orchard!')
INSERT [dbo].[Title_TitlePartRecord] ([Id], [ContentItemRecord_id], [Title]) VALUES (18, 18, N'Home Page')
INSERT [dbo].[Title_TitlePartRecord] ([Id], [ContentItemRecord_id], [Title]) VALUES (19, 18, N'Welcome')
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_AutoroutePartRecord_DisplayAlias]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_AutoroutePartRecord_DisplayAlias] ON [dbo].[Orchard_Autoroute_AutoroutePartRecord]
(
	[DisplayAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_CommentedOn]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_CommentedOn] ON [dbo].[Orchard_Comments_CommentPartRecord]
(
	[CommentedOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_CommentedOnContainer]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_CommentedOnContainer] ON [dbo].[Orchard_Comments_CommentPartRecord]
(
	[CommentedOnContainer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_ContentType_id]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_ContentType_id] ON [dbo].[Orchard_Framework_ContentItemRecord]
(
	[ContentType_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UC_CIVR_CIRId_Number]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Orchard_Framework_ContentItemVersionRecord] ADD  CONSTRAINT [UC_CIVR_CIRId_Number] UNIQUE NONCLUSTERED 
(
	[ContentItemRecord_id] ASC,
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_ContentItemRecord_id]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_ContentItemRecord_id] ON [dbo].[Orchard_Framework_ContentItemVersionRecord]
(
	[ContentItemRecord_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_ContentItemVersionRecord_Published_Latest]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_ContentItemVersionRecord_Published_Latest] ON [dbo].[Orchard_Framework_ContentItemVersionRecord]
(
	[Published] ASC,
	[Latest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CTR_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Orchard_Framework_ContentTypeRecord] ADD  CONSTRAINT [UC_CTR_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_ContentType_Name]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_ContentType_Name] ON [dbo].[Orchard_Framework_ContentTypeRecord]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CR_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Orchard_Framework_CultureRecord] ADD  CONSTRAINT [UC_CR_Name] UNIQUE NONCLUSTERED 
(
	[Culture] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_DMR_DataMigrationClass_Version]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Orchard_Framework_DataMigrationRecord] ADD  CONSTRAINT [UC_DMR_DataMigrationClass_Version] UNIQUE NONCLUSTERED 
(
	[DataMigrationClass] ASC,
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Orchard___737584F6891BB918]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Orchard_Framework_DistributedLockRecord] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_DistributedLockRecord_Name]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_DistributedLockRecord_Name] ON [dbo].[Orchard_Framework_DistributedLockRecord]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_MediaPartRecord_FolderPath]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_MediaPartRecord_FolderPath] ON [dbo].[Orchard_MediaLibrary_MediaPartRecord]
(
	[FolderPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_RecipeStepResultRecord_ExecutionId]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_RecipeStepResultRecord_ExecutionId] ON [dbo].[Orchard_Recipes_RecipeStepResultRecord]
(
	[ExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_RecipeStepResultRecord_ExecutionId_StepName]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_RecipeStepResultRecord_ExecutionId_StepName] ON [dbo].[Orchard_Recipes_RecipeStepResultRecord]
(
	[ExecutionId] ASC,
	[StepName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_Path]    Script Date: 2017/3/18 23:01:31 ******/
CREATE NONCLUSTERED INDEX [IDX_Path] ON [dbo].[Orchard_Taxonomies_TermPartRecord]
(
	[Path] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CFDR_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ContentFieldDefinitionRecord] ADD  CONSTRAINT [UC_CFDR_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CPDR_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ContentPartDefinitionRecord] ADD  CONSTRAINT [UC_CPDR_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CPFDR_CPDRId_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ContentPartFieldDefinitionRecord] ADD  CONSTRAINT [UC_CPFDR_CPDRId_Name] UNIQUE NONCLUSTERED 
(
	[ContentPartDefinitionRecord_Id] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_CTDR_CPDRId]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ContentTypeDefinitionRecord] ADD  CONSTRAINT [UC_CTDR_CPDRId] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UC_CTPDR_CPDRId_CTDRId]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ContentTypePartDefinitionRecord] ADD  CONSTRAINT [UC_CTPDR_CPDRId_CTDRId] UNIQUE NONCLUSTERED 
(
	[ContentPartDefinitionRecord_id] ASC,
	[ContentTypeDefinitionRecord_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_SFSR_SSRId_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ShellFeatureStateRecord] ADD  CONSTRAINT [UC_SFSR_SSRId_Name] UNIQUE NONCLUSTERED 
(
	[ShellStateRecord_Id] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_SPR_SDRId_Component_Name]    Script Date: 2017/3/18 23:01:31 ******/
ALTER TABLE [dbo].[Settings_ShellParameterRecord] ADD  CONSTRAINT [UC_SPR_SDRId_Component_Name] UNIQUE NONCLUSTERED 
(
	[ShellDescriptorRecord_id] ASC,
	[Component] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orchard_Alias_AliasRecord] ADD  DEFAULT ((0)) FOR [IsManaged]
GO
ALTER TABLE [dbo].[Orchard_Autoroute_AutoroutePartRecord] ADD  DEFAULT ((0)) FOR [UseCustomPattern]
GO
ALTER TABLE [dbo].[Orchard_Autoroute_AutoroutePartRecord] ADD  DEFAULT ((0)) FOR [UseCulturePattern]
GO
ALTER TABLE [dbo].[Orchard_Users_UserPartRecord] ADD  DEFAULT ('Approved') FOR [RegistrationStatus]
GO
ALTER TABLE [dbo].[Orchard_Users_UserPartRecord] ADD  DEFAULT ('Approved') FOR [EmailStatus]
GO
ALTER TABLE [dbo].[Orchard_Users_UserPartRecord] ADD  DEFAULT ('01/01/1990 00:00:00') FOR [LastPasswordChangeUtc]
GO
ALTER TABLE [dbo].[Orchard_Widgets_WidgetPartRecord] ADD  DEFAULT ((1)) FOR [RenderTitle]
GO
USE [master]
GO
ALTER DATABASE [FaureciaBM] SET  READ_WRITE 
GO
