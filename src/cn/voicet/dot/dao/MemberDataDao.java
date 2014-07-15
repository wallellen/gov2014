package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface MemberDataDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.MemberDataDaoImpl";
	void batchImportMemberData(DotSession ds);
	void emptyMemberDataByXm(DotSession ds, String xm);
}
