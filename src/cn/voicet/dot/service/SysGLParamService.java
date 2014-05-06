package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface SysGLParamService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.SysGLParamServiceImpl";

	void getGlobalParamInfo(DotSession ds);

	void setGlobalParamInfo(DotSession ds);

}
