package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface GovIncomeDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovIncomeDaoImpl";

	void getIncomeYear(DotSession ds);

	void getIncomeInfoBycbm(DotSession ds, String cbm, String year);

	
}
