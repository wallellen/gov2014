package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface SysReCalcDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.SysReCalcDaoImpl";

	void reCalculateFamily(DotSession ds);

}
