package cn.voicet.dot.dialect;

import org.hibernate.dialect.SQLServerDialect;

/**
 * 自定义数据库方言
 * @author Administrator
 *
 */
public class MySQLServerDialect extends SQLServerDialect {

	@Override
	public boolean supportsLimit() {
		return false;
	}
	
}
