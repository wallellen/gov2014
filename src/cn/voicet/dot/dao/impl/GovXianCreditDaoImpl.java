package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.GovXianCreditDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovXianCreditForm;

@Repository(GovXianCreditDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovXianCreditDaoImpl extends CommonDaoImpl<Object> implements GovXianCreditDao {

	public void getXianCreditYear(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "xianxiaoeyear_items");
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

	public void getCreditInfoWithYear(final DotSession ds, final String year, final int month, final int mode) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_list(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, month);
				cs.setInt(4, 0);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
				ds.initData();
				Map map;
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
								ds.putMapDataByColName(map, rs);
				        		ds.list.add(map);
							}else if (rid == 1 ){
								ds.map = new HashMap(); 
								ds.putMapDataByColName(ds.map, rs);
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

	public void deleteCreditInfoWithYearMonth(final DotSession ds, final String year,
			final int month) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_delete(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, month);
				cs.execute();
				return null;
			}
		});
	}

	public void getShenCreditReportList(final DotSession ds, final String year, final int month,
			final int mode) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_list(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, 1);
				cs.setInt(4, 2);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.initData();
				ds.list = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapDataByColName(map, rs);
		        		ds.list.add(map);
					}
				}
				return null;
			}
		});		
	}

	public void getCreditMonthReportList(final DotSession ds, final String year, final int month,
			final int mode) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_list(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, month);
				cs.setInt(4, 1);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.initData();
				ds.list = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapDataByColName(map, rs);
		        		ds.list.add(map);
					}
				}
				return null;
			}
		});	
	}

	public void getXianCreditByXbm(final DotSession ds, final String year, final String xbm,
			final int month, final int mode) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_list(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, xbm);
				cs.setString(2, year);
				cs.setInt(3, month);
				cs.setInt(4, mode);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.initData();
				ds.list = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapDataByColName(map, rs);
		        		ds.list.add(map);
					}
				}
				return null;
			}
		});
	}

	public void getXianCreditMonth(final DotSession ds, final String year) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_list(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, 1);
				cs.setInt(4, 3);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.initData();
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

	public String saveCreditInfo(final DotSession ds, final String year, final int month,
			final int tsh, final float tsv, final int trh, final float trv, final int nh, final float nv, final int eh,
			final float ev) {
		String res = (String)getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_xiaoe_update(?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, year);
				cs.setInt(3, month);
				cs.setInt(4, tsh);
				cs.setFloat(5, tsv);
				cs.setInt(6, trh);
				cs.setFloat(7, trv);
				cs.setInt(8, nh);
				cs.setFloat(9, nv);
				cs.setInt(10, eh);
				cs.setFloat(11, ev);
				cs.registerOutParameter(12, Types.VARCHAR);
				cs.execute();
				return cs.getString(12);
			}
		});	
		return res;
	}
}
