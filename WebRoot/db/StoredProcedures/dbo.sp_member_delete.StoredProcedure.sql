USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_member_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from familymember
*/
CREATE   proc [dbo].[sp_member_delete](
@account varchar(30),--操作帐号
@hm varchar(30),--当前编码
@mid int--成员编号
)                  
as
begin
declare @str nvarchar(200)
declare @rk int
declare @ll int
   set nocount on
	if (len(@hm)=15) 
	begin
		delete familymember  where hm=@hm and mid = @mid
		select @rk=count(1),@ll=sum(case when labors =1 then 1 else 0 end) from familymember where hm = @hm
		update family set population = @rk,labornum = @ll where hm = @hm
		set @str = 'account['+@account+'] 删除家庭成员['+@hm+','+ltrim(str(@mid))+']信息'
      execute sys_addlog 1,"删除",@account,@str
	end
	
   set nocount off
end
GO
