USE [gov2014]
GO
/****** Object:  Table [dbo].[chunprj]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[chunprj](
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[pid] [int] NOT NULL,
	[rid] [int] NOT NULL,
	[pname] [varchar](100) NULL,
	[bm] [varchar](20) NULL,
	[pcontent] [varchar](200) NULL,
	[prt] [money] NULL,
	[spr] [money] NULL,
	[pr] [money] NULL,
	[sspr] [money] NULL,
	[xpr] [money] NULL,
	[xxpr] [money] NULL,
	[opr] [money] NULL,
	[fpr] [money] NULL,
	[wpr] [money] NULL,
	[yfi] [money] NULL,
	[afi] [money] NULL,
	[lyi] [money] NULL,
	[o2015] [datetime] NULL,
	[sprp] [int] NULL,
	[pp] [int] NULL,
	[rdt] [datetime] NULL,
 CONSTRAINT [PK__chunprj__28ED12D1] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[rid] ASC,
	[pid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
