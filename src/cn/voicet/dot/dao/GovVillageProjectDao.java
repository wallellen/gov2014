package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovVillageProjectForm;

public interface GovVillageProjectDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovVillageProjectDaoImpl";

	void getVillageProjectInfo(DotSession ds, String navbm, String crid);

	void saveVillageProjectInfo(DotSession ds, GovVillageProjectForm govVillageProjectForm, String crid);

	void deleteVillageProjectInfoByPid(String cm, String crid, String pid);

	void getVillageProjectSeason(DotSession ds);

	void getVillageProjectXian(DotSession ds, String navbm, String crid);

	void getVillageProjectnavBybm(DotSession ds, String navbm);

}
