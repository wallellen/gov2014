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

import cn.voicet.dot.dao.GovKeyProjectDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovKeyProjectForm;

@Repository(GovKeyProjectDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovKeyProjectDaoImpl extends CommonDaoImpl<Object> implements GovKeyProjectDao {

	public void getKeyProjectInfo(final DotSession ds, final String navbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_keyprj_detail(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, navbm);
				cs.setString(2, crid);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
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

	/** 更新关键项目信息 */
	public void saveKeyProjectInfo(final DotSession ds, final GovKeyProjectForm govKeyProjectForm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_keyprj_update(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, govKeyProjectForm.getKptxt()[0]);
				cs.setString(2, crid);
				cs.setString(3, govKeyProjectForm.getKptxt()[1]);
				cs.setString(4, govKeyProjectForm.getKptxt()[2]);
				cs.setString(5, govKeyProjectForm.getKptxt()[3]);
				cs.setFloat(6, Float.parseFloat(govKeyProjectForm.getKptxt()[4]));
				cs.setFloat(7, Float.parseFloat(govKeyProjectForm.getKptxt()[5]));
				cs.setFloat(8, Float.parseFloat(govKeyProjectForm.getKptxt()[6]));
				cs.setFloat(9, Float.parseFloat(govKeyProjectForm.getKptxt()[7]));
				cs.setFloat(10, Float.parseFloat(govKeyProjectForm.getKptxt()[8]));
				cs.setString(11, govKeyProjectForm.getKptxt()[9]);
				cs.setString(12, govKeyProjectForm.getKptxt()[10]);
				cs.setString(13, govKeyProjectForm.getKptxt()[11]);
				cs.execute();
				return null;
			}
		});
	}

	
	/** 根据项目编号删除项目 */
	public void deleteKeyProjectByPid(final String bm, final String pid, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call sp_keyprj_delete(?,?,?)}");
				cs.setString(1, bm);
				cs.setString(2, crid);
				cs.setInt(3, Integer.parseInt(pid));
				cs.execute();
				return null;
			}
		});
	}

	public void getKeyProjectSeason(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "keyprj_items");
				cs.setInt(2, 0);
				cs.execute();
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

	public void getKeyProjectZhen(final DotSession ds, final String navbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_keyprj_detail(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, navbm);
				cs.setString(2, crid);
				cs.execute();
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
	
}
