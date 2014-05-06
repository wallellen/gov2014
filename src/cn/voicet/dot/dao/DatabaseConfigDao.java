package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface DatabaseConfigDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.DatabaseConfigDaoImpl";

	void databaseInfo(DotSession ds);

	void emptyDatabase(DotSession ds);

	void backupDatabase(DotSession ds, String defbackupfilename);

	void databaseIndexManage(DotSession ds);

}
