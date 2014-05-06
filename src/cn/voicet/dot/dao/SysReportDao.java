package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface SysReportDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.SysReportDaoImpl";

	void getSysReportInfo(DotSession ds, String reportflag);

	void saveReportInfo(String reportflag, String[] pstr, String isde);

	void deleteReportByRid(String reportflag, int drid);


}
