package cn.voicet.dot.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringHelper {

	/**
	 * 将字符串形式的类型转换成日期类型
	 * @param textDate
	 * @return
	 */
	public static Date stringConvertDate(String date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = format.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	
	public static boolean isNumber(String str){
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher match = pattern.matcher(str);
		if(match.matches()==false){
			return false;
		}
		else{
			return true;
		}
	}
	
	public static boolean checkIdCard(String str)
	{
		System.out.println("str length:"+str.length());
		if(str.length()!=15 || str.length()!=18)
		{
			return false;
		}
		return true;
	}
	
	public static boolean checkNull(String str)
	{
		if(null==str || str.length()==0)
		{
			return false;
		}
		return true;
	}

}
