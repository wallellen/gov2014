USE [gov2014]
GO
/****** Object:  View [dbo].[v_vt_rand]    Script Date: 06/17/2014 09:19:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_vt_rand] 
AS 
  SELECT Rand() AS r_n
GO
