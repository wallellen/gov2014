package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovFarmerQueryDao;
import cn.voicet.dot.service.GovFarmerQueryService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(GovFarmerQueryService.SERVICE_NAME)
public class GovFarmerQueryServiceImpl implements GovFarmerQueryService {
	
	@Resource(name=GovFarmerQueryDao.SERVICE_NAME)
	private GovFarmerQueryDao govFarmerQueryDao;

	public void getFarmerInfoList(DotSession ds) {
		govFarmerQueryDao.getFarmerInfoList(ds);
	}

	public void getMemberInfoList(DotSession ds) {
		govFarmerQueryDao.getMemberInfoList(ds);
	}

	public void getAllFarmerInfoList(DotSession ds) {
		govFarmerQueryDao.getAllFarmerInfoList(ds);
	}

	public void getAllMemberInfoList(DotSession ds) {
		govFarmerQueryDao.getAllMemberInfoList(ds);
	}

}
