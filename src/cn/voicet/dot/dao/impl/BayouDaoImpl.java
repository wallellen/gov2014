package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.jfree.util.Log;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.BayouDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.BayouForm;

@Repository(BayouDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked"})
public class BayouDaoImpl extends CommonDaoImpl<Object> implements BayouDao {

	private static Logger log = Logger.getLogger(BayouDaoImpl.class);
	public void queryBayouInfo(final DotSession ds, final BayouForm bayouForm) {
		log.info("sp:y8_dir(1)");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call y8_dir(?)}");
				cs.setString(1, bayouForm.getAreabm());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
				Map map;
				if(null != rs)
				{
					while(rs.next()){
						map = new HashMap();
						ds.putMapDataByColName(map, rs);
		        		ds.list.add(map);
					}
				}
				return null;
			}
		});
	}

	public Map<String, Object> queryBayouDetailInfo(final BayouForm bayouForm) {
		log.info("sp:y8_chun_query(1)");
		return (Map<String, Object>)getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call y8_chun_query(?,?)}");
				cs.setString(1, bayouForm.getAreabm());
				cs.setInt(2, 2014);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap<String, Object>();
						ResultSetMetaData rsm =rs.getMetaData();
						int colCount = rsm.getColumnCount();
						String colName;
						for(int i=1; i<=colCount; i++)
						{
							colName=rsm.getColumnName(i).toLowerCase();
							map.put(colName, rs.getString(i));
						}
					}
				}
				return map;
			}
		});
	}

	public void saveBayouInfo(final BayouForm bayouForm) {
		log.info("sp:y8_chun_update(24)");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call y8_chun_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				//cs.setString(1, bayouForm.getAreabm());
				//cs.setInt(2, 2014);
				String ix[][] = 
					{
						{"0","s"},
						{"1","i"},
						
						{"8","i"},
						{"9","i"},
						{"10","i"},
						{"11","i"},
						{"20","i"},
						{"21","i"},
						{"22","i"},
						{"23","i"},
						
						{"12","s"},
						{"13","s"},
						{"14","s"},
						{"15","s"},
						{"16","s"},
						{"17","s"},
						{"18","s"},
						{"19","s"},
						
						{"2","s"},
						{"3","s"},
						{"4","s"},
						{"5","s"},
						{"6","s"},
						{"7","s"},
					};
				DotSession.prepareParamFromInputArray(cs, bayouForm.getBytxt(), ix);
				cs.execute();
				return null;
			}
		});
	}
	
}
