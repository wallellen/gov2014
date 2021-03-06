USE [gov2014]
GO
/****** Object:  Table [dbo].[FamilyLog]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamilyLog](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[XID] [int] NOT NULL,
	[XXID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[HID] [int] NOT NULL,
	[opa] [int] NULL,
	[HM] [varchar](20) NULL,
	[odt] [datetime] NULL,
	[Cause] [int] NULL,
 CONSTRAINT [PK__FamilyLog__6319B466] PRIMARY KEY CLUSTERED 
(
	[RID] ASC,
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
