USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_sex]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.fn_sex(1)
*/
CREATE     function [dbo].[fn_sex](@sex int)
returns varchar(50) as  
begin 
  
return 
  case when @sex= 1 then ltrim(str(@sex))+':男'
  else  ltrim(str(@sex))+':女'
end;
--   return @ret
end
GO
