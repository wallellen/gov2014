package cn.voicet.dot.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.DotUserDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.DotUserForm;

@SuppressWarnings("unchecked")
@Repository(DotUserDao.SERVICE_NAME)
public class DotUserDaoImpl extends CommonDaoImpl<Object> implements DotUserDao {

	/** 用户登录 */
	public Map<String, String> dotUserLogin(final DotUserForm dotUserForm) {
		Map<String, String> map = (Map<String, String>) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				SQLQuery query = session.createSQLQuery("{call sys_userlogin(?,?)}");
				query.setParameter(0, dotUserForm.getAccount());
				query.setParameter(1, dotUserForm.getPassword());
				List list = query.list();
				Map<String, String> resMap = new HashMap<String, String>();
				Object[] str = (Object[]) list.get(0);
				resMap.put("roleid", String.valueOf(str[0]));
				resMap.put("username", (String) str[1]);
				resMap.put("rolename", (String) str[2]);
				resMap.put("isedit", String.valueOf(str[3]));
				resMap.put("rbm", String.valueOf(str[4]));
				resMap.put("rbn", String.valueOf(str[5]));
				resMap.put("workyear", String.valueOf(str[6]));
				resMap.put("yearlock", String.valueOf(str[7]));
				return resMap;
			}
		});
		return map;
	}

	/** 修改用户密码 */
	public Integer updateUserPassword(final DotSession ds, final String oldpwd, final String newpwd) {
		Integer res = (Integer) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				SQLQuery query = session.createSQLQuery("{call sys_accountchgpwd(?,?,?,?)}");
				query.setString(0, ds.account);
				query.setString(1, ds.roleID);
				query.setString(2, oldpwd);
				query.setString(3, newpwd);
				Object[] str = (Object[]) query.list().get(0);
				Integer result = (Integer) str[0];
				return result;
			}
		});
		return res;
	}
	
}
