package cn.voicet.dot.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.GovBrowerDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFamilyForm;

@SuppressWarnings({"unchecked", "deprecation","static-access"})
@Repository(GovBrowerDao.SERVICE_NAME)
public class GovBrowerDaoImpl extends CommonDaoImpl<Object> implements GovBrowerDao {
	
	/** 获取地区信息列表 */
	public void getGovBrowerList(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_bm_describle(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.curBM);
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
								int i=1;
								ds.map.put("name", rs.getString(i++));
								ds.map.put("hn", rs.getString(i++));
								ds.map.put("pn", rs.getString(i++));
								ds.map.put("htn", rs.getString(i++));
								ds.map.put("ptn", rs.getString(i++));
							}else if (rid == 1 ){
								map = new HashMap();
								if(ds.curBM.length()<=9){
									int i=1;
									map.put("m", rs.getString(i++));
									map.put("bm", rs.getString(i++));
									map.put("oname", rs.getString(i++));
									map.put("htn", rs.getString(i++));
									map.put("v1", rs.getString(i++));
									map.put("v2", rs.getString(i++));
									map.put("v3", rs.getString(i++));
									map.put("ptn", rs.getString(i++));
									map.put("cknum", rs.getString(i++));
								}else{
									int i=1;
									map.put("hm", rs.getString(i++));
									map.put("hname", rs.getString(i++));
									map.put("zhu", rs.getString(i++));
									map.put("population", rs.getString(i++));
									map.put("labornum", rs.getString(i++));
									map.put("fields", rs.getString(i++));
									map.put("house", rs.getString(i++));
									map.put("property", rs.getString(i++));
									map.put("dcause", rs.getString(i++));
									map.put("idcno", rs.getString(i++));
									map.put("telnum", rs.getString(i++));
									map.put("frname", rs.getString(i++));
									map.put("frtel", rs.getString(i++));
									map.put("frwork", rs.getString(i++));
									map.put("ischeck", rs.getString(i++));
								}
								ds.list.add(map);
							}else if(rid == 2){
								int i=1;
								map = new HashMap();
								map.put("m", rs.getString(i++));
								map.put("dcause", rs.getString(i++));
								ds.list2.add(map);
							}else if(rid ==3){
								int i=1;
								map = new HashMap();
								map.put("m", rs.getString(i++));
								map.put("property", rs.getString(i++));
								map.put("pn", rs.getString(i++));
								ds.list3.add(map);
							}else if(rid ==4){
								int i=1;
								map = new HashMap();
								map.put("name", rs.getString(i++));
								map.put("hnum", rs.getString(i++));
								map.put("val", rs.getString(i++));
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

	/** 获家庭详细信息 */
	public void getGovFamilyList(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				ds.initData();
				String proc = "{call sp_family_detail(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.curHM);
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
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
								int i=1;
								//map = new HashMap();
								ds.map.put("hm", rs.getString(i++));
								ds.map.put("hname", rs.getString(i++));
								ds.map.put("zhu", rs.getString(i++));
								ds.map.put("population", rs.getString(i++));
								ds.map.put("labornum", rs.getString(i++));
								ds.map.put("fields", rs.getString(i++));
								ds.map.put("house", rs.getString(i++));
								ds.map.put("property", rs.getString(i++));
								ds.map.put("telnum", rs.getString(i++));
								ds.map.put("dcause", rs.getString(i++));
								ds.map.put("idcno", rs.getString(i++));
								ds.map.put("frname", rs.getString(i++));
								ds.map.put("frtel", rs.getString(i++));
								ds.map.put("frwork", rs.getString(i++));
								String year = rs.getString(i++);
								ds.map.put("lastyear", year);
								
								ds.map.put("intotal", rs.getString(i++));
								ds.map.put("inpersonal", rs.getString(i++));
								if(Integer.valueOf(year)<Calendar.getInstance().get(Calendar.YEAR)){
									ds.map.put("addyear", 1);
								}else{
									ds.map.put("addyear", 0);
								}
								//ds.map=map;
							}else if (rid == 1 ){
								int i=1;
								map = new HashMap();
								map.put("mid", rs.getString(i++));
								map.put("uname", rs.getString(i++));
								map.put("sex", rs.getString(i++));
								map.put("age", rs.getString(i++));
								map.put("school", rs.getString(i++));
								map.put("education", rs.getString(i++));
								map.put("health", rs.getString(i++));
								map.put("dcno", rs.getString(i++));
								map.put("labors", rs.getString(i++));
								map.put("works", rs.getString(i++));
								map.put("bla", rs.getString(i++));
								map.put("tbfd", rs.getString(i++));
								ds.list.add(map);
							}else if(rid == 2){
								int i=1;
								map = new HashMap();
								map.put("hm", rs.getString(i++));
								map.put("year", rs.getString(i++));
								map.put("inTotal", rs.getString(i++));
								map.put("inCrop", rs.getString(i++));
								map.put("inLivstock", rs.getString(i++));
								map.put("inWork", rs.getString(i++));
								map.put("inBla", rs.getString(i++));
								map.put("inSubside", rs.getString(i++));
								map.put("inOther", rs.getString(i++));
								map.put("inPersonal", rs.getString(i++));
								map.put("grantAid", rs.getString(i++));
								map.put("share", rs.getString(i++));
								map.put("pettyLoan", rs.getString(i++));
								map.put("labTrain", rs.getString(i++));
								map.put("labJob", rs.getString(i++));
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

	/** 修改地区名称信息  */
	public void updateGovDataInfo(final DotSession ds, final String insBm, final String insName, final int insHtn, final int insPtn) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_update = "{call sp_govdata_update(?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc_update);
				cs.setString(1, ds.rbm);
				cs.setString(2, insBm);
				cs.setString(3, insName);
				cs.setInt(4, insHtn);
				cs.setInt(5, insPtn);
				cs.execute();
				return null;
			}
		});
	}

	/** 保存或更新家庭基本信息 */
	public void saveFamilyInfo(final DotSession ds, final GovFamilyForm govFamilyForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc_insert = "{call sp_family_insert(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				String proc_update = "{call sp_family_update(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = null;
				if(ds.curHM.equals("")){
					cs = conn.prepareCall(proc_insert);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curBM);
					cs.setString(3, govFamilyForm.getHname());
					cs.setString(4, govFamilyForm.getZhu());
					cs.setString(5, govFamilyForm.getFields());
					cs.setString(6, govFamilyForm.getHouse());
					cs.setInt(7, govFamilyForm.getProperty());
					cs.setInt(8, govFamilyForm.getDcause());
					cs.setString(9, govFamilyForm.getIdcno());
					cs.setString(10, govFamilyForm.getHtel());
					cs.setString(11, govFamilyForm.getFrname());
					cs.setString(12, govFamilyForm.getFrtel());
					cs.setString(13, govFamilyForm.getFrwork());
					cs.execute();
					ResultSet rs = cs.getResultSet();
					if(rs!=null){
						rs.next();
					}
					String bhm = (String) rs.getObject("hm");
					if(bhm!=null && !bhm.equals("none")){
						ds.curHM = bhm;
					}
				}else{
					cs = conn.prepareCall(proc_update);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curHM);
					cs.setString(3, govFamilyForm.getHname());
					cs.setString(4, govFamilyForm.getZhu());
					cs.setString(5, govFamilyForm.getFields());
					cs.setString(6, govFamilyForm.getHouse());
					cs.setInt(7, govFamilyForm.getProperty());
					cs.setInt(8, govFamilyForm.getDcause());
					cs.setString(9, govFamilyForm.getIdcno());
					cs.setString(10, govFamilyForm.getHtel());
					cs.setString(11, govFamilyForm.getFrname());
					cs.setString(12, govFamilyForm.getFrtel());
					cs.setString(13, govFamilyForm.getFrwork());
					cs.execute();
				}
				return null;
			}
		});
	}
	
	/** 保存或更新成员信息  */
	public void saveMemberInfo(final DotSession ds, final int mid, final String uname, final int sex, final int age,
			final int school, final int education, final int health, final String dcno,
			final int labors, final int works, final int bla, final int tbfd) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				String proc_insert = "{call sp_member_insert(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				String proc_update = "{call sp_member_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs;
				if(mid==0){
					cs = conn.prepareCall(proc_insert);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curHM);
					cs.setString(3, uname);
					cs.setInt(4, sex);
					cs.setInt(5, age);
					cs.setInt(6, school);
					cs.setInt(7, education);
					cs.setInt(8, health);
					cs.setString(9, dcno);
					cs.setInt(10, labors);
					cs.setInt(11, works);
					cs.setInt(12, bla);
					cs.setInt(13, tbfd);
				}else{
					cs = conn.prepareCall(proc_update);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curHM);
					cs.setInt(3, mid);
					cs.setString(4, uname);
					cs.setInt(5, sex);
					cs.setInt(6, age);
					cs.setInt(7, school);
					cs.setInt(8, education);
					cs.setInt(9, health);
					cs.setString(10, dcno);
					cs.setInt(11, labors);
					cs.setInt(12, works);
					cs.setInt(13, bla);
					cs.setInt(14, tbfd);
				}
				cs.execute();
				return null;
			}
		});
	}

	/** 保存或更新家庭收入及帮扶情况  */
	public void saveYearInfo(final DotSession ds, final GovFamilyForm govFamilyForm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				String proc_insert = "{call sp_year_insert(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				String proc_update = "{call sp_year_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs;
				if(govFamilyForm.getIncomearr()[0].equals("0")){
					cs = conn.prepareCall(proc_insert);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curHM);
					cs.setString(3, govFamilyForm.getIncomearr()[1]);
					cs.setFloat(4, Float.valueOf(govFamilyForm.getIncomearr()[2]));
					cs.setFloat(5, Float.valueOf(govFamilyForm.getIncomearr()[3]));
					cs.setFloat(6, Float.valueOf(govFamilyForm.getIncomearr()[4]));
					cs.setFloat(7, Float.valueOf(govFamilyForm.getIncomearr()[5]));
					cs.setFloat(8, Float.valueOf(govFamilyForm.getIncomearr()[6]));
					cs.setFloat(9, Float.valueOf(govFamilyForm.getIncomearr()[7]));
					cs.setFloat(10, Float.valueOf(govFamilyForm.getIncomearr()[8]));
					cs.setFloat(11, Float.valueOf(govFamilyForm.getIncomearr()[9]));
					cs.setFloat(12, Float.valueOf(govFamilyForm.getIncomearr()[10]));
					cs.setInt(13, Integer.valueOf(govFamilyForm.getIncomearr()[11]));
					cs.setInt(14, Integer.valueOf(govFamilyForm.getIncomearr()[12]));
				}else{
					cs = conn.prepareCall(proc_update);
					cs.setString(1, ds.rbm);
					cs.setString(2, ds.curHM);
					cs.setString(3, govFamilyForm.getIncomearr()[1]);
					cs.setFloat(4, Float.valueOf(govFamilyForm.getIncomearr()[2]));
					cs.setFloat(5, Float.valueOf(govFamilyForm.getIncomearr()[3]));
					cs.setFloat(6, Float.valueOf(govFamilyForm.getIncomearr()[4]));
					cs.setFloat(7, Float.valueOf(govFamilyForm.getIncomearr()[5]));
					cs.setFloat(8, Float.valueOf(govFamilyForm.getIncomearr()[6]));
					cs.setFloat(9, Float.valueOf(govFamilyForm.getIncomearr()[7]));
					cs.setFloat(10, Float.valueOf(govFamilyForm.getIncomearr()[8]));
					cs.setFloat(11, Float.valueOf(govFamilyForm.getIncomearr()[9]));
					cs.setFloat(12, Float.valueOf(govFamilyForm.getIncomearr()[10]));
					cs.setInt(13, Integer.valueOf(govFamilyForm.getIncomearr()[11]));
					cs.setInt(14, Integer.valueOf(govFamilyForm.getIncomearr()[12]));
				}
				cs.execute();
				return null;
			}
		});
	}

	/** 删除成员信息  */
	public void deleteMemberInfo(final DotSession ds, final int mid) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_member_delete(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, ds.curHM);
				cs.setInt(3, mid);
				cs.execute();
				return null;
			}
		});
	}

	/** 打印家庭详细信息 */
	public void getReportFamilyInfo(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Map map;
				String proc = "{call sp_rpt_family(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.curHM);
				ds.initData();
				cs.execute();
				ResultSet rs = null;
				int rid=0;
				int updateCount = -1;
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
								int i=1;
								ds.map.put("x", rs.getString(i++));
								ds.map.put("xx", rs.getString(i++));
								ds.map.put("c", rs.getString(i++));
								ds.map.put("z", rs.getString(i++));
								ds.map.put("y1", rs.getString(i++));
								ds.map.put("y2", rs.getString(i++));
								ds.map.put("y3", rs.getString(i++));
								ds.map.put("y4", rs.getString(i++));
								ds.map.put("y5", rs.getString(i++));
								ds.map.put("xm", rs.getString(i++));
								ds.map.put("xxm", rs.getString(i++));
								ds.map.put("cm", rs.getString(i++));
								ds.map.put("hm", rs.getString(i++));
								ds.map.put("population", rs.getString(i++));
								ds.map.put("labornum", rs.getString(i++));
								ds.map.put("fields", rs.getString(i++));
								ds.map.put("house", rs.getString(i++));
								ds.map.put("property", rs.getString(i++));
								ds.map.put("telnum", rs.getString(i++));
								ds.map.put("dcause", rs.getString(i++));
								ds.map.put("idcno", rs.getString(i++));
								ds.map.put("frname", rs.getString(i++));
								ds.map.put("frtel", rs.getString(i++));
								ds.map.put("frwork", rs.getString(i++));
							}else if (rid == 1 ){
								int i=1;
								map = new HashMap();
								map.put("uname", rs.getString(i++));
								map.put("sex", rs.getString(i++));
								map.put("age", rs.getString(i++));
								map.put("school", rs.getString(i++));
								map.put("education", rs.getString(i++));
								map.put("health", rs.getString(i++));
								map.put("dcno", rs.getString(i++));
								map.put("labors", rs.getString(i++));
								map.put("works", rs.getString(i++));
								map.put("bla", rs.getString(i++));
								map.put("tbfd", rs.getString(i++));
								ds.list.add(map);
							}else if(rid == 2){
								int i=1;
								map = new HashMap();
								map.put("ids", rs.getString(i++));
								map.put("unit", rs.getString(i++));
								map.put("code", rs.getString(i++));
								map.put("v1", rs.getString(i++));
								map.put("v2", rs.getString(i++));
								map.put("v3", rs.getString(i++));
								map.put("v4", rs.getString(i++));
								map.put("v5", rs.getString(i++));
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

	public void getReportFamilyInfo(final DotSession ds, final int year) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_bmfp_query(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.curBM);
				cs.setInt(2, year);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.map.put("proYear", year);
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

	/** 获取家庭年收入信息Tab2 */
	public void findFamilyYearInfoWithTab2(final DotSession ds) {
	getHibernateTemplate().execute(new HibernateCallback() {
		public Object doInHibernate(Session session) throws HibernateException,
				SQLException {
			Map map;
			ds.initData();
			String proc = "{call sp_family_detail(?)}";
			Connection conn = session.connection();
			CallableStatement cs = conn.prepareCall(proc);
			cs.setString(1, ds.curHM);
			cs.execute();
			ds.list5 = new ArrayList();
			ResultSet rs = null;
			int rid=0;
			int updateCount = -1;
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
							int i=1;
							//map = new HashMap();
							ds.map.put("hm", rs.getString(i++));
							ds.map.put("hname", rs.getString(i++));
							ds.map.put("zhu", rs.getString(i++));
							ds.map.put("population", rs.getString(i++));
							ds.map.put("labornum", rs.getString(i++));
							ds.map.put("fields", rs.getString(i++));
							ds.map.put("house", rs.getString(i++));
							ds.map.put("property", rs.getString(i++));
							ds.map.put("telnum", rs.getString(i++));
							ds.map.put("dcause", rs.getString(i++));
							ds.map.put("idcno", rs.getString(i++));
							ds.map.put("frname", rs.getString(i++));
							ds.map.put("frtel", rs.getString(i++));
							ds.map.put("frwork", rs.getString(i++));
							String year = rs.getString(i++);
							ds.map.put("lastyear", year);
							
							ds.map.put("intotal", rs.getString(i++));
							ds.map.put("inpersonal", rs.getString(i++));
							if(Integer.valueOf(year)<Calendar.getInstance().get(Calendar.YEAR)){
								ds.map.put("addyear", 1);
							}else{
								ds.map.put("addyear", 0);
							}
							//ds.map=map;
						}else if (rid == 1 ){
							int i=1;
							map = new HashMap();
							map.put("mid", rs.getString(i++));
							map.put("uname", rs.getString(i++));
							map.put("sex", rs.getString(i++));
							map.put("age", rs.getString(i++));
							map.put("school", rs.getString(i++));
							map.put("education", rs.getString(i++));
							map.put("health", rs.getString(i++));
							map.put("dcno", rs.getString(i++));
							map.put("labors", rs.getString(i++));
							map.put("works", rs.getString(i++));
							map.put("bla", rs.getString(i++));
							map.put("tbfd", rs.getString(i++));
							ds.list.add(map);
						}else if(rid == 2){
							map = new HashMap();
							ds.putMapData(map, rs);
							ds.list5.add(map);
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

	public void isDirectWithBmHm(final DotSession ds) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_bmhm_directin(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, ds.rbm);
				cs.setString(3, (String)ds.map.get("bmhm"));
				cs.execute();
				ResultSet rs = cs.getResultSet();
				ds.map = new HashMap();
				if(rs!=null){
					while (rs.next()) {
						ds.map.put("isbh", rs.getString("result"));
					}
				}
				return null;
			}
		});
	}

	public void deleteFamilyWithHbm(final DotSession ds, final String hbm, final int cause) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_family_delete(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.account);
				cs.setString(2, hbm);
				cs.setInt(3, cause);
				cs.execute();
				return null;
			}
		});
	}

	public void checkFamilyInfoByHbm(final DotSession ds, final String hbm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_family_check(?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, hbm);
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

	public String findNavListStr(final DotSession ds) {
		String str = (String)getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_bm_getfullpath(?,?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.bmhm);
				cs.setString(2, ds.rbm);
				cs.registerOutParameter(3, Types.VARCHAR);
				cs.execute();
				return cs.getObject(3);
			}
		});
		return str;
	}

	public void checkCunInfoByCunBM(final DotSession ds, final String cunbm) {
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String proc = "{call sp_chun_check(?,?)}";
				Connection conn = session.connection();
				CallableStatement cs = conn.prepareCall(proc);
				cs.setString(1, ds.rbm);
				cs.setString(2, cunbm);
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

}
