USE [gov2014]
GO
/****** Object:  Table [dbo].[FamilyCheckInfo]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamilyCheckInfo](
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[HID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[HM] [varchar](20) NULL,
	[ckDt] [datetime] NULL,
	[code] [int] NOT NULL,
	[info] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[HID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
