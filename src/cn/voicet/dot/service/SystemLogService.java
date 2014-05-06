package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface SystemLogService {

	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.SystemLogServiceImpl";

	Integer findLogTotalPage(DotSession ds, String startdate, String enddate,
			String msgtype, String sender, int pageSize);

	void findLogInfo(DotSession ds, String startdate, String enddate,
			String msgtype, String sender, int curPage, int pageSize);

}
