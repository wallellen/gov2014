package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.GovVillageProjectDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovVillageProjectForm;

@Repository(GovVillageProjectDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovVillageProjectDaoImpl extends CommonDaoImpl<Object> implements GovVillageProjectDao {

	public void getVillageProjectInfo(final DotSession ds, final String navbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_chunprj_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, navbm);
				cs.setString(2, crid);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.list = new ArrayList();
				ds.list2 = new ArrayList();
				do{
					updateCount = cs.getUpdateCount();
					if(updateCount != -1){	
						cs.getMoreResults();
						continue;
					}
					rs = cs.getResultSet();
					if(null != rs){
						while(rs.next()){
							if(rid ==0){
								ResultSetMetaData rsm =rs.getMetaData(); //获得列集
								int col = rsm.getColumnCount();
								for(int i=0; i<9; i++){
									if(i<col){
										ds.map.put("c"+i, rsm.getColumnName(i+1));
									}else{
										ds.map.put("c"+i, "");
									}
								}
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
							}else if (rid == 1 ){
								ResultSetMetaData rsm =rs.getMetaData(); //获得列集
								int col = rsm.getColumnCount();
								for(int i=0; i<9; i++){
									if(i<col){
										ds.map.put("c"+i, rsm.getColumnName(i+1));
									}else{
										ds.map.put("c"+i, "");
									}
								}
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list2.add(map);
							}
						}
					}
					if(rs != null){
						cs.getMoreResults();
						rid++;
						continue;
					}
				}while(!(updateCount == -1 && rs == null));
				return null;
			}
		});
	}

	/** 更新关键项目信息 */
	public void saveVillageProjectInfo(final DotSession ds, final GovVillageProjectForm govVillageProjectForm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_chunprj_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, govVillageProjectForm.getVptxt()[14]);
				cs.setString(2, crid);
				cs.setString(3, govVillageProjectForm.getVptxt()[15]);
				cs.setString(4, govVillageProjectForm.getVptxt()[0]);
				cs.setString(5, govVillageProjectForm.getVptxt()[1]);
				cs.setFloat(6, Float.parseFloat(govVillageProjectForm.getVptxt()[2]));
				cs.setFloat(7, Float.parseFloat(govVillageProjectForm.getVptxt()[3]));
				cs.setFloat(8, Float.parseFloat(govVillageProjectForm.getVptxt()[4]));
				cs.setFloat(9, Float.parseFloat(govVillageProjectForm.getVptxt()[5]));
				cs.setFloat(10, Float.parseFloat(govVillageProjectForm.getVptxt()[6]));
				cs.setFloat(11, Float.parseFloat(govVillageProjectForm.getVptxt()[7]));
				cs.setFloat(12, Float.parseFloat(govVillageProjectForm.getVptxt()[8]));
				cs.setFloat(13, Float.parseFloat(govVillageProjectForm.getVptxt()[9]));
				cs.setFloat(14, Float.parseFloat(govVillageProjectForm.getVptxt()[10]));
				cs.setString(15, govVillageProjectForm.getVptxt()[11]);
				cs.setString(16, govVillageProjectForm.getVptxt()[12]);
				cs.setString(17, govVillageProjectForm.getVptxt()[13]);
				cs.execute();
				return null;
			}
		});
	}

	
	/**  */
	public void deleteVillageProjectInfoByPid(final String cm, final String crid, final String pid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_chunprj_delete(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, cm);
				cs.setString(2, crid);
				cs.setString(3, pid);
				cs.execute();
				return null;
			}
		});
	}

	public void getVillageProjectSeason(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "chunprj_items");
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

	public void getVillageProjectXian(final DotSession ds, final String navbm, final String crid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_chunprj_detail(?,?)}";
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

	public void getVillageProjectnavBybm(final DotSession ds, final String navbm) {
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
