package cn.voicet.dot.dialect;

import org.hibernate.dialect.SQLServerDialect;

/**
 * �Զ������ݿⷽ��
 * @author Administrator
 *
 */
public class MySQLServerDialect extends SQLServerDialect {

	@Override
	public boolean supportsLimit() {
		return false;
	}
	
}
