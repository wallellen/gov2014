package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface YearDataDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.YearDataDaoImpl";
	void batchImportYearData(DotSession ds);
}
