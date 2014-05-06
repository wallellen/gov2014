package cn.voicet.dot.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@SuppressWarnings("static-access")
public class DateUtil {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private static Calendar cal = Calendar.getInstance();
	
	/** 获取今天日期 */
	public static String getToday(){
		return sdf.format(cal.getTime());
	}
	
	/** 获取昨天日期 */
	public static String getYesterDay(){
		cal.add(cal.DATE, -1);
		return sdf.format(cal.getTime());
	}
	
	public static void main(String[] args){
		System.out.println(getToday());
	}
}
