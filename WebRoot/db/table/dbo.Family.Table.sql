USE [gov2014]
GO
/****** Object:  Table [dbo].[Family]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Family](
	[SID] [int] NOT NULL,
	[HID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[HM] [varchar](20) NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[Zhu] [varchar](30) NULL,
	[HName] [varchar](200) NULL,
	[LaborNum] [int] NULL,
	[CID] [int] NOT NULL,
	[Population] [int] NULL,
	[Fields] [decimal](8, 1) NULL,
	[House] [decimal](8, 1) NULL,
	[Property] [int] NULL,
	[DCause] [int] NULL,
	[IDCNo] [varchar](20) NULL,
	[TelNum] [varchar](20) NULL,
	[FrName] [varchar](80) NULL,
	[FrTel] [varchar](32) NULL,
	[FrWork] [varchar](60) NULL,
	[State] [int] NULL,
	[isCheck] [int] NULL,
 CONSTRAINT [PK__Family__47DBAE45] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[HID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
