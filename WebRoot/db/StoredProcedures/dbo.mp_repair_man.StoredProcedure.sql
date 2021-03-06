USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_repair_man]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
家庭年收入及扶贫情况总收入及人均收入计算
select top 10 * from govdata where ol = 6 and len(oname )>3 and bm = '320803100'
select top 10 * from govdata where bm = '320803'
exec mp_repair_man 1
select top 10 * from govdata where ol = 4 and len(oname )>7
select top 10  * from family where len(hname)>10 
*/
CREATE  proc [dbo].[mp_repair_man](
@ol int, --级别
@olx int
)
as
begin
declare cur cursor  for select oname from govdata where ol = @ol
declare @name varchar(100)
	open cur
	fetch next from cur into  @name
	while(@@fetch_status=0)
	begin
		--select @name
		exec mp_repair @olx,@name
		fetch next from cur into @name
	end
	close cur
	deallocate cur

end
GO
