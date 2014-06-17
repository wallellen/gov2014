USE [gov2014]
GO
/****** Object:  Table [dbo].[NTS_R]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NTS_R](
	[MSGID] [int] IDENTITY(1,1) NOT NULL,
	[MsgFrom] [varchar](6) NULL,
	[MsgTo] [varchar](6) NULL,
	[Action] [int] NULL,
	[Channel] [int] NULL,
	[Param] [int] NULL,
	[Content] [varchar](1024) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
