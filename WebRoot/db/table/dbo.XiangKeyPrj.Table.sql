USE [gov2014]
GO
/****** Object:  Table [dbo].[XiangKeyPrj]    Script Date: 06/17/2014 09:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XiangKeyPrj](
	[pqid] [int] NOT NULL,
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[pid] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[RID] [int] NOT NULL,
	[bm] [varchar](20) NULL,
	[itemname] [varchar](200) NULL,
	[own] [varchar](64) NULL,
	[spr] [money] NULL,
	[prt] [money] NULL,
	[sspr] [money] NULL,
	[opr] [money] NULL,
	[pyt] [money] NULL,
	[spy] [money] NULL,
	[yt] [int] NULL,
	[yp] [int] NULL,
	[np] [int] NULL,
	[rdt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[pqid] ASC,
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[RID] ASC,
	[pid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
