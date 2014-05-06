package cn.voicet.dot.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.DotUserDao;
import cn.voicet.dot.service.DotUserService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.DotUserForm;

@Transactional(readOnly=true)
@Service(DotUserService.SERVICE_NAME)
public class DotUserServiceImpl implements DotUserService {

	@Resource(name=DotUserDao.SERVICE_NAME)
	private DotUserDao dotUserDao;

	public Map<String, String> dotUserLogin(DotUserForm dotUserForm) {
		Map<String, String> map = dotUserDao.dotUserLogin(dotUserForm);
		return map;
	}

	public Integer updateUserPassword(DotSession ds, String oldpwd, String newpwd) {
		return dotUserDao.updateUserPassword(ds, oldpwd, newpwd);
	}
	
}
