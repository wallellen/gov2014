package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface SysGLParamDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.SysGLParamDaoImpl";

	void getGlobalParamInfo(DotSession ds);

	void setGlobalParamInfo(DotSession ds);


}
