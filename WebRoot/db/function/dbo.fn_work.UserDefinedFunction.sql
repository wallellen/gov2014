USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_work]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE    function [dbo].[fn_work](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':在家务家'
  when @val=2 then ltrim(str(@val))+':县内务工'
  when @val=3 then ltrim(str(@val))+':县外省内务工'
  when @val = 4 then ltrim(str(@val))+':省外务工'
  when @val = 5 then ltrim(str(@val))+':其他(国外)'
  else  ltrim(str(@val))+':未指定'
end;
--   return @ret
end
GO
