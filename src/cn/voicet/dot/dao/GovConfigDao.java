package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface GovConfigDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovConfigDaoImpl";

	void configRole(DotSession ds, String rolestr);

	String getRoleRight(DotSession ds, String opCode);

	void updateRoleRight(DotSession ds, String opCode, String isEdit);

	void initPasswordByOpCode(DotSession ds, String opCode);

}
