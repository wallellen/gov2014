package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface DataExportService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.DataExportServiceImpl";
	String exportXianDataByBM(DotSession ds, String zipFileName);
}
