USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_check]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
对指定农户指定年份数据进行审查
*/

CREATE proc [dbo].[sp_year_check](
@hm varchar(30),--户码
@year int--要检查的年份
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
declare @idcno varchar(20)
declare @population int
declare @labornum int
declare @fields float
declare @house float
declare @ret int,@info varchar(200)
declare @incrop float
declare @inwork float
declare @inBla float
declare @workn int--打工人数
declare @inBlaM float--家庭成员总和
declare @oldman int--老年人口数
declare @insubside float--补贴性收入
set nocount on
declare @t table(code int,info varchar(200))
	if (len(@hm)<>15) 
	begin
		insert into @t(code,info) select 0,'农户编码长度有错误'
		goto return_t
	end
	if not exists(select 1 from family where hm = @hm)
	begin
		insert into @t(code,info) select 0,'农户编码不存在'
		goto return_t
	end
	if not exists(select 1 from familyyear where hm =@hm and year =@year)
	begin
		insert into @t(code,info) select 0,'所指定的农户年数据不存在'
		goto return_t
	end
	select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@hid=hid,@idcno=idcno,
					@population=population,@labornum=labornum,@fields=fields,@house=house from family where hm = @hm
	select @incrop =isnull(incrop,0),@inwork=inwork,@inbla=inbla,@insubside=insubside from familyyear where year = @year
	if @fields >0
		if @incrop /@fields <700
			insert into @t(code,info) select 0,'平均每亩收入不足700元'	
	
		select @workn=count(1),@inBlaM=sum(bla)+sum(case when age>=60 then 1 else 0 end)*960 from familymember where works>1 and hm = @hm
		if @workn >0
			if @inwork/@workn <500
					insert into @t(code,info) select 0,'有务工人员，但人均务工收入不足500元'
		if @inbla < @inBlam 
			insert into @t(code,info) select 0,'低保、五保、养老金收入不应低于成员中领取低保、五保、残疾金及60岁以上人口每人960元之和'	
		if @insubside < @fields * 100
			insert into @t(code,info) select 0,'补贴性收入不应低于承包耕地面积乘以100'	
			
return_t:
	select * from @t
   set nocount off
end
GO
