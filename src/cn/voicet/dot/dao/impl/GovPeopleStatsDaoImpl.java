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

import cn.voicet.dot.dao.GovPeopleStatsDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovPeopleStatsForm;

@SuppressWarnings({"deprecation","unchecked","static-access"})
@Repository(GovPeopleStatsDao.SERVICE_NAME)
public class GovPeopleStatsDaoImpl extends CommonDaoImpl<Object> implements GovPeopleStatsDao {

	public void getPeopleSumInfo(final DotSession ds,
			final GovPeopleStatsForm govPeopleStatsForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_analy_people_group(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				ds.initData();
				cs.setString(1, ds.curBM);
				cs.setString(2, govPeopleStatsForm.getAid());
				cs.setString(3, govPeopleStatsForm.getTjstr());
				ds.map.put("aidPeople", govPeopleStatsForm.getAid());
				ds.map.put("tjstrPeople", govPeopleStatsForm.getTjstr());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list5 = new ArrayList();
				ds.map.remove("c2");
				ds.map.remove("c3");
				ds.map.remove("c4");
				ds.map.remove("c5");
				ds.map.remove("c6");
				ds.map.remove("c7");
				ds.map.remove("c8");
				ds.map.remove("c9");
				ResultSetMetaData rsm =rs.getMetaData(); //获得列集
				int col = rsm.getColumnCount();
				for(int i=0; i<9; i++){
					if(i<col){
						ds.map.put("c"+i, rsm.getColumnName(i+1));
					}else{
						ds.map.put("c"+i, "");
					}
				}
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
