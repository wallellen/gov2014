package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.DatabaseConfigService;
import cn.voicet.dot.util.DotSession;

@Controller("databaseConfigAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class DatabaseConfigAction extends BaseAction{

	@Resource(name=DatabaseConfigService.SERVICE_NAME)
	private DatabaseConfigService databaseConfigService;
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		databaseConfigService.databaseInfo(ds);
		return "home";
	}
	
	/** �����־ */
	public String empty() {
		DotSession ds = DotSession.getVTSession(request);
		databaseConfigService.emptyDatabase(ds);
		return null;
	}
	
	/** �������ݿ� */
	public String backup() {
		DotSession ds = DotSession.getVTSession(request);
		databaseConfigService.backupDatabase(ds, defbackupfilename);
		return null;
	}

	public String dbIndex(){
		DotSession ds = DotSession.getVTSession(request);
		if(null!=ds.map.get("dbindex")){
			ds.map.put("dbindex", dbindex);
			databaseConfigService.databaseIndexManage(ds);
		}
		return null;
	}
	
	private String defbackupfilename;
	public int dbindex;
	public String getDefbackupfilename() {
		return defbackupfilename;
	}
	public void setDefbackupfilename(String defbackupfilename) {
		this.defbackupfilename = defbackupfilename;
	}
	public int getDbindex() {
		return dbindex;
	}
	public void setDbindex(int dbindex) {
		this.dbindex = dbindex;
	}
}
