package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.SysGLParamDao;
import cn.voicet.dot.util.DotSession;

@Repository(SysGLParamDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked"})
public class SysGLParamDaoImpl extends CommonDaoImpl<Object> implements SysGLParamDao {

	public void getGlobalParamInfo(final DotSession ds) {
		getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						String proc = "{call sys_param_query()}";
						Connection conn = session.connection();
						CallableStatement cs = conn.prepareCall(proc);
						cs.execute();
						ResultSet rs = cs.getResultSet();
						if(null!=rs){
							while(rs.next()){
								ds.map.put("lockyear", rs.getString(1));
								ds.map.put("workyear", rs.getString(2));
							}
						}
						return null;
					}
				});
		
	}

	public void setGlobalParamInfo(final DotSession ds) {
		getHibernateTemplate().execute(
			new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					String proc = "{call sys_param_set(?,?)}";
					Connection conn = session.connection();
					CallableStatement cs = conn.prepareCall(proc);
					cs.setInt(1, Integer.valueOf(ds.map.get("lockyear").toString()));
					cs.setInt(2, Integer.valueOf(ds.map.get("workyear").toString()));
					cs.execute();
					return null;
				}
			});
	}

}
