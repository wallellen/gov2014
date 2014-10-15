package cn.voicet.dot.service;

import java.util.Map;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.BayouForm;

public interface BayouService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.BayouServiceImpl";
	void queryBayouInfo(DotSession ds, BayouForm bayouForm);
	Map<String, Object> queryBayouDetailInfo(BayouForm bayouForm);
	void saveBayouInfo(BayouForm bayouForm);
	void addCunWithAreabm(DotSession ds, BayouForm bayouForm);
	void deleteCunByAreabm(DotSession ds, BayouForm bayouForm);
}
