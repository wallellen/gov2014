package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface GovIncomeService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovIncomeServiceImpl";

	void getIncomeYear(DotSession ds);

	void getIncomeInfoBycbm(DotSession ds, String cbm, String year);


}
