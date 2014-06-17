USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[format_timelen_val]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*获得时长的按转换比率得到的数值*/
create      function [dbo].[format_timelen_val](@timelen int,@rate int)
returns int as  
begin 
   return @timelen / @rate
end
GO
