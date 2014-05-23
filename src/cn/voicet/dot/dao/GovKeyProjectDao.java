package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovKeyProjectForm;

public interface GovKeyProjectDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovKeyProjectDaoImpl";
	void getKeyProjectInfo(DotSession ds, String navbm, String crid, String pianId);
	void saveKeyProjectInfo(DotSession ds, GovKeyProjectForm govKeyProjectForm, String crid);
	void deleteKeyProjectByPid(DotSession ds, String bm, String pid, String crid);
	void getKeyProjectSeason(DotSession ds);
	void getKeyProjectZhen(DotSession ds, String navbm, String crid, String pianId);
	void getPianquInfoList(DotSession ds, String navbm, String crid);
	void getKeyProjectListByPiqnquId(DotSession ds, String navbm, String crid);
	void getKeyProjectInfoDetail(DotSession ds, String navbm, String crid, String pianId);
}
