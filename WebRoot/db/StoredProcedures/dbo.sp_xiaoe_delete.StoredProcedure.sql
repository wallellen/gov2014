USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_xiaoe_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
小额贷款省县查看
exec sp_xiaoe_update '320803',2013,0,10,100,0,0,10,100,0,0,0
exec sp_report_list 'xianxiaoe_item',0
select * from reportlist  where subtag = 'xianxiaoe_item'
select * from xianxiaoe
*/
Create  proc [dbo].[sp_xiaoe_delete](
@bm varchar(20),--查询的县编码
@year int,--年份
@month int--月份
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		if @l = 3 --县级帐号
		begin
			delete xianxiaoe where sid = @sid and ssid =@ssid and xid =@xid and year = @year and month =@month
		end
	end
set nocount off
end
GO
