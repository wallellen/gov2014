USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_jiangbu_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
奖补到户信息更新及插入
exec sp_jiangbu_list '320829102201',1
exec sp_jiangbu_update '320829102201004',1,2,1,1,1,1,1,1,1,1,1,1
exec sp_jiangbu_list   '320829102201',1
exec sp_jiangbu_update '320829102201004',1,1,2,3,4,5,6,7,8,9,10,111
exec sp_jiangbu_update '320829102201002',1,1,1,1,1,1,1,1,1,1,0,0

select * from family where hm like '320703001200%'
*/
create  proc [dbo].[sp_jiangbu_delete](
@hm varchar(20),--当前编码
@rid int--批次号
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int
declare @l int
declare @sql nvarchar(500)
declare @v int
 set nocount on
	if exists(select 1 from family where hm =@hm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid=hid from family where hm = @hm
		delete  familyjiangbu where sid = @sid and ssid=@ssid 
						and xid = @xid and xxid=@xxid and cid=@cid and hid=@hid and rid = @rid
	end
set nocount off
end
GO
