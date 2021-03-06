USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[sys_getparamex]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.sys_getparamex('cc_server','baseconfig')
*/



CREATE   FUNCTION [dbo].[sys_getparamex](@segment varchar(100),@keyname varchar(100))
RETURNS  varchar(2000) AS  
BEGIN 
declare @paramstr varchar(1000)
declare @ret_str varchar(1000)
declare @itemnum int
declare @itemstr varchar(1000)
declare @fieldname varchar(100)
declare @fieldvalue varchar(200)
declare @cn int
   
   set @paramstr  = dbo.sys_getparam(@segment,@keyname)
   set @itemnum = dbo.get_itemcount(@paramstr,';')
   set @cn = 0 
   while @cn < @itemnum
   begin
      set @itemstr = dbo.get_itemstr(@paramstr,@cn+1,';')
      set @fieldname = dbo.get_itemstr(@itemstr,1,'=')
      set @fieldvalue = dbo.get_itemstr(@itemstr,2,'=')
--      select @fieldvalue
      if @cn = 0 
      set @ret_str = @fieldvalue +' '+@fieldname
      else
         set @ret_str = @ret_str +','+ @fieldvalue +' '+@fieldname
      set @cn=@cn +1
   end
   return @ret_str
--    return (select key_val from sys_param where segment = @segment and key_name = @keyname)
END
GO
