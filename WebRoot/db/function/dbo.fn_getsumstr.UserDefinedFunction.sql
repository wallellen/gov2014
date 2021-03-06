USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_getsumstr]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*

select top 10 * from familymember
select dbo.fn_getsumstr('sex',2)
*/
CREATE  function [dbo].[fn_getsumstr](@fields varchar(60),@itn int)
returns varchar(500) as  
begin
declare @cn int 
declare @str varchar(500)
	set @cn = 0
	set @str=''
	while @cn <@itn	
	begin
		--if @cn = 0 set @str=
		if @cn>0  set @str=@str+','
		set @str=@str+'sum(case '+@fields+' when '+ltrim(str(@cn+1))+' then 1 else 0 end) '
		+case lower(@fields) when 'sex' then '['+dbo.fn_sex(@cn+1)+']'
						  			when 'school' then '['+dbo.fn_yes(@cn+1)+']'
									when 'education' then '['+dbo.fn_education(@cn+1)+']'
									when 'hearth' then '['+dbo.fn_healthy(@cn+1)+']'
									when 'labors' then '['+dbo.fn_labor(@cn+1)+']'
									when 'works' then '['+dbo.fn_work(@cn+1)+']'
									when 'bla'    then '['+dbo.fn_yes(@cn+1)+']'
									when 'property' then '['+dbo.fn_property(@cn+1)+']'
									when 'dcause' then '['+dbo.fn_reason(@cn+1)+']'
									else ''
									end
		set @cn = @cn +1
	end
	return @str
end
GO
