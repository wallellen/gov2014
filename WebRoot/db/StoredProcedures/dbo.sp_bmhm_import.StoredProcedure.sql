USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bmhm_import]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
组织结构编码及客户编码信息导入
truncate table govdata
truncate table family
select top 100  oname,len(oname) len  from govdata
select * from family
select top 10 * from govdata
select top 100 hname,len(hname) len   from userdata2014
execute sp_bmhm_import 32,1,1,1,1,1,'AAA'
select replace(str(2,2),
select convert(2,2,0)
select right(cast(power(10,3) as varchar)+33,3)
*/
CREATE          proc [dbo].[sp_bmhm_import](
@sid int,--省编号 		1:2
@ssid int,--市编号		2:2
@xid int,--县编号		3:2
@xxid int,--乡镇编号	4:3
@cid int,--村编号		5:3
@hid int,--户编号		6:3
@content varchar(200)--名称及文本
)                  
as
begin
declare @bmstr varchar(32)
declare @hmstr varchar(32)
declare @rn int
   set nocount on
	set @bmstr = str(@sid,2)+
		case when @ssid >0 then str(@ssid,2)+
			case when @xid >0 then str(@xid,2) +
				case when @xxid >0 then str(@xxid,3)+
					case when @cid >0 then str(@cid,3)
					else ''
					end
				else ''
				end
			else ''
			end
		else ''
		end
	set @bmstr=replace(@bmstr,' ','0')
	if @hid = 0 
		insert into govdata(sid,ssid,xid,xxid,cid,bm,oname) values(@sid,@ssid,@xid,@xxid,@cid,@bmstr,rtrim(@content))
	else
	begin
		set @hmstr = @bmstr + replace(str(@hid,3),' ','0')
		if exists(select 1 from family where sid=@sid and ssid =@ssid and xid =@xid and xxid = @xxid and cid =@cid and hid = @hid)
			update family set hname = rtrim(@content) where sid=@sid and ssid =@ssid and xid =@xid and xxid = @xxid and cid =@cid and hid = @hid
		else
			insert into family(sid,ssid,xid,xxid,cid,hid,hm,hname) values(@sid,@ssid,@xid,@xxid,@cid,@hid,@hmstr,rtrim(@content))
		
	end
   set nocount off
end
GO
