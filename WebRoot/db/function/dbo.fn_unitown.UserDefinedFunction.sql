USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_unitown]    Script Date: 07/01/2014 09:51:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
select dbo.fn_unitown(1)
*/
ALTER   function [dbo].[fn_unitown](@val int)
returns varchar(50) as  
begin 

return 
	case 
		when @val= 1 then str(@val)+':省有关部门和单位'
		when @val = 2 then str(@val)+':部省属企业'
		when @val =3 then str(@val)+':部省属有关高校、科研院所'
		when @val =4 then str(@val)+':苏南挂钩县'
		when @val =5 then str(@val)+':民营企业'
		when @val =6 then str(@val)+':接对帮扶村'
	else  isnull(str(@val),'null')+':未指定'
	end;
end
