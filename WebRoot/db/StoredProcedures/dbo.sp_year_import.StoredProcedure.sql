USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_import]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
导入农户家庭年收入明细数据
execute sp_year_import 32,1,1,1,1,1,3,1,2.3,101.3,2,'84868924',5,'320828111122226','张三1','138555555553','WORK1'
*/
CREATE     proc [dbo].[sp_year_import](
@sid int, 			--1省编号 		1:2
@ssid int,			--2市编号		2:2
@xid int, 			--3县编号		3:2
@xxid int,			--4乡镇编号	4:3
@cid int, 			--5村编号		5:3
@hid int,			--6户编号		6:3
@year int,			--2年份
@Total float,		--3全年总收入
@Crop float,		--4种植业
@Livstock float,	--5养殖业
@Work float,		--6务工
@Bla float,			--7领取低保、五保、养老收入
@subSide float,	--8补贴性收入
@Other float,		--9其他收入
@Personal float,	--10家庭人均收入
@aid float,			--11无偿帮扶资金
@share float,		--12得到股份
@loan float,		--13小额贷款和互助资金
@Train int,			--14劳动力转移培训
@Job int				--15劳动力转移就业人数
)                  
as
begin
declare @bmstr varchar(32)
declare @hmstr varchar(32)
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
	set @hmstr = @bmstr + replace(str(@hid,3),' ','0')
	insert into familyyear(sid,ssid,xid,xxid,cid,hid,hm,year,intotal,incrop,inlivstock,inwork,inbla,insubside,inother,inPersonal,grantaid,share,pettyloan,labtrain,labjob)
		values(@sid,@ssid,@xid,@xxid,@cid,@hid,@hmstr,@year,@total,@crop,@livstock,@work,@bla,@subside,@other,@Personal,@aid,@share,@loan,@train,@Job)
   set nocount off
end
GO
