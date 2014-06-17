USE [gov2014]
GO
/****** Object:  Table [dbo].[sys_param]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_param](
	[segment] [nvarchar](60) NOT NULL,
	[key_name] [nvarchar](60) NOT NULL,
	[key_val] [nvarchar](500) NOT NULL,
	[content] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
