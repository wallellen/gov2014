package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovFarmerStatsDao;
import cn.voicet.dot.service.GovFarmerStatsService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

@Transactional(readOnly=true)
@Service(GovFarmerStatsService.SERVICE_NAME)
public class GovFarmerStatsServiceImpl implements GovFarmerStatsService {
	
	@Resource(name=GovFarmerStatsDao.SERVICE_NAME)
	private GovFarmerStatsDao govFarmerStatsDao;

	public void getFarmerSumInfo(DotSession ds,
			GovFarmerStatsForm govFarmerStatsForm) {
		govFarmerStatsDao.getFarmerSumInfo(ds, govFarmerStatsForm);
	}

}
