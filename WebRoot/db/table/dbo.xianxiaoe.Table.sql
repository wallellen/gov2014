USE [gov2014]
GO
/****** Object:  Table [dbo].[xianxiaoe]    Script Date: 06/17/2014 09:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xianxiaoe](
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[year] [int] NOT NULL,
	[month] [int] NOT NULL,
	[tsh] [int] NULL,
	[tsv] [money] NULL,
	[trh] [int] NULL,
	[trv] [money] NULL,
	[lh] [int] NULL,
	[lv] [money] NULL,
	[th] [int] NULL,
	[tv] [money] NULL,
	[nh] [int] NULL,
	[nv] [money] NULL,
	[eh] [int] NULL,
	[ev] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[year] ASC,
	[month] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
