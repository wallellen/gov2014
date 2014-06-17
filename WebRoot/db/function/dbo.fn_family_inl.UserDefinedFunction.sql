USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_family_inl]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
家庭收入分级
*/
create function [dbo].[fn_family_inl](@val float)
returns int as  
begin 
  
return 
  case when @val<300 then 0
  when @val<3500 then 1
  when @val < 4000 then 2
  else  3
end;
--   return @ret
end
GO
