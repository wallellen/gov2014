USE [gov2014]
GO
/****** Object:  UserDefinedFunction [dbo].[IDCard]    Script Date: 06/17/2014 09:19:43 ******/
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IDCard] 
(
    @Card    varchar(18)
)
RETURNS 
@TCard TABLE 
(
     Input    varchar(18)
    ,IDCard    varchar(18)
    ,Valid    bit
)
AS
BEGIN
    DECLARE    
             @Input        as varchar(18)
            ,@IDCard    as varchar(18)
            ,@Valid        as bit

    DECLARE     
             @Length    as smallint
            ,@TmpCard    as varchar(18)
            ,@IsOld        as bit

    SET @Valid = 0
    SET @IDCard = ''
    SET @Input = ''

    IF @Card IS NULL GOTO Finish

    SET @Input = LTRIM(RTRIM(@Card)) /*去空格*/
    SET @Length = LEN(@Input)

    IF NOT @Length IN (15, 18) GOTO Finish /*非15、18位*/

    IF @Length = 15
        BEGIN
            IF ISNUMERIC(@Input) = 0 GOTO Finish /*非数字*/
            SET @TmpCard = LEFT(@Input, 6) + '19' + RIGHT(@input, 9) /*补充为17位*/
            SET @IsOld = 1
        END
    ELSE
        BEGIN
            IF ISNUMERIC(LEFT(@Input, 17)) = 0 GOTO Finish /*非数字*/
            SET @TmpCard = LEFT(@Input, 17) /*取前17位*/
            SET @IsOld = 0
        END

    DECLARE @Birthday    varchar(8)
    SET @Birthday = SUBSTRING(@TmpCard, 7, 8)
    IF ISDATE(@birthday) = 0 GOTO Finish /*非日期*/

    --前17位数与相应加权因子的积的和
    DECLARE 
             @Sum as smallint
            ,@WI as tinyint
            ,@Index as tinyint
            ,@Num as tinyint

    SET @Sum = 0
    SET @Index = 1

    WHILE @Index < 18
        BEGIN
            SET @Num = CAST(SUBSTRING(@TmpCard, @Index, 1) AS tinyint)

            SELECT @WI =
                CASE @Index
                    WHEN 1 THEN 7
                    WHEN 2 THEN 9
                    WHEN 3 THEN 10
                    WHEN 4 THEN 5
                    WHEN 5 THEN 8
                    WHEN 6 THEN 4
                    WHEN 7 THEN 2
                    WHEN 8 THEN 1
                    WHEN 9 THEN 6
                    WHEN 10 THEN 3
                    WHEN 11 THEN 7
                    WHEN 12 THEN 9
                    WHEN 13 THEN 10
                    WHEN 14 THEN 5
                    WHEN 15 THEN 8
                    WHEN 16 THEN 4
                    WHEN 17 THEN 2
                END

            SET @Sum = @Sum + @Num * @WI
            SET @Index = @Index + 1
        END

    --模11
    DECLARE @Mod as tinyint
    SET @Mod = @Sum % 11

    --校验码
    DECLARE @Parity as varchar(1)
    SELECT @Parity =
        CASE @Mod
            WHEN 0 THEN '1'
            WHEN 1 THEN '0'
            WHEN 2 THEN 'X'
            WHEN 3 THEN '9'
            WHEN 4 THEN '8'
            WHEN 5 THEN '7'
            WHEN 6 THEN '6'
            WHEN 7 THEN '5'
            WHEN 8 THEN '4'
            WHEN 9 THEN '3'
            WHEN 10 THEN '2'
        END

    --完整的18位身份证号码
    SET @TmpCard = @TmpCard + @Parity

    IF @IsOld = 1
        SET @Valid = 1
    ELSE 
        IF @Parity = RIGHT(@Input, 1) /*校验*/
            SET @Valid = 1

    --无论正确与否，都给出有效身份证号码
    SET @IDCard = @tmpCard

Finish:
    INSERT INTO @TCard VALUES(@Input, @IDCard, @Valid)    
    RETURN 
END
GO
