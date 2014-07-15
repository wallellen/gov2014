package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.FarmerDataDao;
import cn.voicet.dot.service.FarmerDataService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(FarmerDataService.SERVICE_NAME)
public class FarmerDataServiceImpl implements FarmerDataService {
	@Resource(name=FarmerDataDao.SERVICE_NAME)
	private FarmerDataDao farmerDataDao;
	public void batchImportFarmerData(DotSession ds) {
		farmerDataDao.batchImportFarmerData(ds);
	}
	public void emptyFarmerDataByXm(DotSession ds, String xm) {
		farmerDataDao.emptyFarmerDataByXm(ds, xm);
	}
}
