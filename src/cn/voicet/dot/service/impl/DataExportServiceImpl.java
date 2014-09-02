package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.DataExportDao;
import cn.voicet.dot.service.DataExportService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(DataExportService.SERVICE_NAME)
public class DataExportServiceImpl implements DataExportService {
	@Resource(name=DataExportDao.SERVICE_NAME)
	private DataExportDao dataExportDao;
	public String exportXianDataByBM(DotSession ds, String zipFileName) {
		return dataExportDao.exportXianDataByBM(ds, zipFileName);
	}
}
