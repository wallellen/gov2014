package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.DatabaseConfigDao;
import cn.voicet.dot.service.DatabaseConfigService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(DatabaseConfigService.SERVICE_NAME)
public class DatabaseConfigServiceImpl implements DatabaseConfigService {
	
	@Resource(name=DatabaseConfigDao.SERVICE_NAME)
	private DatabaseConfigDao databaseConfigDao;

	public void databaseInfo(DotSession ds) {
		databaseConfigDao.databaseInfo(ds);
	}

	public void emptyDatabase(DotSession ds) {
		databaseConfigDao.emptyDatabase(ds);
	}

	public void backupDatabase(DotSession ds, String defbackupfilename) {
		databaseConfigDao.backupDatabase(ds, defbackupfilename);
	}

	public void databaseIndexManage(DotSession ds) {
		databaseConfigDao.databaseIndexManage(ds);
	}
	
}
