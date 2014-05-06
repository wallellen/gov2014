package junit;

import java.text.SimpleDateFormat;

public class TestDate {

	public static void main(String[] args) {
		 System.out.println(validDateStr("2014-09-11","yyyy"));
	}
	
	public static boolean validDateStr(String str, String dateFormat) {
    	SimpleDateFormat formatter = new SimpleDateFormat(dateFormat);
    	formatter.setLenient(false);
    	try {
    		formatter.format(formatter.parse(str));
    		System.out.println(formatter.format(formatter.parse(str)));
    	} catch (Exception e) {
    		return false;
    	}
    	return true;
    }
}
