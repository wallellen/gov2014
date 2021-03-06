USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_itemcount]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*获取指定字符为分隔的项目个数*/
CREATE     FUNCTION [dbo].[get_itemcount](@str varchar(2000),@split varchar(10))
RETURNS int AS  
BEGIN 
declare @leavestr varchar(1000)
declare @pos int
declare @len int
declare @itemnum int
   select @leavestr = @str
   select @len = len(@str),@itemnum =0
   if @len>0
   begin
      while( 1=1)
      begin
         select @pos = charindex(@split,@leavestr)
         if @pos =0
            return @itemnum+1
         else
         begin
            select @leavestr = right(@leavestr,@len-@pos)
            select @itemnum = @itemNum +1
            select @len = len(@leavestr)
            if @len =0 
               return @itemNum
         end
      end
   end
   else
      return 0;
   return 1
END
GO
