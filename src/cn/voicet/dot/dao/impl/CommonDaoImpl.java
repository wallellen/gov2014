package cn.voicet.dot.dao.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import cn.voicet.dot.dao.CommonDao;
import cn.voicet.dot.util.GenericSuperClass;

@SuppressWarnings("unchecked")
public class CommonDaoImpl<T> extends HibernateDaoSupport implements CommonDao<T> {

	public JdbcTemplate jdbcTemplate ;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	/**
	 * 	<bean id="commonDaoImpl" class="cn.voicet.elec.dao.impl.CommonDaoImpl">
			<property name="sesssionFactory" ref="sessionFactory"/>
		</bean>
	 */
	
	@Resource(name="sessionFactory")
	public final void setSessionFactoryDi(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
	private Class entity = (Class)GenericSuperClass.getClass(this.getClass());
	
	public void save(T entity) {
		getHibernateTemplate().save(entity);
	}
	
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}
	
	public List<T> findCollectionByConditionNoPage(String hqlWhere,
			final Object[] params, LinkedHashMap<String, String> orderby) {
		String hql = "from " + entity.getSimpleName() + " o where 1=1";
		String hqlOrderBy = this.orderByCondition(orderby);
		hql += hqlWhere + hqlOrderBy;
		final String finalHql = hql;
		List<T> list = (List<T>)this.getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery(finalHql);
				//setParams(query, params);
				for (int i=0; params!=null && i<params.length; i++) {
					query.setParameter(i, params[i]);
				}
				return query.list();
			}
		});
		return list;
	}

	private String orderByCondition(LinkedHashMap<String, String> orderBy) {
		StringBuffer buffer = new StringBuffer("");
		if (orderBy != null){
			buffer.append(" order by ");
			for (Map.Entry<String, String> map : orderBy.entrySet()) {
				buffer.append(" " + map.getKey() + " " + map.getValue() + ",");
			}
			buffer.deleteCharAt(buffer.length()-1);
		}
		return buffer.toString();
	}

}
