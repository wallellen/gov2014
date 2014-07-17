package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface FarmerDataDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.FarmerDataDaoImpl";
	void batchImportFarmerData(DotSession ds);
	void emptyFarmerDataByXm(DotSession ds, String xm);
	void getOpnameByXm(DotSession ds, String xm);
}
