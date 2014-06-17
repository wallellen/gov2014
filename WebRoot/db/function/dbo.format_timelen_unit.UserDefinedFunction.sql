USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[format_timelen_unit]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*获得时长的转换单位*/
create        function [dbo].[format_timelen_unit](@timelen int)
returns varchar(50) as  
begin 
--declare @ret varchar(100)
   if @timelen <60 
      return  '秒'
   else if @timelen < 1000*60
      return '分钟'
   else
      return '小时'
   return ''
end
GO
