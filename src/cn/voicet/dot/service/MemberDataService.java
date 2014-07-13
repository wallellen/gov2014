package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface MemberDataService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.MemberDataServiceImpl";
	void batchImportMemberData(DotSession ds);
}
