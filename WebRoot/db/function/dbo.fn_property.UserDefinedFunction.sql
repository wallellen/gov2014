USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_property]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE     function [dbo].[fn_property](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':扶贫户'
	when @val = 2 then ltrim(str(@val))+':低保户'
	when @val = 3 then ltrim(str(@val))+':五保户'
   else  isnull(ltrim(str(@val)),'null')+':未指定'
end;
--   return @ret
end
GO
