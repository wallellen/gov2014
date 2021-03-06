USE [gov2014]
GO
/****** Object:  Table [dbo].[GovData]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GovData](
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[BM] [varchar](20) NULL,
	[htn] [int] NULL,
	[ptn] [int] NULL,
	[OL] [int] NULL,
	[OName] [varchar](250) NOT NULL,
	[UserName] [varchar](60) NULL,
	[Pwd] [varchar](50) NULL,
	[Rights] [varchar](20) NULL,
	[edit] [int] NULL,
	[pf] [int] NULL,
	[pcf] [int] NULL,
	[PwdEx] [varchar](50) NULL,
	[xet] [int] NULL,
	[cjt] [int] NULL,
 CONSTRAINT [PK__GovData__77BFCB91] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
