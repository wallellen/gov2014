package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovKeyProjectForm;

public interface GovKeyProjectDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovKeyProjectDaoImpl";

	void getKeyProjectInfo(DotSession ds, String navbm, String crid);

	void saveKeyProjectInfo(DotSession ds, GovKeyProjectForm govKeyProjectForm, String crid);

	void deleteKeyProjectByPid(String bm, String pid, String crid);

	void getKeyProjectSeason(DotSession ds);

	void getKeyProjectZhen(DotSession ds, String navbm, String crid);

}
