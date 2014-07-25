package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.InitPassDao;
import cn.voicet.dot.util.DotSession;

@Repository(InitPassDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class InitPassDaoImpl extends CommonDaoImpl<Object> implements InitPassDao {

	public void initPasswordByDqbm(final DotSession ds, final String dqbm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				String proc = "";
				if(ds.sflag==0)
				{
					proc = "{call mp_inituserpwd(?,?)}";
				}
				else
				{
					proc = "{call xmzj_inituserpwd(?,?)}";
				}
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, dqbm);
				cs.execute();
				return null;
			}
		});
	}
	
}
