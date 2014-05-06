package cn.voicet.dot.dao;

import java.util.Map;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.DotUserForm;

public interface DotUserDao extends CommonDao<Object> {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.DotUserDaoImpl";

	Map<String, String> dotUserLogin(DotUserForm dotUserForm);

	Integer updateUserPassword(DotSession ds, String oldpwd, String newpwd);

}
