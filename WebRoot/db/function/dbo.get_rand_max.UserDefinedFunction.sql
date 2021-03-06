USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_rand_max]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create   FUNCTION [dbo].[get_rand_max](@maxval int) 
RETURNS int 
AS 
  BEGIN 
    return cast(floor(dbo.get_rand()*@maxval) as int)
  END
GO
