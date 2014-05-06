package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovVillageProjectDao;
import cn.voicet.dot.service.GovVillageProjectService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovVillageProjectForm;

@Transactional(readOnly=true)
@Service(GovVillageProjectService.SERVICE_NAME)
public class GovVillageProjectServiceImpl implements GovVillageProjectService {
	
	@Resource(name=GovVillageProjectDao.SERVICE_NAME)
	private GovVillageProjectDao govVillageProjectDao;

	public void getVillageProjectInfo(DotSession ds, String navbm, String crid) {
		govVillageProjectDao.getVillageProjectInfo(ds, navbm, crid);
	}

	public void saveVillageProjectInfo(DotSession ds, GovVillageProjectForm govVillageProjectForm, String crid) {
		govVillageProjectDao.saveVillageProjectInfo(ds, govVillageProjectForm, crid);
	}

	public void deleteVillageProjectInfoByPid(String cm, String crid, String pid) {
		govVillageProjectDao.deleteVillageProjectInfoByPid(cm, crid, pid);
	}

	public void getVillageProjectSeason(DotSession ds) {
		govVillageProjectDao.getVillageProjectSeason(ds);
	}

	public void getVillageProjectXian(DotSession ds, String navbm, String crid) {
		govVillageProjectDao.getVillageProjectXian(ds, navbm, crid);
	}

	public void getVillageProjectnavBybm(DotSession ds, String navbm) {
		govVillageProjectDao.getVillageProjectnavBybm(ds, navbm);
	}
}
