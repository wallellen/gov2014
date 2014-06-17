USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_labor]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_labor(1)
*/
CREATE     function [dbo].[fn_labor](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':劳动力'
  when @val=2 then ltrim(str(@val))+':丧失劳动力'
  when @val=3 then ltrim(str(@val))+':非劳动力'
  else  ltrim(str(@val))+':未指定'
end;
--   return @ret
end
GO
