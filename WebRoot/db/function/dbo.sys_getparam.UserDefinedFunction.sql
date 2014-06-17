USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[sys_getparam]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.sys_getparam ("system",'workyear')
*/

CREATE       FUNCTION [dbo].[sys_getparam](@segment varchar(100),@keyname varchar(100))
RETURNS varchar(2000) AS  
BEGIN 
    return (select key_val from sys_param where segment = @segment and key_name = @keyname)
END
GO
