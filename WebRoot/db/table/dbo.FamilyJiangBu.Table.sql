USE [gov2014]
GO
/****** Object:  Table [dbo].[FamilyJiangBu]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamilyJiangBu](
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[HID] [int] NOT NULL,
	[RID] [int] NOT NULL,
	[T1] [int] NULL,
	[HM] [varchar](20) NULL,
	[T2] [int] NULL,
	[T3] [int] NULL,
	[T4] [int] NULL,
	[T5] [int] NULL,
	[T6] [int] NULL,
	[T7] [int] NULL,
	[V1] [int] NULL,
	[V] [int] NULL,
	[V2] [int] NULL,
	[V3] [int] NULL,
	[B1] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[HID] ASC,
	[RID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
