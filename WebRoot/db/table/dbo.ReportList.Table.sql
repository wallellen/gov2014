USE [gov2014]
GO
/****** Object:  Table [dbo].[ReportList]    Script Date: 06/17/2014 09:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportList](
	[SubTag] [varchar](50) NOT NULL,
	[RID] [int] NOT NULL,
	[Title] [varchar](100) NULL,
	[FDT] [varchar](30) NULL,
	[TDT] [varchar](30) NULL,
	[display] [int] NULL,
	[edit] [int] NULL,
 CONSTRAINT [PK__ReportList__3B0BC30C] PRIMARY KEY CLUSTERED 
(
	[SubTag] ASC,
	[RID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
