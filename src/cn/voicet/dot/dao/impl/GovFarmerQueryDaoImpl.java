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

import cn.voicet.dot.dao.GovFarmerQueryDao;
import cn.voicet.dot.util.DotSession;

@SuppressWarnings({"deprecation","unchecked","static-access"})
@Repository(GovFarmerQueryDao.SERVICE_NAME)
public class GovFarmerQueryDaoImpl extends CommonDaoImpl<Object> implements GovFarmerQueryDao {
	
	public void getFarmerInfoList(final DotSession ds) {
		final int apr[]={0,1,2,4,6,7,9,11,12,14,16};
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String str = "";
				String proc = "{call sp_query_family(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, ds.curBM);
				
				String a[]=(String[]) ds.map.get("qarr");
				for(int i=0; i<11; i++)
				{
					if(a[apr[i]].length()>0)
					{
						if(i<2)
							str+=a[apr[i]];
						else if((i-2)%3==2)
						{
							if(!a[apr[i]].equals("0"))
							{
								str+=a[apr[i]];
							}
						}
						else
						{
							if(a[apr[i]].equals("1") && a[apr[i]+1].length()>0) 
							{
								str+=">=";
								str+=a[apr[i]+1];
							}
							else if(a[apr[i]].equals("2") && a[apr[i]+1].length()>0)
							{
								str+="<=";
								str+=a[apr[i]+1];
							}
						}
					}
					str+=";";
				}
				System.out.println(str);
				cs.setString(3, str);
				cs.registerOutParameter(4, Types.INTEGER);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list5 = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapData(map,rs);
		        		ds.list5.add(map);
					}
				}
				//取出参(农户总数)
				ds.map.put("farmernt", cs.getObject(4));
				return null;
			}
		});
	}
	
	public void getMemberInfoList(final DotSession ds) {
		final int apr[]={0,1,2,4,5,6,7,8,9};
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String str = "";
				String proc = "{call sp_query_member(?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, ds.curBM);
				String a[]=(String[]) ds.map.get("marr");
				for(int i=0; i<9; i++)
				{
					if(a[apr[i]].length()>0)
					{
						if(i!=2)
						{
							if(!a[apr[i]].equals("0")){
								str+=a[apr[i]];
							}
						}
						else
						{
							if(a[apr[i]].equals("1") && a[apr[i]+1].length()>0) 
							{
								str+=">=";
								str+=a[apr[i]+1];
							}
							else if(a[apr[i]].equals("2") && a[apr[i]+1].length()>0)
							{
								str+="<=";
								str+=a[apr[i]+1];
							}
						}
					}
					str+=";";
				}
				System.out.println(str);
				cs.setString(3, str);
				cs.registerOutParameter(4, Types.INTEGER);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.list = new ArrayList();
				Map map;
				if(rs!=null){
					while (rs.next()) {
						map = new HashMap();
						ds.putMapData(map,rs);
		        		ds.list.add(map);
					}
				}
				//取出参(人口总数)
				ds.map.put("membernt", cs.getObject(4));
				return null;
			}
		});
	}

}
