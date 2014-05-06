package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.SysReportDao;
import cn.voicet.dot.service.SysReportService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(SysReportService.SERVICE_NAME)
public class SysReportServiceImpl implements SysReportService {
	
	@Resource(name=SysReportDao.SERVICE_NAME)
	private SysReportDao sysGLParamDao;

	public void getSysReportInfo(DotSession ds, String reportflag) {
		sysGLParamDao.getSysReportInfo(ds, reportflag);
	}

	public void saveReportInfo(String reportflag, String[] pstr, String isde) {
		sysGLParamDao.saveReportInfo(reportflag, pstr, isde);
	}

	@Override
	public void deleteReportByRid(String reportflag, int drid) {
		sysGLParamDao.deleteReportByRid(reportflag, drid);
	}

	
}
