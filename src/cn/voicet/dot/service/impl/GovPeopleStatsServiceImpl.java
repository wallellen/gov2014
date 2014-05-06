package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovPeopleStatsDao;
import cn.voicet.dot.service.GovPeopleStatsService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovPeopleStatsForm;

@Transactional(readOnly=true)
@Service(GovPeopleStatsService.SERVICE_NAME)
public class GovPeopleStatsServiceImpl implements GovPeopleStatsService {
	
	@Resource(name=GovPeopleStatsDao.SERVICE_NAME)
	private GovPeopleStatsDao govPeopleStatsDao;

	public void getPeopleSumInfo(DotSession ds,
			GovPeopleStatsForm govPeopleStatsForm) {
		govPeopleStatsDao.getPeopleSumInfo(ds, govPeopleStatsForm);
	}


}
