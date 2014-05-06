package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovIncomeForm;

public interface GovIncomeDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovIncomeDaoImpl";

	void getIncomeYear(DotSession ds);

	void getIncomeInfoBycbm(DotSession ds, String cbm, String year);

	void saveIncomeYear(DotSession ds, GovIncomeForm govIncomeForm, String year);

	
}
