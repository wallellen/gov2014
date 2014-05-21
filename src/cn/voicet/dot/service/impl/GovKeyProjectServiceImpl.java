package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovKeyProjectDao;
import cn.voicet.dot.service.GovKeyProjectService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovKeyProjectForm;

@Transactional(readOnly=true)
@Service(GovKeyProjectService.SERVICE_NAME)
public class GovKeyProjectServiceImpl implements GovKeyProjectService {
	
	@Resource(name=GovKeyProjectDao.SERVICE_NAME)
	private GovKeyProjectDao govKeyProjectDao;

	public void getKeyProjectInfo(DotSession ds, String navbm, String crid) {
		govKeyProjectDao.getKeyProjectInfo(ds, navbm, crid);
	}

	public void saveKeyProjectInfo(DotSession ds, GovKeyProjectForm govKeyProjectForm, String crid) {
		govKeyProjectDao.saveKeyProjectInfo(ds, govKeyProjectForm, crid);
	}

	public void deleteKeyProjectByPid(String bm, String pid, String crid) {
		govKeyProjectDao.deleteKeyProjectByPid(bm, pid, crid);
	}

	public void getKeyProjectSeason(DotSession ds) {
		govKeyProjectDao.getKeyProjectSeason(ds);
	}

	public void getKeyProjectZhen(DotSession ds, String navbm, String crid) {
		govKeyProjectDao.getKeyProjectZhen(ds, navbm, crid);
	}

}
