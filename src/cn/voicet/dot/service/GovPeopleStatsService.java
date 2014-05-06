package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovPeopleStatsForm;

public interface GovPeopleStatsService {
	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovPeopleStatsServiceImpl";

	void getPeopleSumInfo(DotSession ds, GovPeopleStatsForm govPeopleStatsForm);

}
