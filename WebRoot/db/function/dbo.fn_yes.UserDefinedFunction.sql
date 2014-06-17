USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_yes]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_yes(1)
*/
CREATE    function [dbo].[fn_yes](@val int)
returns varchar(50) as  
begin 
  
return 
  case when @val= 1 then ltrim(str(@val))+':是'

  else  ltrim(str(@val))+':否'
end;
end
GO
