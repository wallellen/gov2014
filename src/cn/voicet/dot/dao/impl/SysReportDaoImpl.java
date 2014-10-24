package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.SysReportDao;
import cn.voicet.dot.util.DotSession;

@Repository(SysReportDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked"})
public class SysReportDaoImpl extends CommonDaoImpl<Object> implements SysReportDao {

	public void getSysReportInfo(final DotSession ds, final String reportflag) {
		getHibernateTemplate().execute(
			new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					String proc = "{call sp_report_list(?,?)}";
					Connection conn = session.connection();
					CallableStatement cs = conn.prepareCall(proc);
					cs.setString(1, reportflag);
					cs.setInt(2, 1);
					cs.execute();
					ds.initData();
					ResultSet rs = cs.getResultSet();
					ds.list = new ArrayList();	
					Map map;
					if(rs!=null){
						while (rs.next()) {
							map = new HashMap();
							ds.putMapData(map, rs);
			        		ds.list.add(map);
						}
					}
					return null;
				}
			});
		
	}

	public void saveReportInfo(final String reportflag, final String[] pstr, final String isde) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String sp_update = "{call sp_report_update(?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(sp_update);
				cs.setString(1, reportflag);
				cs.setString(2, pstr[0]);
				cs.setString(3, pstr[1]);
				cs.setString(4, pstr[2]);
				cs.setString(5, pstr[3]);
				cs.setInt(6, Integer.parseInt(isde.substring(0,1)));
				cs.setInt(7, Integer.parseInt(isde.substring(1,2)));
				cs.execute();
				return null;
			}
		});
	}

	
	public void deleteReportByRid(final String reportflag, final int drid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String sp_delete = "{call sp_report_delete(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(sp_delete);
				cs.setString(1, reportflag);
				cs.setInt(2, drid);
				cs.execute();
				return null;
			}
		});
	}

}
