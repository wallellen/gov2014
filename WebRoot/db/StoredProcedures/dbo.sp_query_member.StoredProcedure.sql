USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_query_member]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
人口查询信息报告输出
select top 10 * from govdata where pf = 1 
select top 10 * from family
select top 10 * from familymember
exec sp_query_familyex 'admin',3208,'',null
exec sp_query_member 'admin',3208,'张;2;>=50;2;4;1;1;1;1;',null
*/
CREATE   proc [dbo].[sp_query_member](
@account varchar(30),--帐号
@curbm varchar(20),--当前编码
@qstr varchar(200),--查询字符串
@nt int out--查得的人口总数
)
as
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @hms varchar(60)
declare @sql nvarchar(1000)
declare @sqlx nvarchar(500)
declare @cn int
declare @itemstr varchar(100)--分项字符串
declare @itemcn int
declare @instr varchar(50)
declare @perstr varchar(50)
--declare @year varchar(10)
begin
set nocount on
	if exists(select 1 from govdata where bm =@curbm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @curbm
		--
		set @sql='select top 100 hm,dbo.fn_govname(hm) govname,uname,dbo.fn_sex(sex) sex,age,dbo.fn_yes(school) school,'
		+'dbo.fn_education(education) education,'
		+'dbo.fn_healthy(hearth) hearth,dcno,dbo.fn_labor(labors) labors,dbo.fn_work(works) works,dbo.fn_yes(bla) bla, tbfd  from familymember'
		--
		+' where sid='+ltrim(str(@sid))
		+case when @l >1 then ' and ssid='+ltrim(str(@ssid)) else '' end
		+case when @l>2 then ' and xid='+ltrim(str(@xid)) else '' end
		+case when @l>3 then ' and xxid='+ltrim(str(@xxid)) else '' end
		+case when @l>4 then ' and cid='+ltrim(str(@cid)) else '' end
		--
		set @itemcn = dbo.get_itemcount(@qstr,";")
		set @cn =0
		while(@cn<@itemcn)
		begin
			set @itemstr = dbo.get_itemstr(@qstr,@cn+1,";")
			set @sql =@sql +
			case @cn
			when 0 then --姓名
				case when len(@itemstr)>0 then ' and uname like ''%'+@itemstr+'%''' else '' end
			when 1 then --性别
				case when len(@itemstr)>0 then ' and sex='+@itemstr else '' end
			when 2 then --年龄
				case when len(@itemstr)>0 then ' and age'+@itemstr else '' end
			when 3 then --在校生
				case when len(@itemstr)>0 then ' and school='+@itemstr else '' end
			when 4 then --文化程度
				case when len(@itemstr)>0 then ' and education='+@itemstr else '' end
			when 5 then --身体状况
				case when len(@itemstr)>0 then ' and hearth='+@itemstr else '' end
			when 6 then 
				case when len(@itemstr)>0 then ' and labors='+@itemstr else '' end
			when 7 then
				case when len(@itemstr)>0 then ' and works='+@itemstr else '' end
			when 8  then 
				case when len(@itemstr)>0 then ' and bla='+@itemstr else '' end
			end
			set @cn=@cn+1
		end
		set @sqlx = 'select @a=count(1) '+right(@sql,len(@sql)-252)
		exec sp_executesql @sqlx,N'@a int output',@nt output
		exec(@sql)
	end
set nocount off
end
GO
