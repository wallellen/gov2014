USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Reason]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE   function [dbo].[fn_Reason](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then str(@val)+':因灾'
	when @val = 2 then str(@val)+':因病'
     when @val =3 then str(@val)+':因残'
	when @val =4 then str(@val)+':因学'
	when @val = 5  then str(@val)+':缺技术'
	when @val  =6 then str(@val)+':缺劳动力'
	when @val = 7  then str(@val)+':缺资金'
	when @val = 8 then str(@val)+':其它'
	else  isnull(str(@val),'null')+':未指定'
end;
--   return @ret
end
GO
