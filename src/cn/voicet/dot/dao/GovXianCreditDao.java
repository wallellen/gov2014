package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovXianCreditForm;

public interface GovXianCreditDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovXianCreditDaoImpl";
	void getXianCreditYear(DotSession ds);
	void getCreditInfoWithYear(DotSession ds, String year, int month, int mode);
	void deleteCreditInfoWithYearMonth(DotSession ds, String year, int month);
	void getShenCreditReportList(DotSession ds, String year, int month, int mode);
	void getCreditMonthReportList(DotSession ds, String year, int month,
			int mode);
	void getXianCreditByXbm(DotSession ds, String year, String xbm, int month,
			int mode);
	void getXianCreditMonth(DotSession ds, String year);
	String saveCreditInfo(DotSession ds, String year, int month, int tsh,
			float tsv, int trh, float trv, int nh, float nv, int eh, float ev);

}
