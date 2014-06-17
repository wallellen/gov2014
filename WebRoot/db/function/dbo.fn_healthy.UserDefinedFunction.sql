USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_healthy]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE  function [dbo].[fn_healthy](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':健康'
	when @val = 2 then ltrim(str(@val))+':体弱多病'
     when @val =3 then ltrim(str(@val))+':长期慢性病'
	when @val =4 then ltrim(str(@val))+':患有大病'
	when @val =5 then ltrim(str(@val))+':残疾人'
  else ltrim(str(@val))+':未指定'
end;
--   return @ret
end
GO
