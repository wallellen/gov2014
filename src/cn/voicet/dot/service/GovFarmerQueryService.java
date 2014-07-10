package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface GovFarmerQueryService {
	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovFarmerQueryServiceImpl";
	void getFarmerInfoList(DotSession ds);
	void getMemberInfoList(DotSession ds);
	void getAllFarmerInfoList(DotSession ds);
	void getAllMemberInfoList(DotSession ds);
}
