package junit;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtil {
	private static DateFormat dateFormat = new SimpleDateFormat("yyyy");
	private static DateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
	static {
		dateFormat.setLenient(false);// 这个的功能是不把1996-13-3 转换为1997-1-3
		dateTimeFormat.setLenient(false);
	}

	public static Date parseStringToDate(String dateStr) {
		if (dateStr == null || dateStr.trim().equals(""))
			return null;
		dateStr = dateStr.trim();
		Date date = null;
		try {
			if (dateStr.length() <= 4) {
				date = dateFormat.parse(dateStr);
			} else {
				date = dateTimeFormat.parse(dateStr);
			}
		} catch (Exception e) {
			System.out.println("error");
		}
		System.out.println("success");
		return date;
	}
	
	public static void main(String args[]){
		parseStringToDate("12345");
	}
}
