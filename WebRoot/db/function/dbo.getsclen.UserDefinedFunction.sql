USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[getsclen]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
select dbo.getsclen(4)
获得各级别的子代码长度
aa:bb:cc:ddd:eee:fff
*/
CREATE function [dbo].[getsclen](@level int)
returns int as  
begin 
  
return 
	case when @level = 1 then 4
  	else
		case when @level=2 then 6
		else
			case when @level = 3 then  9
			else
				case when @level = 4 then 12
				else
					15
				end
			end
				
		end
	end
end
GO
