package cn.voicet.dot.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.MemberDataDao;
import cn.voicet.dot.util.DotSession;

@Repository(MemberDataDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class MemberDataDaoImpl extends CommonDaoImpl<Object> implements MemberDataDao {
	
	public void batchImportMemberData(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				PreparedStatement ps = null;
				String vl[];
	        	String storedProc = "{call sp_member_import_byweb(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
	        	//关闭事务自动提交
	        	conn.setAutoCommit(false);
	        	ps = conn.prepareStatement(storedProc);
	        	try {
					int rownum = 0;
					for(int i=0; i<ds.list.size(); i++){
						vl = (String[]) ds.list.get(i);
						ps.setString(1, vl[0]);
						ps.setInt(2, Integer.parseInt(vl[1]));
						ps.setFloat(3, Float.parseFloat(vl[2]));
						ps.setFloat(4, Float.parseFloat(vl[3]));
						ps.setFloat(5, Float.parseFloat(vl[4]));
						ps.setFloat(6, Float.parseFloat(vl[5]));
						ps.setFloat(7, Float.parseFloat(vl[6]));
						ps.setFloat(8, Float.parseFloat(vl[7]));
						ps.setFloat(9, Float.parseFloat(vl[8]));
						ps.setFloat(10, Float.parseFloat(vl[9]));
						ps.setFloat(11, Float.parseFloat(vl[10]));
						ps.setFloat(12, Float.parseFloat(vl[11]));
						ps.setFloat(13, Float.parseFloat(vl[12]));
						ps.setInt(14, Integer.parseInt(vl[13]));
						ps.setInt(15, Integer.parseInt(vl[14]));
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
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}
}
