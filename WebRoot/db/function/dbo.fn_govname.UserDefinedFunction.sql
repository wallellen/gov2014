USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_govname]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select top 10 * from govdata
select dbo.fn_govname('320803100015003')
*/
CREATE function [dbo].[fn_govname](@hm varchar(20))
returns varchar(100) as  
begin 
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @govname varchar(100)
set @govname=''
if len(@hm) = 15 
begin
	select @sid = left(@hm,2),@ssid=substring(@hm,3,2),@xid = substring(@hm,5,2),@xxid=substring(@hm,7,3),@cid = substring(@hm,10,3)
	select @govname=oname from govdata where sid = @sid and ssid=0
	select @govname=@govname+ oname from govdata where sid = @sid and ssid=@ssid and xid=0
	select @govname=@govname+ oname from govdata where sid = @sid and ssid=@ssid and xid=@xid and xxid=0
	select @govname=@govname+ oname from govdata where sid = @sid and ssid=@ssid and xid=@xid and xxid=@xxid and cid =0
	select @govname=@govname+ oname from govdata where sid = @sid and ssid=@ssid and xid=@xid and xxid=@xxid and cid =@cid
	return @govname
end
return @govname
end
GO
