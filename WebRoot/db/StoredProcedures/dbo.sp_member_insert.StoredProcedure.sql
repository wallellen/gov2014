USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_member_insert]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
*/
CREATE        proc [dbo].[sp_member_insert](
@account varchar(30),--操作帐号
@hm varchar(30),--当前编码
@uname varchar(60),
@sex int,
@year int,--出生年份
@school int,
@Education int,
@Hearth int,
@dcno varchar(60),
@labor int,
@work int,
@bla int,
@tbfd int
)                  
as
begin
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @mid int
declare @str nvarchar(200)
declare @rk int
declare @ll int
declare @age int
set nocount on
	set @age =year(getdate())-@year
	if (len(@hm)=15) 
	begin
		if exists(select 1 from family where hm = @hm)
		begin
			select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid=hid from family where hm = @hm
			select @mid=isnull(max(mid),0)+1 from familymember where hm=@hm
			if @mid <1000 
			begin
				insert into familymember(sid,ssid,xid,xxid,cid,hid,mid,hm,uname,sex,age,byear,school,education,hearth,dcno,labors,works,bla,tbfd)
					values(@sid,@ssid,@xid,@xxid,@cid,@hid,@mid,@hm,@uname,@sex,@age,@year,@school,@Education,@Hearth,@dcno,@labor,@work,@bla,@tbfd)
				select @rk=count(1),@ll=sum(case when labors =1 then 1 else 0 end) from familymember where hm = @hm
				update family set population = @rk,labornum = @ll where hm = @hm
				set @str = 'account['+@account+'] 添加家庭成员['+@hm+','+ltrim(str(@mid))+']'
				execute sys_addlog 1,"添加",@account,@str	
			end
		end
	end
	
   set nocount off
end
GO
