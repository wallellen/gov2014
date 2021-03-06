USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_hourfang_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
删除省级后方单位挂钩帮扶情况表记录
select  * from xianhoufang
exec sp_hourfang_delete '320803',1
select * from govdata where bm = '320803'
*/
CREATE     proc [dbo].[sp_hourfang_delete](
@xm varchar(20),--项目所属县码
@rid int,--报告编号
@iid int --项目编号
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
 set nocount on
	if exists(select 1 from govdata where bm =@xm) and len(@xm)= 6
	begin
			select @sid=sid,@ssid=ssid,@xid=xid from govdata where bm = @xm
			delete XianHouFang 
				where sid=@sid and ssid = @ssid and xid = @xid and rid = @rid and iid = @iid
	end
set nocount off
end
GO
