package cn.voicet.dot.dao;

import java.util.List;

import cn.voicet.dot.util.DotSession;

public interface SystemLogDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.SystemLogDaoImpl";

	List findLogInfo(String startdate, String enddate,
			String msgtype, String sender, int curPage, int pageSize);

	Integer findLogTotalPage(String startdate, String enddate,
			String msgtype, String sender, int pageSize);
	
}
