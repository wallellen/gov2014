package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface GovFarmerQueryDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovFarmerQueryDaoImpl";

	void getFarmerInfoList(DotSession ds);

	void getMemberInfoList(DotSession ds);

}
