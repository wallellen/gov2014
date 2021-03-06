USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_setparam]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*系统参数表维护
exec sys_setparam 'system','lockyear','0'
*/
CREATE     proc [dbo].[sys_setparam](
@segment varchar(64),     --参数段信息
@key varchar(64),         --参数Key
@val varchar(1000)        --参数值
) as
begin
   set nocount on
   if exists(select 1 from sys_param where segment = @segment and key_name = @key)
      update sys_param set key_val = @val where segment =@segment and key_name =@key
   else
      insert sys_param(segment,key_name,key_val) values (@segment,@key,@val)
   set nocount off
end
GO
