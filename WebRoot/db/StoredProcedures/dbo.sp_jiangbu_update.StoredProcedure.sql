USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_jiangbu_update]    Script Date: 06/17/2014 09:13:20 ******/
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
CREATE      proc [dbo].[sp_jiangbu_update](
@hm varchar(20),--当前编码
@rid int,--批次号
@T1 int,--1/0
@T2 int,--1/0
@T3 int,--1/0
@T4 int,--1/0
@T5 int,--1/0
@T6 int,--1/0
@T7 int,--1/0
@V1 int,--省级财政奖补资金(元)
@V2 int,--地方财政(元)
@V3 int,--挂钩帮扶单位(元)
@B1 int--1/0
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
		set @v = @v1+@v2+@v3
		if exists(select 1 from familyjiangbu where sid = @sid and ssid=@ssid 
						and xid = @xid and xxid=@xxid and cid=@cid and hid=@hid and rid = @rid)
		begin
			update familyjiangbu set t1 = @t1,t2=@t2,t3=@t3,t4=@t4,t5=@t5,t6=@t6,t7=@t7,v=@v,v1=@v1,v2=@v2,v3=@v3,b1=@b1  
				where sid = @sid and ssid=@ssid 
						and xid = @xid and xxid=@xxid and cid=@cid and hid =@hid and rid = @rid
		end
		else
		begin
			insert into familyjiangbu(sid,ssid,xid,xxid,cid,hid,rid,hm,t1,t2,t3,t4,t5,t6,t7,v,v1,v2,v3,b1) 
				values(@sid,@ssid,@xid,@xxid,@cid,@hid,@rid,@hm,@t1,@t2,@t3,@t4,@t5,@t6,@t7,@v,@v1,@v2,@v3,@b1)
		end
	end
set nocount off
end
GO
