USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[format_timelen_rate]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*获得通话时长的转换系数*/
create       function [dbo].[format_timelen_rate](@timelen int)
returns int as  
begin 
declare @ret varchar(100)
   if @timelen <60 
      return 1
   else if @timelen < 1000*60
      return 60
   else
      return 3600
   return 0
end
GO
