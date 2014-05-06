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

import cn.voicet.dot.dao.GovFarmerStatsDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

@SuppressWarnings({"deprecation","unchecked","static-access"})
@Repository(GovFarmerStatsDao.SERVICE_NAME)
public class GovFarmerStatsDaoImpl extends CommonDaoImpl<Object> implements GovFarmerStatsDao {

	public void getFarmerSumInfo(final DotSession ds,
			final GovFarmerStatsForm govFarmerStatsForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_analy_family_group(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				ds.initData();
				cs.setString(1, ds.curBM);
				cs.setString(2, govFarmerStatsForm.getAid());
				cs.setString(3, govFarmerStatsForm.getTjstr());
				cs.setString(4, govFarmerStatsForm.getParam());
				ds.map.put("aidFarmer", govFarmerStatsForm.getAid());
				ds.map.put("tjstrFarmer", govFarmerStatsForm.getTjstr());
				ds.map.put("paramFarmer", govFarmerStatsForm.getParam());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list5 = new ArrayList();
				ResultSetMetaData rsm =rs.getMetaData(); //获得列集
				int col = rsm.getColumnCount();
				for(int i=0; i<10; i++){
					if(i<col){
						ds.map.put("c"+i, rsm.getColumnName(i+1));
					}else{
						ds.map.put("c"+i, "");
					}
				}
				ds.list5 = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapData(map, rs);
		        		ds.list5.add(map);
					}
				}
				return null;
			}
		});
	}

}
