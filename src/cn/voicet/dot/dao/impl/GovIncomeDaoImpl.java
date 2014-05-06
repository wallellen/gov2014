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

import cn.voicet.dot.dao.GovIncomeDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovIncomeForm;

@Repository(GovIncomeDao.SERVICE_NAME)
@SuppressWarnings({"deprecation","unchecked","static-access"})
public class GovIncomeDaoImpl extends CommonDaoImpl<Object> implements GovIncomeDao {

	public void getIncomeYear(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_report_list(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, "year_items");
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

	/** 查看年收入 */
	public void getIncomeInfoBycbm(final DotSession ds, final String cbm, final String year) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_year_describle(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, cbm);
				cs.setString(2, year);
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

	public void saveIncomeYear(final DotSession ds, final GovIncomeForm govIncomeForm,
			final String year) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				String sp_insert = "{call sp_year_insert(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				String sp_update = "{call sp_year_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs;
				if(govIncomeForm.getInstr()[0].equals("0")){
					cs = conn.prepareCall(sp_insert);
					cs.setString(1, ds.rbm);
					cs.setString(2, govIncomeForm.getInstr()[1]);
					cs.setFloat(3, Float.parseFloat(govIncomeForm.getInstr()[2]));
					cs.setFloat(4, Float.parseFloat(govIncomeForm.getInstr()[3]));
					cs.setFloat(5, Float.parseFloat(govIncomeForm.getInstr()[4]));
					cs.setFloat(6, Float.parseFloat(govIncomeForm.getInstr()[5]));
					cs.setFloat(7, Float.parseFloat(govIncomeForm.getInstr()[6]));
					cs.setFloat(8, Float.parseFloat(govIncomeForm.getInstr()[7]));
					cs.setFloat(9, Float.parseFloat(govIncomeForm.getInstr()[8]));
					cs.setFloat(10, Float.parseFloat(govIncomeForm.getInstr()[9]));
					cs.setFloat(11, Float.parseFloat(govIncomeForm.getInstr()[10]));
					cs.setFloat(12, Float.parseFloat(govIncomeForm.getInstr()[11]));
					cs.setFloat(13, Float.parseFloat(govIncomeForm.getInstr()[12]));
					
				}else{
					cs = conn.prepareCall(sp_update);
					cs.setString(1, ds.rbm);
					cs.setString(2, govIncomeForm.getInstr()[1]);
					cs.setString(3, year);
					cs.setFloat(4, Float.parseFloat(govIncomeForm.getInstr()[2]));
					cs.setFloat(5, Float.parseFloat(govIncomeForm.getInstr()[3]));
					cs.setFloat(6, Float.parseFloat(govIncomeForm.getInstr()[4]));
					cs.setFloat(7, Float.parseFloat(govIncomeForm.getInstr()[5]));
					cs.setFloat(8, Float.parseFloat(govIncomeForm.getInstr()[6]));
					cs.setFloat(9, Float.parseFloat(govIncomeForm.getInstr()[7]));
					cs.setFloat(10, Float.parseFloat(govIncomeForm.getInstr()[8]));
					cs.setFloat(11, Float.parseFloat(govIncomeForm.getInstr()[9]));
					cs.setFloat(12, Float.parseFloat(govIncomeForm.getInstr()[10]));
					cs.setFloat(13, Float.parseFloat(govIncomeForm.getInstr()[11]));
					cs.setFloat(14, Float.parseFloat(govIncomeForm.getInstr()[12]));
				}
				cs.execute();
				return null;
			}
		});
	}
	
}
