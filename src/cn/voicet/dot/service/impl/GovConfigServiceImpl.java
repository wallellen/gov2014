package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovConfigDao;
import cn.voicet.dot.service.GovConfigService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(GovConfigService.SERVICE_NAME)
public class GovConfigServiceImpl implements GovConfigService {
	
	@Resource(name=GovConfigDao.SERVICE_NAME)
	private GovConfigDao govConfigDao;

	public void configRole(DotSession ds, String rolestr) {
		govConfigDao.configRole(ds, rolestr);
	}

	public String getRoleRight(DotSession ds, String opCode) {
		return govConfigDao.getRoleRight(ds, opCode);
	}

	public void updateRoleRight(DotSession ds, String opCode, String isEdit) {
		govConfigDao.updateRoleRight(ds, opCode, isEdit);
	}

	public void initPasswordByOpCode(DotSession ds, String opCode) {
		govConfigDao.initPasswordByOpCode(ds, opCode);
	}

}
