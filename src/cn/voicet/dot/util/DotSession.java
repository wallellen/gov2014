package cn.voicet.dot.util;

import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

@SuppressWarnings("unchecked")
public class DotSession implements Serializable{

	private static Logger log = Logger.getLogger(DotSession.class);
	private static final long serialVersionUID = 8459257118802276422L;
	
	public String account;
	public String password;
	public String username;
	public String roleName;
	public String roleID;
	public SubPathTitle subPathTitle;
	public String rbm;
	public String rbn;
	public String curBM;
	public String curHM;
	public String navPath;
	public String opCode;//opera code tlype
	public int isedit;
	public int workyear;	//工作年
	public int yearlock;	//年锁定
	public int curGolbalPage;//全局当前页
	
	//private List stackList;
	public Map map;
	public List list;
	public List list2;
	public List list3;
	public List list4;
	public List list5;
	public List list6;
	public int curYear;	//当前年份
	private int stackPos=0;
	private StackInfo[] arrayStackInfo;
	
	public String bmhm;
	
	public int sflag;
	
	private class StackInfo{
		
		public StackInfo(){}
		List list;
		List list2;
		List list3;
		List list4;
		List list5;
		List list6;
	}
	public void pushAllList() {
		if(stackPos<8){
			arrayStackInfo[stackPos].list=list;
			arrayStackInfo[stackPos].list2=list2;
			arrayStackInfo[stackPos].list3=list3;
			arrayStackInfo[stackPos].list4=list4;
			arrayStackInfo[stackPos].list5=list5;
			arrayStackInfo[stackPos++].list6=list6;
		}
		log.info("pushAllList cur:"+stackPos);
	}
	public int getStackLevel(){
		return stackPos;
	}
	public boolean hasStack() {
		return stackPos>0;
	}
	
	public void popAllList() {
		if(stackPos>0){
			list=arrayStackInfo[--stackPos].list;
			list2=arrayStackInfo[stackPos].list2;
			list3=arrayStackInfo[stackPos].list3;
			list4=arrayStackInfo[stackPos].list4;
			list5=arrayStackInfo[stackPos].list5;
			list6=arrayStackInfo[stackPos].list6;
			arrayStackInfo[stackPos].list=null;
			arrayStackInfo[stackPos].list2=null;
			arrayStackInfo[stackPos].list3=null;
			arrayStackInfo[stackPos].list4=null;
			arrayStackInfo[stackPos].list5=null;
			arrayStackInfo[stackPos].list6=null;
		}
	}
	
	public void clearStack(){
		for(int i=0;i<stackPos;i++){
			arrayStackInfo[i].list=null;
			arrayStackInfo[i].list2=null;
			arrayStackInfo[i].list3=null;
			arrayStackInfo[i].list4=null;
			arrayStackInfo[i].list5=null;
			arrayStackInfo[i].list6=null;
		}
		stackPos=0;
	}
	
	public void popAllList(int iPos){
		for(;iPos<stackPos;){
			popAllList();
		}
	}
	
	public void initData() {
		if(null!=list)
			list.clear();
		if(null!=list2)
			list2.clear();
		if(null!=list3)
			list3.clear();
		list = new ArrayList();
		list2 = new ArrayList();
		list3 = new ArrayList();
		list4 = new ArrayList();
		list5 = new ArrayList();
		list6 = new ArrayList();
	}
	
	public void emptyData() {
		map=null;
		list=null;;
		list2=null;
		list3=null;
		list4=null;
		list5=null;
		list6=null;
	}
	
	public DotSession() {
		account = "none";
		roleName = "none";
		curBM="";
		roleID = "0";
		opCode = "";
		map = new HashMap();
		subPathTitle = new SubPathTitle();
		curYear = Calendar.getInstance().get(Calendar.YEAR);
		list5=null;
		//
		arrayStackInfo = new StackInfo[8];
		for (int i=0; i<8; i++) {
			arrayStackInfo[i] = new StackInfo();
		}
		sflag=0;
	}
	
	public void clear() {
		account = "none";
		roleID = "0";
	} 
	
	public static DotSession getVTSession(HttpSession session) {
		DotSession ds = (DotSession)session.getAttribute("vts");
		return ds;
	}
	
	public static DotSession getVTSession(HttpServletRequest request) {
		DotSession ds = (DotSession)request.getSession().getAttribute("vts");
		return ds;
	}
	
	/** 将结果集数据放进Map */
	public static void putMapData(Map map,ResultSet rs) {
		try {
			//ResultSetMetaData rsm =rs.getMetaData();
			//获取列数
			int col = rs.getMetaData().getColumnCount();
			for(int i=0; i<col; i++) {
				if(null!=rs.getString(i+1) && !rs.getString(i+1).equals("")){
					map.put("c"+i, rs.getString(i+1));
				}else{
					map.put("c"+i, "");
				}
			}
		} catch (Exception e) {
			log.info("error");
		}
	}
	/** 将结果集数据放进Map */
	public static void putMapDataByColName(Map map,ResultSet rs) {
		String sColName;
		try {
			//获取列数
			ResultSetMetaData rsm =rs.getMetaData();
			int col = rsm.getColumnCount();
			for(int i=1; i<=col; i++) {
				sColName=rsm.getColumnName(i);
				if(null!=rs.getString(i) && !rs.getString(i).equals("")){
					map.put(sColName, rs.getString(i));
				}else{
					map.put(sColName, "");
				}
			}
		} catch (Exception e) {
			log.info("error");
		}
	}
	
	/**
	 * m money
	 * i int
	 * f float
	 * String ix[][]={{"-1","o"},{"2","m"},{"3","i"},{"4","f"}}; 
	 * @param cs
	 * @param sr String	页面参数数组 
	 * @param ix index	以存储过程入参顺序为下标,从0开始定义,参数类型数组	
	 * @throws NumberFormatException
	 * @throws SQLException
	 */
	public static void prepareParamFromInputArray(CallableStatement cs, String sr[],String ix[][]) throws NumberFormatException, SQLException
	{
		for(int i=0;i<ix.length;i++)
		{
			if(ix[i][1].equalsIgnoreCase("s"))
			{
				cs.setString(i+1,sr[Integer.parseInt(ix[i][0])]);
			}
			else if(ix[i][1].equalsIgnoreCase("m") || ix[i][1].equalsIgnoreCase("f"))
			{
				cs.setFloat(i+1,Float.parseFloat(sr[Integer.parseInt(ix[i][0])]));
			}
			else if(ix[i][1].equalsIgnoreCase("i"))
			{
				cs.setInt(i+1,Integer.parseInt(sr[Integer.parseInt(ix[i][0])]));
			}
			else if(ix[i][1].equalsIgnoreCase("o"))
			{
				//--discard 
			}
		}
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public List getList2() {
		return list2;
	}
	public void setList2(List list2) {
		this.list2 = list2;
	}
	public List getList3() {
		return list3;
	}
	public void setList3(List list3) {
		this.list3 = list3;
	}
	public List getList4() {
		return list4;
	}
	public void setList4(List list4) {
		this.list4 = list4;
	}
	public List getList5() {
		return list5;
	}
	public void setList5(List list5) {
		this.list5 = list5;
	}
	public List getList6() {
		return list6;
	}
	public void setList6(List list6) {
		this.list6 = list6;
	}
	
	/**
	 * 
	 */
	
}
