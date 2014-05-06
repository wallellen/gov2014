package cn.voicet.dot.service;

import java.util.Map;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.DotUserForm;

public interface DotUserService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.DotUserServiceImpl";

	Map<String, String> dotUserLogin(DotUserForm dotUserForm);

	Integer updateUserPassword(DotSession ds, String oldpwd, String newpwd);
	
}
