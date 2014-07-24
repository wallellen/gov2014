package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.YearDataDao;
import cn.voicet.dot.service.YearDataService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(YearDataService.SERVICE_NAME)
public class YearDataServiceImpl implements YearDataService {
	@Resource(name=YearDataDao.SERVICE_NAME)
	private YearDataDao yearDataDao;
	public void getYearInfo(DotSession ds) {
		yearDataDao.getYearInfo(ds);
	}
	public void batchImportYearData(DotSession ds){
		yearDataDao.batchImportYearData(ds);
	}
	public void emptyYearDataByXmWithYear(DotSession ds, String xm, String year) {
		yearDataDao.emptyYearDataByXmWithYear(ds, xm, year);
	}
	public void getOpnameByXm(DotSession ds, String xm) {
		yearDataDao.getOpnameByXm(ds, xm);
	}

}
