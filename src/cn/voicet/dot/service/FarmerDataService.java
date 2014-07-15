package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface FarmerDataService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.FarmerDataServiceImpl";
	void batchImportFarmerData(DotSession ds);
	void emptyFarmerDataByXm(DotSession ds, String xm);
}
