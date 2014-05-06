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

import cn.voicet.dot.dao.GovJiangBuDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovJiangBuForm;

@Repository(GovJiangBuDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovJiangBuDaoImpl extends CommonDaoImpl<Object> implements GovJiangBuDao {

	public void getJiangBuYear(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "jiangbu_items");
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
	
	public void getJiangBuInfo(final DotSession ds, final String navbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_jiangbu_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, navbm);
				cs.setString(2, crid);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
				Map map;
				if(null!=rs){
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

	/** 更新奖补信息 */
	public void saveJiangBuInfo(final DotSession ds, final GovJiangBuForm govJiangBuForm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_jiangbu_update(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, govJiangBuForm.getRid());
				cs.setString(2, crid);	//批次
				cs.setInt(3, Integer.valueOf(govJiangBuForm.getJbstr().substring(0, 1)));
				cs.setInt(4, Integer.valueOf(govJiangBuForm.getJbstr().substring(1, 2)));
				cs.setInt(5, Integer.valueOf(govJiangBuForm.getJbstr().substring(2, 3)));
				cs.setInt(6, Integer.valueOf(govJiangBuForm.getJbstr().substring(3, 4)));
				cs.setInt(7, Integer.valueOf(govJiangBuForm.getJbstr().substring(4, 5)));
				cs.setInt(8, Integer.valueOf(govJiangBuForm.getJbstr().substring(5, 6)));
				cs.setInt(9, Integer.valueOf(govJiangBuForm.getJbstr().substring(6, 7)));
				cs.setInt(10, govJiangBuForm.getJbtxt()[0]);
				cs.setInt(11, govJiangBuForm.getJbtxt()[1]);
				cs.setInt(12, govJiangBuForm.getJbtxt()[2]);
				cs.setInt(13, Integer.valueOf(govJiangBuForm.getJbstr().substring(7, 8)));
				cs.execute();
				return null;
			}
		});
	}

	public void deleteJiangBuInfoWithRid(final String chm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_jiangbu_delete(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, chm);
				cs.setInt(2, 1);	//批次
				cs.execute();
				return null;
			}
		});
	}

	public void getJiangBuXianInfo(final DotSession ds, final String rid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_jiangbu_detail(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapData(map, rs);
						//ds.putMapDataByColName(map, rs);
		        		ds.list.add(map);
					}
				}
				return null;
			}
		});
	}

	public void getJiangBuInfoWithXian(final DotSession ds, final String cbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_jiangbu_detail(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, cbm);
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

	public void getJiangBunavBybm(final DotSession ds, final String navbm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_bm_nav(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, navbm);
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
