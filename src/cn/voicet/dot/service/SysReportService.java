package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface SysReportService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.SysReportServiceImpl";

	void getSysReportInfo(DotSession ds, String reportflag);

	void saveReportInfo(String reportflag, String[] pstr, String isde);

	void deleteReportByRid(String reportflag, int drid);

}
