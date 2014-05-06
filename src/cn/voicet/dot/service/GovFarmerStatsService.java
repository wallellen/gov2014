package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

public interface GovFarmerStatsService {
	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovFarmerStatsServiceImpl";

	void getFarmerSumInfo(DotSession ds,
			GovFarmerStatsForm govFarmerStatsForm);

}
