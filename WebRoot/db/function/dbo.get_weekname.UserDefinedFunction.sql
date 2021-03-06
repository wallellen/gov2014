USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_weekname]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--select dbo.fn_getweekname(getdate())
/*返回星期几*/
create      function [dbo].[get_weekname](@curdate datetime)
returns varchar(50) as  
begin 
declare @daynum int
--declare @result varchar(50)
   set @daynum=datepart(weekday,@curdate)
   return
      case @daynum 
         when  1 then '星期日'
         when 2 then  '星期一'
      when  3 then
         '星期二'
      when  4 then
         '星期三'
      when  5 then
         '星期四'
      when 6 then
         '星期五'
      when  7 then
         '星期六'
      else
          '' 
      end
end
GO
