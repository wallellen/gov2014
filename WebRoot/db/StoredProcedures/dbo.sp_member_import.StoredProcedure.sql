USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_member_import]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--drop table familymember
/*
农户家庭成员信息导入
select * from familymember where hm like '321202001016001%'
truncate table familymember
execute sp_member_import '321202001016001','2',3,4,5,6,7,8,9,10,11,12
*/
CREATE             proc [dbo].[sp_member_import](
@hms varchar(20),	--1农户编码
@name varchar(60),--2姓名
@sex int,			--3性别
@age int,			--4年龄
@iss int,			--5是否在校生
@edu int,			--6文化程度
@hth int,			--7身体状况
@cno varchar(30),	--8残疾证号
@lbl int,			--9劳动力状况
@work int,			--10打工状况
@islow int,			--11是否为低保人口
@hs float			--12领取金额
)                  
as
begin
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @mid int
declare @rn int
declare @curyear int--当前年份
   set nocount on
	set @curyear = 2013
	select @sid=convert(int,left(@hms,2)),@ssid=convert(int,substring(@hms,3,2)),@xid=convert(int,substring(@hms,5,2)),
		@xxid=convert(int,substring(@hms,7,3)),@cid=convert(int,substring(@hms,10,3)),@hid=convert(int,substring(@hms,13,3))
	select @mid =isnull(max(mid),0)+1 from familymember where sid=@sid and ssid=@ssid and xid = @xid and xxid = @xxid and cid=@cid and hid = @hid
select @sid,@ssid,@xid,@xxid,@cid,@hid,@mid,@hms
	insert into familymember(sid,ssid,xid,xxid,cid,hid,mid,hm,uname,sex,age,byear,school,education,hearth,dcno,labors,works,bla,tbfd)
		values(@sid,@ssid,@xid,@xxid,@cid,@hid,@mid,@hms,rtrim(@name),@sex,@age,@curyear-@age,@iss,@edu,@hth,rtrim(@cno),@lbl,@work,@islow,@hs)

   set nocount off
end
GO
