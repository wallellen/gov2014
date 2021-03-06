USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[get_rand_pwd]    Script Date: 06/17/2014 09:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--select dbo.fn_randompassword(8,8)
/*随机生成密码的函数*/
create  FUNCTION [dbo].[get_rand_pwd] 
               (@MinLength SMALLINT  = 6, 
                @MaxLength SMALLINT  = 16) 
RETURNS VARCHAR(100) 
AS 
  BEGIN 
    DECLARE  @Password VARCHAR(30) 
    DECLARE  @Length SMALLINT 
    DECLARE  @Position SMALLINT 
    DECLARE  @Characters VARCHAR(55) 
    DECLARE  @LetterPosition INT 
    DECLARE  @Letter CHAR(1) 
    SET @Characters = 'aeubcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ23456789' 
    SET @Password = '' 
    -- determine length 
    SET @Length = @MinLength 
                    + Round(dbo.get_rand() 
                              * (@MaxLength 
                                   - @MinLength),0,0) 
    SET @Position = 1 
    WHILE @Position <= @Length 
      BEGIN 
        BEGIN 
          BEGIN 
            SET @LetterPosition = CONVERT(INT,Round((dbo.get_rand() 
                                                       * (Len(@Characters) 
                                                            - 1)),0,0),1) 
                                    + 1 
            SET @Letter = Substring(@Characters,@LetterPosition,1) 
            SET @Password = @Password 
                              + @Letter 
          END 
        END 
        SET @Position = @Position 
                          + 1 -- incriment counter 
      END 
    -- return password 
    RETURN @password 
  END
GO
