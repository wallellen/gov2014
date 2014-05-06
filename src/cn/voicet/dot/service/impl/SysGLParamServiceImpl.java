package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.SysGLParamDao;
import cn.voicet.dot.service.SysGLParamService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(SysGLParamService.SERVICE_NAME)
public class SysGLParamServiceImpl implements SysGLParamService {
	
	@Resource(name=SysGLParamDao.SERVICE_NAME)
	private SysGLParamDao sysGLParamDao;

	public void getGlobalParamInfo(DotSession ds) {
		sysGLParamDao.getGlobalParamInfo(ds);
	}

	public void setGlobalParamInfo(DotSession ds) {
		sysGLParamDao.setGlobalParamInfo(ds);
	}

	
}
