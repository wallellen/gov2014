package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.GovConfigDao;
import cn.voicet.dot.util.DotSession;

@SuppressWarnings("deprecation")
@Repository(GovConfigDao.SERVICE_NAME)
public class GovConfigDaoImpl extends CommonDaoImpl<Object> implements GovConfigDao {

	/** 角色权限管理 */
	public void configRole(final DotSession ds, final String rolestr) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_sysright_update(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, rolestr.substring(0, 9));
				cs.setString(3, rolestr.substring(10, 15));
				cs.setString(4, rolestr.substring(16, 17));
				cs.execute();
				return null;
			}
		});
	}

	/** 管理权限 */
	public String getRoleRight(final DotSession ds, final String opCode) {
		String res = (String) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_sysright_query(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc_update);
				cs.setString(1, ds.rbm);
				cs.setString(2, opCode);
				cs.execute();
				String re = null;
				ResultSet rs = cs.getResultSet();
				if(rs!=null){
					while(rs.next()){
						 re = rs.getString(1);
					}
				}
				return re;
			}
		});
		return res;
	}

	public void updateRoleRight(final DotSession ds, final String opCode, final String isEdit) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_sysright_save(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, opCode);
				cs.setInt(3, Integer.parseInt(isEdit));
				cs.execute();
				return null;
			}
		});
	}

	/** 密码初始化(123456) */
	public void initPasswordByOpCode(final DotSession ds, final String opCode) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call mp_inituserpwd(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, opCode);
				cs.execute();
				return null;
			}
		});
	}
	
}
