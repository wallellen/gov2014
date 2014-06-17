USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_unitown]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
create   function [dbo].[fn_unitown](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then str(@val)+':省有关部门和单位'
	when @val = 2 then str(@val)+':部省属企业'
     when @val =3 then str(@val)+':部省属有关高校、科研院所'
	else  isnull(str(@val),'null')+':未指定'
end;
--   return @ret
end
GO
