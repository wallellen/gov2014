USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_education]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE    function [dbo].[fn_education](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':文盲、半文盲'
	when @val = 2 then ltrim(str(@val))+':小学'
     when @val =3 then ltrim(str(@val))+':初中'
	when @val =4 then ltrim(str(@val))+':高中'
	when @val = 5  then ltrim(str(@val))+':中专'
	when @val  =6 then ltrim(str(@val))+':大专以上'
	when @val  =7 then ltrim(str(@val))+':学龄儿童'
  else  ltrim(str(@val))+':未指定'
end;
--   return @ret
end
GO
