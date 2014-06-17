USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[and_con_str]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create   FUNCTION [dbo].[and_con_str](@col_name varchar(32),@varval varchar(500))
RETURNS varchar(500)
AS 
BEGIN 
   return 
      case when @varval is null then ''
      else
         ' and ('+@col_name +' like ''%'+@varval+'%'')'
      end          
END
GO
