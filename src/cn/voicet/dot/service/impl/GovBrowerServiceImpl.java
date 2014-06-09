package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovBrowerDao;
import cn.voicet.dot.service.GovBrowerService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFamilyForm;

@Transactional(readOnly=true)
@Service(GovBrowerService.SERVICE_NAME)
public class GovBrowerServiceImpl implements GovBrowerService {
	
	@Resource(name=GovBrowerDao.SERVICE_NAME)
	private GovBrowerDao govBrowerDao;

	public void getGovBrowerList(DotSession ds) {
		govBrowerDao.getGovBrowerList(ds);
	}

	public void getGovFamilyList(DotSession ds) {
		govBrowerDao.getGovFamilyList(ds);
	}

	public void updateGovDataInfo(DotSession ds, String insBm, String insName, int insHtn, int insPtn) {
		govBrowerDao.updateGovDataInfo(ds, insBm, insName, insHtn, insPtn);
	}
	
	public void saveFamilyInfo(DotSession ds, GovFamilyForm govFamilyForm) {
		govBrowerDao.saveFamilyInfo(ds, govFamilyForm);
	}

	public void saveMemberInfo(DotSession ds, int mid, String uname, int sex, int age,
			int school, int education, int health, String dcno,
			int labors, int works, int bla, int tbfd) {
		govBrowerDao.saveMemberInfo(ds, mid, uname, sex, age, school, education, health, dcno, labors, works, bla, tbfd);
	}

	public void saveYearInfo(DotSession ds, GovFamilyForm govFamilyForm) {
		govBrowerDao.saveYearInfo(ds, govFamilyForm);
	}

	public void deleteMemberInfo(DotSession ds, int mid) {
		govBrowerDao.deleteMemberInfo(ds, mid);
	}

	public void getReportFamilyInfo(DotSession ds) {
		govBrowerDao.getReportFamilyInfo(ds);
	}

	public void getProvertyInfoByYear(DotSession ds, int year) {
		govBrowerDao.getReportFamilyInfo(ds, year);
	}

	public void findFamilyYearInfoWithTab2(DotSession ds) {
		govBrowerDao.findFamilyYearInfoWithTab2(ds);
	}

	public void isDirectWithBmHm(DotSession ds) {
		govBrowerDao.isDirectWithBmHm(ds);
	}

	public void deleteFamilyWithHbm(DotSession ds, String hbm, int cause) {
		govBrowerDao.deleteFamilyWithHbm(ds, hbm, cause);
	}

	public void checkFamilyInfoByHbm(DotSession ds, String hbm) {
		govBrowerDao.checkFamilyInfoByHbm(ds, hbm);
	}

	public String findNavListStr(DotSession ds) {
		return govBrowerDao.findNavListStr(ds);
	}
}
