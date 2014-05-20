package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFamilyForm;

public interface GovBrowerDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovBrowerDaoImpl";
	
	void getGovBrowerList(DotSession ds);

	void getGovFamilyList(DotSession ds);

	void updateGovDataInfo(DotSession ds, String insBm, String insName, int insHtn, int insPtn);

	void saveFamilyInfo(DotSession ds, GovFamilyForm govFamilyForm);

	void saveMemberInfo(DotSession ds, int mid, String uname, int sex, int age, int school,
			int education, int health, String dcno, int labors,
			int works, int bla, int tbfd);

	void saveYearInfo(DotSession ds, GovFamilyForm govFamilyForm);

	void deleteMemberInfo(DotSession ds, int mid);

	void getReportFamilyInfo(DotSession ds);

	void getReportFamilyInfo(DotSession ds, int year);

	void findFamilyYearInfoWithTab2(DotSession ds);

	void isDirectWithBmHm(DotSession ds);

	void deleteFamilyWithHbm(DotSession ds, String hbm, int cause);

}
