package junit;

import java.util.Calendar;
import java.util.Date;

import junit.framework.TestCase;

public class TestStringUtil extends TestCase {
	public void testParseStringToDate() {
		{
			Calendar c = Calendar.getInstance();
			c.clear();
			c.set(2000, 1, 3, 0, 0, 0);
			Date d = StringUtil.parseStringToDate("2000-02-03");
			assertEquals(c.getTime().getTime(), d.getTime());
		}
		{
			Calendar c = Calendar.getInstance();
			c.clear();
			c.set(2000, 1, 3, 11, 22, 33);
			Date d = StringUtil.parseStringToDate("2000-02-03 11:22:33");
			assertEquals(c.getTime().getTime(), d.getTime());
		}
		{
			Calendar c = Calendar.getInstance();
			c.clear();
			c.set(2000, 1, 3, 0, 0, 0);
			Date d = StringUtil.parseStringToDate("2000-02-3");
			assertEquals(c.getTime().getTime(), d.getTime());
		}
		{
			Calendar c = Calendar.getInstance();
			c.clear();
			c.set(2000, 1, 3, 1, 2, 3);
			Date d = StringUtil.parseStringToDate("2000-02-03 1:02:03");
			assertEquals(c.getTime().getTime(), d.getTime());
		}
		{
			assertNull(StringUtil.parseStringToDate(""));
			assertNull(StringUtil.parseStringToDate("  "));
			assertNull(StringUtil.parseStringToDate(null));
		}
	}

	public void testParseStringToDateException() {
		testParseStringToDateException("2000");
		testParseStringToDateException("2000-13-03");
		testParseStringToDateException("2000-02-03 51:02:03");
		testParseStringToDateException("2000-02-03 01:f2:03");
		testParseStringToDateException("2000-02-03 01:02");
		testParseStringToDateException("2000-02-03 01:02:222");
	}

	private void testParseStringToDateException(String dateStr) {
		try {
			StringUtil.parseStringToDate(dateStr);
			fail("末抛出异常");
		} catch (Exception e) {
			assertTrue(true);
		}
	}
}
