package junit;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.junit.Test;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class TestMoreResult2 {
	
	public static void main(String[] args) {
		Calendar cal = Calendar.getInstance();
		int curYear = cal.get(Calendar.YEAR);
		System.out.println(curYear);
	}

	private static void testMoreResult() {
		String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://voicet.oicp.net:5566;databaseName=farmer2014";
		String user = "sa";
		String password = "begin";
		Connection conn = null;
		CallableStatement cs = null;
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			String proc = "{call sp_rpt_family(?)}";
			cs = conn.prepareCall(proc);
			cs.setString(1, "320803103206050");
			cs.execute();
			
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
						System.out.println(rs.getString(1)+"; "+rs.getString(2));
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
	}
}
