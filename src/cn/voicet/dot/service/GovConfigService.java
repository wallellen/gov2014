package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface GovConfigService {
	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovConfigServiceImpl";

	void configRole(DotSession ds, String rolestr);

	String getRoleRight(DotSession ds, String opCode);

	void updateRoleRight(DotSession ds, String opCode, String isEdit);

	void initPasswordByOpCode(DotSession ds, String opCode);

}
