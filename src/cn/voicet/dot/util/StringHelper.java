package cn.voicet.dot.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

}
