package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface YearDataService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.YearDataServiceImpl";
	void batchImportYearData(DotSession ds);
	void getYearInfo(DotSession ds);
	void emptyYearDataByXmWithYear(DotSession ds, String xm, String year);
	void getOpnameByXm(DotSession ds, String xm);
}
