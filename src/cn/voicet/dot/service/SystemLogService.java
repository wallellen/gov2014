package cn.voicet.dot.service;

import java.util.List;

import cn.voicet.dot.util.DotSession;

public interface SystemLogService {

	
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.SystemLogServiceImpl";

	Integer findLogTotalPage(String startdate, String enddate,
			String msgtype, String sender, int pageSize);

	List findLogInfo(String startdate, String enddate,
			String msgtype, String sender, int curPage, int pageSize);

}
