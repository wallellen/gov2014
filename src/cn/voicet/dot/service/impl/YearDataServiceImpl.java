package cn.voicet.dot.service.impl;

import java.io.File;

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
	public void batchImportYearData(DotSession ds, File excel) {
		yearDataDao.batchImportYearData(ds, excel);
	}
}
