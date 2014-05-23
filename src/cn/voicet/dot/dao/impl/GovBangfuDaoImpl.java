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

import cn.voicet.dot.dao.GovBangfuDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovBangfuForm;

@Repository(GovBangfuDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovBangfuDaoImpl extends CommonDaoImpl<Object> implements GovBangfuDao {

	/** 双月报列表 */
	public void getBangfuMonth(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "hourfang_items");
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
	
	/** 查询指定县 省级后方单位挂钩帮扶情况 */
	public void getBangfuInfoByDept(final DotSession ds, final String rid, final String fuid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);	//报告编号
				cs.setString(3, "1");
				cs.setString(4, fuid);
				cs.setString(5, null);
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
							}else if (rid == 1 ){
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
	
	public void getBangfuInfoByXian(final DotSession ds, final String rid, final String fuid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);	//报告编号
				cs.setString(3, "2");
				cs.setString(4, fuid);
				cs.setString(5, null);
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
	
	public void getXianInfoWithDept(final DotSession ds, final String fuid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setInt(2, 1);	//报告编号
				cs.setString(3, "0");
				cs.setString(4, fuid);
				cs.setString(5, null);
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
							}else if (rid == 1 ){
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

	public void getDeptInfoWithXian(final DotSession ds, final String rid, final String xm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);	//报告编号
				cs.setString(3, "0");
				cs.setString(4, null);
				cs.setString(5, xm);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.list = new ArrayList();
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
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
	
	/** 更新帮扶信息 */
	public void saveBangfuInfo(final DotSession ds, final GovBangfuForm govBangfuForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_hourfang_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, ds.rbm);
				cs.setString(2, govBangfuForm.getBftxt()[13]);	//报告编号
				cs.setString(3, govBangfuForm.getBftxt()[0]);
				cs.setString(4, govBangfuForm.getBftxt()[1]);
				cs.setString(5, govBangfuForm.getBftxt()[2]);
				cs.setString(6, govBangfuForm.getBftxt()[3]);
				cs.setFloat(7, Float.parseFloat(govBangfuForm.getBftxt()[4]));
				cs.setString(8, govBangfuForm.getBftxt()[5]);
				cs.setFloat(9, Float.parseFloat(govBangfuForm.getBftxt()[6]));
				cs.setFloat(10, Float.parseFloat(govBangfuForm.getBftxt()[7]));
				cs.setString(11, govBangfuForm.getBftxt()[8]);
				cs.setString(12, govBangfuForm.getBftxt()[9]);
				cs.setFloat(13, Float.parseFloat(govBangfuForm.getBftxt()[10]));
				cs.setString(14, govBangfuForm.getBftxt()[11]);
				cs.setString(15, govBangfuForm.getBftxt()[12]);
				cs.execute();
				return null;
			}
		});
	}
	
	/** 更新帮扶信息 */
	public void saveBangfuDeptName(final DotSession ds, final GovBangfuForm govBangfuForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_hourfang_gov_update(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				cs = conn.prepareCall(proc_update);
				cs.setString(1, ds.rbm);
				cs.setString(2, govBangfuForm.getBftxt()[0]);
				cs.setString(3, govBangfuForm.getBftxt()[2]);
				cs.setString(4, govBangfuForm.getBftxt()[1]);
				cs.execute();
				return null;
			}
		});
	}

	/** 删除帮扶信息 */
	public void deleteBangfuInfoWithIid(final DotSession ds, final String rid, final String iid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call sp_hourfang_delete(?,?,?)}");
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);
				cs.setString(3, iid);	//批次
				cs.execute();
				return null;
			}
		});
	}

	
	public void getBangfuInfoWithGroup(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_gov_query(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.list = new ArrayList();
				ds.list2 = new ArrayList();
				ds.list3 = new ArrayList();
				ds.list4 = new ArrayList();
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
							}else if (rid == 1 ){
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list2.add(map);
							}else if (rid == 2){
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list3.add(map);
							}else if (rid == 3){
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list4.add(map);
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
	
	/** 后方单位管理--单位列表 */
	public void getBangfuDeptList(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_gov_query_all(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.list = new ArrayList();
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
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

	public void getDeptInfoWithReport(final DotSession ds, final String rid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);	//报告编号
				cs.setString(3, "3");
				cs.setString(4, null);
				cs.setString(5, null);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.list = new ArrayList();
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
								map = new HashMap();
								ds.putMapData(map, rs);
								ds.list.add(map);
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

	public void deleteBangfuDeptByfuid(final DotSession ds, final String fuid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call sp_hourfang_gov_delete(?,?)}");
				cs.setString(1, ds.rbm);
				cs.setString(2, fuid);	//批次
				cs.execute();
				return null;
			}
		});
	}

	public void getExcelFieldDataListByDept(final DotSession ds, final String rid,
			final String fuid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_hourfang_detail(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, rid);	//报告编号
				cs.setString(3, "1");
				cs.setString(4, fuid);
				cs.setString(5, null);
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
	
}
