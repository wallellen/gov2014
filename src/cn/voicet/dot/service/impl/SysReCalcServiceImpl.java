package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.SysReCalcDao;
import cn.voicet.dot.service.SysReCalcService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(SysReCalcService.SERVICE_NAME)
public class SysReCalcServiceImpl implements SysReCalcService {
	
	@Resource(name=SysReCalcDao.SERVICE_NAME)
	private SysReCalcDao sysReCalcDao;

	public void reCalculateFamily(DotSession ds) {
		sysReCalcDao.reCalculateFamily(ds);
	}
}
