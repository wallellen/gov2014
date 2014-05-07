package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovJiangBuForm;

public interface GovJiangBuDao {

	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.GovJiangBuDaoImpl";

	void getJiangBuInfo(DotSession ds, String navbm, String crid);

	void saveJiangBuInfo(DotSession ds, GovJiangBuForm govJiangBuForm, String crid);

	void deleteJiangBuInfoWithRid(String chm, String crid);

	void getJiangBuYear(DotSession ds);

	void getJiangBuXianInfo(DotSession ds, String rid);

	void getJiangBuInfoWithXian(DotSession ds, String cbm, String crid);

	void getJiangBunavBybm(DotSession ds, String navbm);

}
