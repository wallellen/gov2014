USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_import]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--drop table family

/*
导入用户家庭基本信息
truncate table family
truncate table govdata
truncate table familymember
truncate table familyyear
select count(1) from family
select count(1) from usermem2014
select * from userdata2014
select count(1) from govdata

select * from usermem2014
select  * from useryeardetail
execute sp_family_import 32,1,1,1,1,1,3,1,2.3,101.3,2,'84868924',5,'320828111122226','张三1','138555555553','WORK1'
*/
CREATE        proc [dbo].[sp_family_import](
@sid int, 			--1省编号 		1:2
@ssid int,			--2市编号		2:2
@xid int, 			--3县编号		3:2
@xxid int,			--4乡镇编号	4:3
@cid int, 			--5村编号		5:3
@hid int,			--6户编号		6:3
@rk int ,			--7人口 		
@ldl int,			--8劳动力
@gd float,        --9耕地
@zf float,	      --10住房
@sx int,				--11农户属性
@dh varchar(30), 	--12电话号码
@pkyy  int,			--13贫困原因
@sfz varchar(20),	--14身份证号码
@bfr varchar(100),--15帮扶人姓名
@bft varchar(32),	--16帮扶人联系号码
@bfw varchar(100)	---17帮扶人职务
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
		set @hid = 0
		--insert into govdata(sid,ssid,xid,xxid,cid,bm,oname) values(@sid,@ssid,@xid,@xxid,@cid,@bmstr,rtrim(@content))
	else
	begin
		set @hmstr = @bmstr + replace(str(@hid,3),' ','0')
		if exists(select 1 from family where sid=@sid and ssid =@ssid and xid =@xid and xxid = @xxid and cid =@cid and hid = @hid)
			update family set Population=@rk,labornum =@ldl,Fields=@gd,House=@zf,property = @sx,dcause = @pkyy,idcno = rtrim(@sfz),
				telnum=rtrim(@dh),frname = rtrim(@bfr),frtel=rtrim(@bft),frwork = rtrim(@bfw) 
      		where sid=@sid and ssid =@ssid and xid =@xid and xxid = @xxid and cid =@cid and hid = @hid
		else
			insert into family(sid,ssid,xid,xxid,cid,hid,hm,Population,labornum,fields,house,property,dcause,idcno,telnum,frname,frtel,frwork) 
				values(@sid,@ssid,@xid,@xxid,@cid,@hid,@hmstr,@rk,@ldl,@gd,@zf,@sx,@pkyy,rtrim(@sfz),rtrim(@dh),rtrim(@bfr),rtrim(@bft),rtrim(@bfw))
	end
   set nocount off
end
GO
