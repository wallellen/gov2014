USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_check]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from familycheckinfo 
select top 10 * from family where sid <> 32 
delete family where sid <> 32 
select top 10 * from familymember
exec sp_family_check '320803106201005'
有家庭成员不在6到24周岁且属于在校生

select * from familymember where hm = '320324101001002'
*/

CREATE     proc [dbo].[sp_family_check](
@hm varchar(30)--户码
)                  
as
begin
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @str nvarchar(200)
declare @hname varchar(100)
declare @idcno varchar(20)
declare @telnum varchar(100)
declare @frname varchar(100)
declare @frtel varchar(100)
declare @population int
declare @labornum int
declare @fields float
declare @house float
declare @ret int,@info varchar(200)
set nocount on
declare @t table(code int,info varchar(200))
	if (len(@hm)=15) 
	begin
			if exists(select 1 from family where hm = @hm)
			begin
				select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid=hid,@hname=hname,@idcno=idcno,@telnum=telnum,@frname=frname,@frtel=frtel,
					@population=population,@labornum=labornum,@fields=fields,@house=house from family where hm = @hm
				if not exists(select 1 from govdata where sid=@sid and ssid = @ssid and xid =@xid and xxid = @xxid and cid =@cid)
					insert into @t(code,info) select 1 ,'户码对应的国家编码库不存在'
				if len(@hname)<2
					insert into @t(code,info) select 2,'户主姓名不足2个汉字'
				exec sp_check_idcard @idcno,null,@ret out,@info out
				if @ret > 0
					 insert into @t(code,info) select 3,@info
				if @population <=0 
					insert into @t(code,info) select 4,'家庭人员为至少一人以上'
				if @labornum >@population 
					insert into @t(code,info) select 5,'劳动力大于家庭总人口'
				if @fields >30
					insert into @t(code,info) select 6,'家庭耕地超过30亩'
				if @fields > 0 
					if @fields/@population >8 
						insert into @t(code,info) select 7,'人均耕地超过8亩'
				if @house <10 or @house > 300
					insert into @t(code,info) select 8,'家庭住户面积不足10或超出300平方米'
				if (left(@telnum,2)='02' and len(@telnum)<> 11 ) or (left(@telnum,1)='1' and len(@telnum)<> 11) or 
					(left(@telnum,2)='05' and len(@telnum)<>12)
					insert into @t(code,info) select 9,'家庭联系号码可能存在错误'
				if (len(@frname)<>0 and len(@frname)<2)
					insert into @t(code,info) select 10,'帮扶人姓名不能少于2个汉字'
				if (left(@frtel,2)='02' and len(@frtel)<> 11 ) or (left(@frtel,1)='1' and len(@frtel)<> 11) or (left(@frtel,2)='05' and len(@frtel)<>12)
					insert into @t(code,info) select 11,'帮挂人联系号码可能存在错误'
				if exists(select 1 from familymember where hm = @hm and len(uname)<2 )
					insert into @t(code,info) select 12,'家庭成员姓名不足2汉字'
				if exists(select 1 from familymember where hm = @hm and sex not in (1,2))
					insert into @t(code,info) select 13,'家庭成员性别有误'
				if exists(select 1 from familymember where hm = @hm and age >110)
					insert into @t(code,info) select 14,'有家庭成员年龄超过110岁'
				if exists(select 1 from familymember where hm=@hm and school =1 and (age >24 or age < 6))
					insert into @t(code,info) select 15,'有家庭成员不在6到24周岁且属于在校生'
				if exists(select 1 from familymember where hm=@hm and school = 1 and 
					((age<6 and education <>7) or (age between 6 and 12 and education <>2) or (age between 13 and 15 and education <>3) or 
						(age between 16 and 18 and (education not in (4,5)))))
					insert into @t(code,info) select 16,'有家庭成员为在校生,但文化程度与年龄存在偏差'
				if exists(select 1 from familymember where hm=@hm and len(ltrim(dcno)) not in (0,20))
					insert into @t(code,info) select 17,'有家庭成员残疾证号不符合要求'
				if exists(select 1 from familymember where hm=@hm and hearth = 4 and labors=1)
					insert into @t(code,info) select 18,'有家庭成员健康状况4:患有大病的,还属于劳动力的情况'
				if exists(select 1 from familymember where hm=@hm and ((school = 1 and works <> 0 ) or (labors >1 and works <>0)))
					insert into @t(code,info) select 19,'有家庭成员存属于在校生或非劳动力人员,但有务工情况不合理情况'
				if exists(select 1 from familymember where hm=@hm and bla = 1 and tbfd <=0)
					insert into @t(code,info) select 20,'有家庭成员属于低保人口,但未领取低保金情况'
			end
			else
			begin
				insert into @t(code,info) select 0,'农户编码不存在'
				goto return_t
			end
			
	end
	else
	begin 
		insert into @t(code,info) select 0,'户码长度不符合要求'
		goto return_t
	end
	if exists(select 1 from familycheckinfo where hm=@hm)
		delete  familycheckinfo where hm = @hm
	if not exists(select 1 from @t)
	begin
		update family set ischeck = 1 where hm = @hm -- 审查通过
		insert into @t(code,info) select 100,'审查未发现问题,审核通过'
	end
	else
	begin
		update family set ischeck = 2 where hm=@hm--审查未通过
	end
	insert into familycheckinfo(sid,ssid,xid,xxid,cid,hid,hm,ckdt,code,info) select @sid,@ssid,@xid,@xxid,@cid,@hid,@hm,getdate(),code,info from @t
return_t:
	select * from @t
   set nocount off
end
GO
