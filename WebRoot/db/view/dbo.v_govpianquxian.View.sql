USE [gov2014]
GO
/****** Object:  View [dbo].[v_govpianquxian]    Script Date: 06/17/2014 09:19:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  VIEW [dbo].[v_govpianquxian]
AS
SELECT a.pqid,a.pqname, b.sid,b.ssid,b.xid,c.OName,c.bm
FROM GovPianQu a INNER JOIN
      GovPianQuXian  b ON a.pqid = b.pqid INNER JOIN
      (select  ssid,xid,bm,oname from GovData where ol = 3) c ON b.ssid = c.ssid and b.xid=c.xid
GO
