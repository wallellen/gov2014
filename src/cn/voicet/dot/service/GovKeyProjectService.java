package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovKeyProjectForm;

public interface GovKeyProjectService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovKeyProjectServiceImpl";
	void getKeyProjectInfo(DotSession ds, String navbm, String crid);
	void saveKeyProjectInfo(DotSession ds, GovKeyProjectForm govKeyProjectForm, String crid);
	void deleteKeyProjectByPid(DotSession ds, String bm, String pid, String crid);
	void getKeyProjectSeason(DotSession ds);
	void getKeyProjectZhen(DotSession ds, String navbm, String crid);
	void getPianquInfoList(DotSession ds, String navbm, String crid);
	void getKeyProjectListByPiqnquId(DotSession ds, String navbm, String crid);
}
