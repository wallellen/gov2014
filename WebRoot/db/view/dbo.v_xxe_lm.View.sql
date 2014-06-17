USE [gov2014]
GO
/****** Object:  View [dbo].[v_xxe_lm]    Script Date: 06/17/2014 09:19:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[v_xxe_lm]
AS 
  select a.sid,a.ssid,a.xid,a.year,a.month,b.th,b.tv,b.nh,b.nv,b.eh,b.ev from (select sid,ssid,xid,year,max(month) month from xianxiaoe  group by sid,ssid,xid ,year) a join xianxiaoe b 
		on a.sid=b.sid and a.ssid=b.ssid and a.xid =b.xid and a.year=b.year and a.month = b.month
GO
