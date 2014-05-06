package junit;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestMoreResult {
	
	public static void main(String[] args) {
		testMoreResult();
		
	}

	@SuppressWarnings("unchecked")
	private static void testMoreResult() {
		String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://voicet.oicp.net:5566;databaseName=farmer2014";
		String user = "sa";
		String password = "begin";
		Connection conn = null;
		CallableStatement cs = null;
		List list = new ArrayList();

		List list1 = new ArrayList();
		List list2 = new ArrayList();
		List list3 = new ArrayList();
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			String proc = "{call sp_rpt_family(?)}";
			cs = conn.prepareCall(proc);
			cs.setString(1, "320803103206050");
			boolean flag = cs.execute();
			
			ResultSet rs = null;
			int updateCount = -1;
			do{
				updateCount = cs.getUpdateCount();
				if(updateCount != -1){	
					cs.getMoreResults();
					continue;
				}
				rs = cs.getResultSet();
				System.out.println("rs==="+rs);
				if(null != rs){
					while(rs.next()){
						// 获取结果集列数
						int rowNum = rs.getMetaData().getColumnCount();
						if(rowNum==19){
							Map map1 = new HashMap();
							map1.put("x", rs.getString(1));
							map1.put("xx", rs.getString(2));
							map1.put("c", rs.getString(3));
							map1.put("z", rs.getString(4));
							map1.put("xm", rs.getString(5));
							map1.put("xxm", rs.getString(6));
							map1.put("cm", rs.getString(7));
							map1.put("hm", rs.getString(8));
							map1.put("population", rs.getString(9));
							map1.put("labomum", rs.getString(10));
							map1.put("fields", rs.getString(11));
							map1.put("house", rs.getString(12));
							map1.put("property", rs.getString(13));
							map1.put("telnum", rs.getString(14));
							map1.put("dcause", rs.getString(15));
							map1.put("idcno", rs.getString(16));
							map1.put("fmame", rs.getString(17));
							map1.put("frtel", rs.getString(18));
							map1.put("frwork", rs.getString(19));
							list1.add(map1);
						}
						if(rowNum==10){
							Map map2 = new HashMap();
							map2.put("uname", rs.getString(1));
							map2.put("sex", rs.getString(2));
							map2.put("age", rs.getString(3));
							map2.put("school", rs.getString(4));
							map2.put("education", rs.getString(5));
							map2.put("hearth", rs.getString(6));
							map2.put("dcno", rs.getString(7));
							map2.put("labors", rs.getString(8));
							map2.put("works", rs.getString(9));
							map2.put("tbfd", rs.getString(10));
							list2.add(map2);
						}
						if(rowNum==8){
							Map map3 = new HashMap();
							map3.put("ids", rs.getObject(1));
							map3.put("unit", rs.getObject(2));
							map3.put("code", rs.getObject(3));
							map3.put("v1", rs.getObject(4));
							map3.put("v2", rs.getObject(5));
							map3.put("v3", rs.getObject(6));
							map3.put("v4", rs.getObject(7));
							map3.put("v5", rs.getObject(8));
							list3.add(map3);
						}
						
					}
				}
				if(rs != null){
					cs.getMoreResults();
					continue;
				}
			}while(!(updateCount == -1 && rs == null));
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				cs.close();
			} catch (Exception e2) {
			}
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		list.add(list1);
		list.add(list2);
		list.add(list3);
	}
}
