USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_sysright_save]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
*/
Create  proc [dbo].[sp_sysright_save](
@account varchar(30),--操作帐号
@bm	varchar(30),--要查询的编码号
@edit int--当前新的edit值
)
as
begin
declare @len int
	set @len = len(@account)
	if @account = left(@bm,@len) 
	begin
	if exists(select 1 from govdata where bm=@bm)
	begin
		update govdata set edit = @edit where bm =@bm
	end
	end
   
end
GO
