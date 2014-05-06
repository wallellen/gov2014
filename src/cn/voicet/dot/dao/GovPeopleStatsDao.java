package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovPeopleStatsForm;

public interface GovPeopleStatsDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovPeopleStatsDaoImpl";

	void getPeopleSumInfo(DotSession ds, GovPeopleStatsForm govPeopleStatsForm);

	
}
