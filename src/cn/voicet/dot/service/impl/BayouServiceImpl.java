package cn.voicet.dot.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.BayouDao;
import cn.voicet.dot.service.BayouService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.BayouForm;

@Transactional(readOnly=true)
@Service(BayouService.SERVICE_NAME)
public class BayouServiceImpl implements BayouService {
	@Resource(name=BayouDao.SERVICE_NAME)
	private BayouDao bayouDao;

	public void queryBayouInfo(DotSession ds, BayouForm bayouForm) {
		bayouDao.queryBayouInfo(ds, bayouForm);
	}

	public Map<String, Object> queryBayouDetailInfo(BayouForm bayouForm) {
		return bayouDao.queryBayouDetailInfo(bayouForm);
	}

	public void saveBayouInfo(BayouForm bayouForm) {
		bayouDao.saveBayouInfo(bayouForm);
	}

	public void addCunWithAreabm(DotSession ds, BayouForm bayouForm) {
		bayouDao.addCunWithAreabm(ds, bayouForm);
	}
	
	public void deleteCunByAreabm(DotSession ds, BayouForm bayouForm) {
		bayouDao.deleteCunByAreabm(ds, bayouForm);
	}

	public void queryBayouTotalInfo(DotSession ds) {
		bayouDao.queryBayouTotalInfo(ds);
	}

}
