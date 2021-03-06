USE [gov2014]
GO
/****** Object:  Table [dbo].[FamilyYear]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamilyYear](
	[SID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[inTotal] [numeric](10, 1) NULL,
	[XID] [int] NOT NULL,
	[InCrop] [numeric](8, 1) NULL,
	[XXID] [int] NOT NULL,
	[inLivstock] [numeric](8, 1) NULL,
	[CID] [int] NOT NULL,
	[inWork] [numeric](8, 1) NULL,
	[HID] [int] NOT NULL,
	[inBla] [numeric](8, 1) NULL,
	[inSubside] [numeric](8, 1) NULL,
	[HM] [varchar](20) NULL,
	[inOther] [numeric](8, 1) NULL,
	[inPersonal] [numeric](10, 2) NULL,
	[grantAid] [numeric](8, 1) NULL,
	[share] [numeric](8, 1) NULL,
	[pettyLoan] [numeric](8, 1) NULL,
	[labTrain] [int] NULL,
	[labJob] [int] NULL,
 CONSTRAINT [PK__FamilyYear__534D60F1] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[HID] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
