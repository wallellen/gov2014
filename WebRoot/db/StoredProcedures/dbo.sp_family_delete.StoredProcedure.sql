USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
select top 10 * from familymember
*/
CREATE  proc [dbo].[sp_family_delete](
@account varchar(30),--操作帐号
@hm varchar(30),--户码
@cause int--删除原因
)                  
as
begin
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @str nvarchar(200)
   set nocount on
	if (len(@hm)=15) 
	begin
			if exists(select 1 from family where hm = @hm)
			begin
				select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid=hid from family where hm = @hm
				delete family where hm = @hm
				delete familymember where hm = @hm
				set @str = 'account['+@account+']删除家庭及成员信息['+@hm+']信息,原因:'+ltrim(str(@cause))
				execute sys_addlog 1,"删除",@account,@str
				insert into familylog(sid,ssid,xid,xxid,cid,hid,opa,hm,odt,cause) values(@sid,@ssid,@xid,@xxid,@cid,@hid,2,@hm,getdate(),@cause) 
			end
	end
   set nocount off
end	
select  * from familylog
GO
