USE [gov2014]
GO
/****** Object:  View [dbo].[v_fp_chun]    Script Date: 06/17/2014 09:19:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  VIEW [dbo].[v_fp_chun] 
AS 
  SELECT bm,oname from govdata where sid = 32 and pcf=1
GO
