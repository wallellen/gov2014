package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovXianCreditDao;
import cn.voicet.dot.service.GovXianCreditService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovXianCreditForm;

@Transactional(readOnly=true)
@Service(GovXianCreditService.SERVICE_NAME)
public class GovXianCreditServiceImpl implements GovXianCreditService {
	
	@Resource(name=GovXianCreditDao.SERVICE_NAME)
	private GovXianCreditDao govXianCreditDao;

	public void getXianCreditYear(DotSession ds) {
		govXianCreditDao.getXianCreditYear(ds);
	}

	public void getCreditInfoWithYear(DotSession ds, String year, int month, int mode) {
		govXianCreditDao.getCreditInfoWithYear(ds, year, month, mode);
	}

	public void deleteCreditInfoWithYearMonth(DotSession ds, String year,
			int month) {
		govXianCreditDao.deleteCreditInfoWithYearMonth(ds, year, month);
	}

	public void getShenCreditReportList(DotSession ds, String year, int month,
			int mode) {
		govXianCreditDao.getShenCreditReportList(ds, year, month, mode);
	}

	public void getCreditMonthReportList(DotSession ds, String year, int month,
			int mode) {
		govXianCreditDao.getCreditMonthReportList(ds, year, month, mode);
	}

	public void getXianCreditByXbm(DotSession ds, String year, String xbm,
			int month, int mode) {
		govXianCreditDao.getXianCreditByXbm(ds, year, xbm, month, mode);
	}

	public void getXianCreditMonth(DotSession ds, String year) {
		govXianCreditDao.getXianCreditMonth(ds, year);
	}

	@Override
	public String saveCreditInfo(DotSession ds, String year, int month,
			int tsh, float tsv, int trh, float trv, int nh, float nv, int eh,
			float ev) {
		return govXianCreditDao.saveCreditInfo(ds, year, month, tsh, tsv, trh, trv, nh, nv, eh, ev);
	}

}
