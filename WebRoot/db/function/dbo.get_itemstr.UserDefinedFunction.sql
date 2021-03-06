USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_itemstr]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*获取指定位置字符串
select dbo.get_itemstr('aaaa;bbbb;ccc',2,';')
*/
CREATE     FUNCTION [dbo].[get_itemstr](@str varchar(1000),@pos int,@split varchar(16))
RETURNS varchar(500) AS  
BEGIN 
declare @itemnum int
declare @cn int
declare @spos int
declare @len int
declare @leavestr varchar(1000)
   select @itemnum = dbo.get_itemcount(@str,@split)
   if @itemnum <@pos return ''
   select @cn = @pos-1,@leavestr = @str,@spos=0
   --
   while @cn >0
   begin
      select @len = len(@leavestr)
      select @spos = charindex(@split,@leavestr)
      select @leavestr = right(@leavestr,@len - @spos)
      select @cn = @cn -1
   end
   select @spos = charindex(@split,@leavestr)
   if @spos > 0
      select @leavestr = left(@leavestr,@spos-1)
   --
   return @leavestr
END
GO
