package junit;

import java.util.List;

import org.junit.Test;

import cn.voicet.dot.util.DotRoleMenu;

public class TestDotRoleMenu {

	@Test
	public void testDotRoleMenu() {
		DotRoleMenu role = new DotRoleMenu();
		List s = role.GetList("family");
		System.out.println(s);
	}
	

}
