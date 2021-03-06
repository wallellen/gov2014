USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
*/
CREATE     proc [dbo].[sp_family_update](
@account varchar(30),--操作帐号
@hm varchar(30),--户码
@HName varchar(100),--户名
@zhu varchar(30),--组名称
@Fields float,--耕地
@House float,--住房
@Property int,--家庭属性
@DCause int,--贫困原因
@IDCNo varchar(30),--残疾证号
@TelNum varchar(32),--电话号码
@FrName varchar(60),--帮扶人
@FrTel varchar(60),--帮扶人联系电话
@FrWork varchar(60)--帮扶人职务
)                  
as
begin
declare @str nvarchar(200)
   set nocount on
	if (len(@hm)=15) 
	begin
			update family set hname=@hname,zhu=@zhu,fields=@Fields,house=@House,property=@Property,dcause=@DCause,
				idcno=@IDCNo,telnum=@TelNum,frname=@FrName,frtel=@FrTel,frwork=@FrWork 
			where hm = @hm  
			set @str = 'account['+@account+']更新家庭['+@hm+']信息'
			execute sys_addlog 1,"更新",@account,@str
	end
   set nocount off
end
GO
