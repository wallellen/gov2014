package cn.voicet.dot.service;

import java.io.File;

import cn.voicet.dot.util.DotSession;

public interface YearDataService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.YearDataServiceImpl";
	void batchImportYearData(DotSession ds, File excel);
}
