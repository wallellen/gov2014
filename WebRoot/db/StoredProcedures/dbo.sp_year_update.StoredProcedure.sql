USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
*/
CREATE     proc [dbo].[sp_year_update](
@account varchar(30),--操作帐号
@hm varchar(30),--当前编码
@year int,--年份
@inCrop float,
@inLovStock float,
@inWork float,
@inBla float,
@inSubSide float,
@inOther float,
@grantAid float,
@share float,
@pettyLoan float,
@labTrain int,
@labJob int
)                  
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @intotal float
declare @inPersonal float
declare @rk int
declare @str nvarchar(200)
   set nocount on
	if (len(@hm)=15) 
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid =hid,@rk =population from family where hm = @hm
		set @intotal = @inCrop+@inLovStock+@inWork+@inBla+@inSubSide+@inOther
		set @inPersonal = case when @rk >0 then @intotal/@rk else @intotal end
		update familyyear set  intotal=@intotal,inpersonal=@inpersonal,incrop=@inCrop,inlivstock=@inLovStock,inwork=@inWork,inbla=@inBla,insubside=@inSubSide,
			inother=@inOther,grantaid=@grantAid,share=@share,pettyloan=@pettyLoan,labtrain=@labTrain,labjob=@labJob
		where hm=@hm and year = @year
		set @str = 'account['+@account+'] 更新年['+@hm+','+ltrim(str(@year))+']数据'
		execute sys_addlog 1,"更新",@account,@str
	end
   set nocount off
end
GO
