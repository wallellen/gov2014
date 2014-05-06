package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface SysReCalcService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.SysReCalcServiceImpl";

	void reCalculateFamily(DotSession ds);


}
