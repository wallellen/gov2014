package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovJiangBuDao;
import cn.voicet.dot.service.GovJiangBuService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovJiangBuForm;

@Transactional(readOnly=true)
@Service(GovJiangBuService.SERVICE_NAME)
public class GovJiangBuServiceImpl implements GovJiangBuService {
	
	@Resource(name=GovJiangBuDao.SERVICE_NAME)
	private GovJiangBuDao govJiangBuDao;

	public void getJiangBuInfo(DotSession ds, String navbm, String crid) {
		govJiangBuDao.getJiangBuInfo(ds, navbm, crid);
	}

	public void saveJiangBuInfo(DotSession ds, GovJiangBuForm govJiangBuForm, String crid) {
		govJiangBuDao.saveJiangBuInfo(ds, govJiangBuForm, crid);
	}

	public void deleteJiangBuInfoWithRid(String chm) {
		govJiangBuDao.deleteJiangBuInfoWithRid(chm);
	}
	
	public void getJiangBuYear(DotSession ds) {
		govJiangBuDao.getJiangBuYear(ds);
	}

	public void getJiangBuXianInfo(DotSession ds, String rid) {
		govJiangBuDao.getJiangBuXianInfo(ds, rid);
	}

	public void getJiangBuInfoWithXian(DotSession ds, String cbm, String crid) {
		govJiangBuDao.getJiangBuInfoWithXian(ds, cbm, crid);
	}

	public void getJiangBunavBybm(DotSession ds, String navbm) {
		govJiangBuDao.getJiangBunavBybm(ds, navbm);
	}

}
