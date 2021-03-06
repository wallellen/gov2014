USE [gov2014]
GO
/****** Object:  Table [dbo].[FamilyMember]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamilyMember](
	[MID] [int] NOT NULL,
	[SID] [int] NOT NULL,
	[SSID] [int] NOT NULL,
	[UName] [varchar](200) NULL,
	[XID] [int] NOT NULL,
	[Sex] [int] NULL,
	[XXID] [int] NOT NULL,
	[Age] [int] NULL,
	[byear] [int] NULL,
	[CID] [int] NOT NULL,
	[School] [int] NULL,
	[HID] [int] NOT NULL,
	[Education] [int] NULL,
	[Hearth] [int] NULL,
	[HM] [varchar](20) NULL,
	[dcno] [varchar](20) NULL,
	[labors] [int] NULL,
	[works] [int] NULL,
	[bla] [int] NULL,
	[tbfd] [int] NULL,
 CONSTRAINT [PK__FamilyMember__0C85DE4D] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[SSID] ASC,
	[XID] ASC,
	[XXID] ASC,
	[CID] ASC,
	[HID] ASC,
	[MID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
