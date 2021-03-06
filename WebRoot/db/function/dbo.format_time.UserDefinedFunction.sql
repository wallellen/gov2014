USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[format_time]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.format_time(3605)
获得时长的转换单位*/
CREATE    function [dbo].[format_time](@seconds int)
returns varchar(50) as  
begin 
declare @minutes int
declare @hour int
declare @ret varchar(100)
   if @seconds <60 
      set @ret =
         case when @seconds < 10 then 
            '0'+convert(varchar,@seconds)
         else
            convert(varchar,@seconds) 
         end +'秒'
   else if @seconds < 60*60
   begin
      set @minutes = @seconds/ 60;
      set @seconds=@seconds-@minutes*60;
      set @ret= 
      case when @minutes < 10 then
         '0'+convert(varchar,@minutes)+'分'
      else
         convert(varchar,@minutes)+'分'
      end
      +
      case when @seconds <10 then 
         '0'+convert(varchar,@seconds)
      else 
         convert(varchar,@seconds) 
      end +'秒'
   end
   else
   begin
      set @hour = @seconds/60/60;
      set @seconds = @seconds - @hour*3600;
      set @minutes  = @seconds/60;
      set @seconds= @seconds-@minutes*60;
      set @ret = convert(varchar,@hour)+'H'+
      case when @minutes<10 then
         '0'+convert(varchar,@minutes)+'分'
      else
         convert(varchar,@minutes)+'分' 
      end
           + 
      case when @seconds < 10 then 
         '0'+convert(varchar,@seconds)
      else 
         convert(varchar,@seconds) 
      end+'秒'
   end 
   return @ret
end
GO
