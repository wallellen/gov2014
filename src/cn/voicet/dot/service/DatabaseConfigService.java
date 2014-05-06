package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface DatabaseConfigService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.DatabaseConfigServiceImpl";

	void databaseInfo(DotSession ds);

	void emptyDatabase(DotSession ds);

	void backupDatabase(DotSession ds, String defbackupfilename);

	void databaseIndexManage(DotSession ds);

}
