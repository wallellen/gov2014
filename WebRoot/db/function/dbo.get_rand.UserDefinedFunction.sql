USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_rand]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create   FUNCTION [dbo].[get_rand]( ) 
RETURNS FLOAT 
AS 
  BEGIN 
    RETURN (SELECT r_n 
     FROM   v_vt_rand) 
  END
GO
