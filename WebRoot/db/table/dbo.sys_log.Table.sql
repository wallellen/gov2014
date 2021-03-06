USE [gov2014]
GO
/****** Object:  Table [dbo].[sys_log]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sys_log](
	[logid] [int] NOT NULL,
	[occdt] [datetime] NULL,
	[opcode] [varchar](32) NULL,
	[msgtype] [int] NULL,
	[sender] [varchar](32) NULL,
	[detail] [varchar](250) NULL,
	[lookit] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
