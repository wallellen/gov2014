package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

public interface GovFarmerStatsDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovFarmerStatsDaoImpl";

	void getFarmerSumInfo(DotSession ds,
			GovFarmerStatsForm govFarmerStatsForm);

}
