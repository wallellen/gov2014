package cn.voicet.dot.service;

import java.util.ArrayList;

import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovBangfuForm;

public interface GovBangfuService {

	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.GovBangfuServiceImpl";

	void getBangfuMonth(DotSession ds);

	void getBangfuInfoByDept(DotSession ds, String rid, String fuid);
	
	void getBangfuInfoByXian(DotSession ds, String rid, String fuid);
	
	void getXianInfoWithDept(DotSession ds, String fuid);

	void getDeptInfoWithXian(DotSession ds, String rid, String xm);

	void saveBangfuInfo(DotSession ds, GovBangfuForm govBangfuForm);
	
	void saveBangfuDeptName(DotSession ds, GovBangfuForm govBangfuForm);

	void deleteBangfuInfoWithIid(DotSession ds, String rid, String iid);

	void getBangfuInfoWithGroup(DotSession ds);

	void getDeptInfoWithReport(DotSession ds, String rid);

	void getBangfuDeptList(DotSession ds);

	void deleteBangfuDeptByfuid(DotSession ds, String fuid);

	void getExcelFieldDataListByDept(DotSession ds, String rid,
			String fuid);

}
