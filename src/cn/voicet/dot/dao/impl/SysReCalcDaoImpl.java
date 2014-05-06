package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.SysReCalcDao;
import cn.voicet.dot.util.DotSession;

@Repository(SysReCalcDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class SysReCalcDaoImpl extends CommonDaoImpl<Object> implements SysReCalcDao {

	public void reCalculateFamily(final DotSession ds) {
		getHibernateTemplate().execute(
			new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					Connection conn = session.connection();
					CallableStatement cs = null;
					if(ds.map.get("cal").equals("0")){
						cs = conn.prepareCall("{call mp_calc_family(?)}");
						cs.setString(1, ds.account);
					}else if(ds.map.get("cal").equals("1") && null!=ds.map.get("param")){
						cs = conn.prepareCall("{call mp_calc_year(?,?)}");
						cs.setString(1, ds.account);
						cs.setInt(2, Integer.valueOf((String)ds.map.get("param")));
					}else if(ds.map.get("cal").equals("2")){
						cs = conn.prepareCall("{call mp_calc_ol()}");
					}else{
						return null;
					}
					cs.execute();
					return null;
				}
			});
	}

}
