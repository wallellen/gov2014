USE [gov2014]
GO
/****** Object:  Table [dbo].[XianHouFang]    Script Date: 06/17/2014 09:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XianHouFang](
	[iid] [int] NOT NULL,
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[rid] [int] NOT NULL,
	[FUID] [int] NULL,
	[xiang] [varchar](20) NULL,
	[chun] [varchar](20) NULL,
	[vt] [money] NULL,
	[nt] [int] NULL,
	[fpyt] [money] NULL,
	[fpys] [money] NULL,
	[fpyd] [money] NULL,
	[itn] [int] NULL,
	[fn] [int] NULL,
	[un] [int] NULL,
	[er] [money] NULL,
	[rt] [int] NULL,
	[rm] [int] NULL,
	[re] [int] NULL,
 CONSTRAINT [PK__XianHouFang__2AD55B43] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[rid] ASC,
	[iid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
