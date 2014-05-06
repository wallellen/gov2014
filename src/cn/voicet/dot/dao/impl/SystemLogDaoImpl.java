package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.SystemLogDao;
import cn.voicet.dot.util.DotSession;

@SuppressWarnings({"deprecation","unchecked"})
@Repository(SystemLogDao.SERVICE_NAME)
public class SystemLogDaoImpl extends CommonDaoImpl<Object> implements SystemLogDao {

	public void findLogInfo(final DotSession ds, final String startdate,
			final String enddate, final String msgtype, final String sender, final int curPage,
			final int pageSize) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sys_log_query_page(?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, ds.roleID);
				cs.setString(3, startdate);
				cs.setString(4, enddate);
				cs.setString(5, msgtype);
				cs.setString(6, sender);
				cs.setInt(7, curPage);
				cs.setInt(8, pageSize);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 map.put("logid", rs.getString("logid"));		//系统日志编号
		        		 map.put("sender", rs.getString("sender"));		//发送者
		        		 map.put("msgtype", rs.getString("msgtype"));	//信息类型
		        		 map.put("occdt", rs.getString("occdt"));		//日期时间
		        		 map.put("content", rs.getString("content"));	//描述内容
		        		 ds.list.add(map);
					}
				}
				return null;
			}
		});
	}

	public Integer findLogTotalPage(final DotSession ds, final String startdate,
			final String enddate, final String msgtype, final String sender, final int pageSize) {
		Integer totalPage = (Integer) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sys_log_query_page_t(?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, ds.roleID);
				cs.setString(3, startdate);
		        cs.setString(4, enddate);
		        cs.setString(5, msgtype);
		        cs.setString(6, sender);
		        cs.setInt(7, pageSize);
		        cs.registerOutParameter(8, Types.INTEGER);
				cs.execute();
				//esultSet rs = cs.getResultSet();
				Integer count = cs.getInt(8);
				
				return count;
			}
		});
		return totalPage;
	}
	
}
