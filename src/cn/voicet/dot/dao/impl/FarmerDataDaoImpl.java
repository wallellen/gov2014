package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.FarmerDataDao;
import cn.voicet.dot.util.DotSession;

@Repository(FarmerDataDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class FarmerDataDaoImpl extends CommonDaoImpl<Object> implements FarmerDataDao {
	
	public void batchImportFarmerData(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				PreparedStatement ps = null;
				String vl[];
	        	String storedProc = "{call mp_import_family(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
	        	//关闭事务自动提交
	        	conn.setAutoCommit(false);
	        	ps = conn.prepareStatement(storedProc);
				int rownum = 0;
				for(int i=0; i<ds.list.size(); i++){
					vl = (String[]) ds.list.get(i);
					ps.setString(1, vl[0]);	//户码
					ps.setString(2, vl[1]);	//组名
					ps.setString(3, vl[2]);	//户主姓名
					ps.setString(4, vl[3]);	//人口
					ps.setString(5, vl[4]);	//劳动力
					ps.setString(6, vl[5]);//耕地
					ps.setString(7, vl[6]);//住房
					ps.setString(8, vl[7]);	//农户属性
					ps.setString(9, vl[8]);	//电话号码
					ps.setString(10, vl[9]);	//贫困原因
					ps.setString(11, vl[10]);//身份证号码
					ps.setString(12, vl[11]);	//帮扶人姓名
					ps.setString(13, vl[12]);	//帮扶人电话号码
					ps.setString(14, vl[13]);	//帮扶人职务
		        	//
					ps.addBatch();
		        	if(++rownum >= 1000){
		        		//执行批量更新    
		        		ps.executeBatch();
		        		//语句执行完毕，提交本事务 
		        		conn.commit();
		        		ps.clearBatch();
		        		rownum = 0;
		        	}
				}
				if(rownum > 0){
					ps.executeBatch();
					conn.commit();
					ps.clearBatch();
					
				}
				if(ps != null){
					ps.close();
				}
				return null;
			}
		});
	}

	public void emptyFarmerDataByXm(final DotSession ds, final String xm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call mp_family_empty(?,?)}");
				cs.setString(1, ds.account);
				cs.setString(2, xm);
				cs.execute();
				return null;
			}
		});
	}

	public void getOpnameByXm(final DotSession ds, final String xm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall("{call ybh_getopnamebyxm(?)}");
				cs.setString(1, xm);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				if(null != rs)
				{
					while(rs.next()){
						ResultSetMetaData rsm =rs.getMetaData();
						int colCount = rsm.getColumnCount();
						String colName;
						for(int i=1; i<=colCount; i++)
						{
							colName=rsm.getColumnName(i);
							ds.map.put(colName, rs.getString(colName));
						}
					}
				}
				return null;
			}
		});
	}
}
