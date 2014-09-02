package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface DataExportDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.DataExportDaoImpl";
	String exportXianDataByBM(DotSession ds, String zipFileName);
}
