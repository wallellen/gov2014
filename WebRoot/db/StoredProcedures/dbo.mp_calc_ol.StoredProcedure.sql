USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_calc_ol]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
根据编码确定档案表中组织结构级别
select * from govdata
execute mp_calc_ol 
*/
CREATE   proc [dbo].[mp_calc_ol]
as
begin
   set nocount on
	update govdata set ol =	case when cid  = 0 then
										case when xxid =0 then
											case when xid = 0 then
												case when ssid = 0 then
													1
												else
													2
												end
											else
												3
											end
										else
											4
										end
									else
										5
									end
   set nocount off
end
GO
