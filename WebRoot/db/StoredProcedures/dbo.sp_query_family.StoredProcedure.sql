USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_query_family]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
农户信息报告输出
select top 10 * from govdata
select top 10 * from family
exec sp_query_familyex 'admin',3208,'',null
exec sp_query_familyex 'admin',3208,';;>=3;;;;;;>=1000;2013',null
*/
CREATE      proc [dbo].[sp_query_family](
@account varchar(30),--帐号
@curbm varchar(20),--当前编码
@qstr varchar(200),--查询字符串
@nt int out--查得的农户总数
)
as
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @hms varchar(60)
declare @sql nvarchar(500)
declare @sqlx nvarchar(500)
declare @cn int
declare @itemstr varchar(100)--分项字符串
declare @itemcn int
declare @instr varchar(50)
declare @perstr varchar(50)
declare @year varchar(10)
begin
set nocount on
	if exists(select 1 from govdata where bm =@curbm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @curbm
		--
		set @sql='select hm,dbo.fn_govname(hm) govname,hname from family'
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
			when 0 then 
				case when len(@itemstr)>0 then ' and hm like ''%'+@itemstr+'%''' else '' end
			when 1 then 
				case when len(@itemstr)>0 then ' and hname like ''%'+@itemstr+'%''' else '' end
			when 2 then
				case when len(@itemstr)>0 then ' and population'+@itemstr else '' end
			when 3 then 
				case when len(@itemstr)>0 then ' and labornum'+@itemstr else '' end
			when 4 then 
				case when len(@itemstr)>0 then ' and property='+@itemstr else '' end
				
			when 5 then 
				case when len(@itemstr)>0 then ' and house'+@itemstr else '' end
			when 6 then 
				case when len(@itemstr)>0 then ' and fields'+@itemstr else '' end
			when 7 then
				case when len(@itemstr)>0 then ' and dcause='+@itemstr else '' end
			when 8  then ''
			when 9 then ''
			when 10 then ''
			else ''
			end
			if @cn = 8 set @instr = @itemstr
			if @cn =9 set @perstr = @itemstr
			if @cn =10 set @year = @itemstr
			set @cn=@cn+1
		end
		if(len(@year)>0 and(len(@instr)>0 or len(@perstr)>0))
		begin
			--统计年数据
			set @sqlx = 'select @a=count(1) from ('+@sql+') a join (select hm from familyyear where year='+@year
			+case when len(@instr)>0 then ' and inTotal'+@instr else '' end
			+case when len(@perstr)>0 then ' and inPersonal'+@perstr else '' end
				+') b on a.hm=b.hm'
			--
			exec sp_executesql @sqlx,N'@a int output',@nt output
			set @sql = 'select top 100 a.* from ('+@sql+') a join (select hm from familyyear where year='+@year
			+case when len(@instr)>0 then ' and inTotal'+@instr else '' end
			+case when len(@perstr)>0 then ' and inPersonal'+@perstr else '' end
				+') b on a.hm=b.hm'
		end
		else
		begin
			set @sqlx = 'select @a=count(1) '+right(@sql,len(@sql)-42)
			exec sp_executesql @sqlx,N'@a int output',@nt output
			set @sql = 'select top 500 ' + right(@sql,len(@sql)-6)
		end
		exec(@sql)
	end
set nocount off
end
GO
