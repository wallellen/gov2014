USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[ClearZero]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[ClearZero](@inValue varchar(50))
returns varchar(50)
as
begin
declare @returnValue varchar(20)
if(@inValue='')
   set @returnValue='' --空的时候为空
else if (charindex('.',@inValue) ='0')
   set @returnValue=@inValue --针对不含小数点的
else if ( substring(reverse(@inValue),patindex('%[^0]%',reverse(@inValue)),1)='.')
          set @returnValue =left(@inValue,len(@inValue)-patindex('%[^0]%',reverse(@inValue))) --针对小数点后全是0的
      else
          set @returnValue =left(@inValue,len(@inValue)- patindex('%[^0]%.%',reverse(@inValue))+1) --其他任何情形
return @returnValue
end
GO
