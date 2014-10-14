package cn.voicet.dot.dao;

import java.util.Map;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.BayouForm;

public interface BayouDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.BayouDaoImpl";
	void queryBayouInfo(DotSession ds, BayouForm bayouForm);
	Map<String, Object> queryBayouDetailInfo(BayouForm bayouForm);
	void saveBayouInfo(BayouForm bayouForm);
}
