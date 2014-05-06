package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovBangfuDao;
import cn.voicet.dot.service.GovBangfuService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovBangfuForm;

@Transactional(readOnly=true)
@Service(GovBangfuService.SERVICE_NAME)
public class GovBangfuServiceImpl implements GovBangfuService {
	
	@Resource(name=GovBangfuDao.SERVICE_NAME)
	private GovBangfuDao govBangfuDao;

	public void getBangfuInfoByDept(DotSession ds, String rid, String fuid) {
		govBangfuDao.getBangfuInfoByDept(ds, rid, fuid);
	}

	public void saveBangfuInfo(DotSession ds, GovBangfuForm govBangfuForm) {
		govBangfuDao.saveBangfuInfo(ds, govBangfuForm);
	}
	
	public void saveBangfuDeptName(DotSession ds, GovBangfuForm govBangfuForm) {
		govBangfuDao.saveBangfuDeptName(ds, govBangfuForm);
	}

	public void deleteBangfuInfoWithIid(DotSession ds, String rid, String iid) {
		govBangfuDao.deleteBangfuInfoWithIid(ds, rid, iid);
	}

	public void getBangfuInfoWithGroup(DotSession ds) {
		govBangfuDao.getBangfuInfoWithGroup(ds);
	}

	public void getBangfuMonth(DotSession ds) {
		govBangfuDao.getBangfuMonth(ds);
	}

	public void getXianInfoWithDept(DotSession ds, String fuid) {
		govBangfuDao.getXianInfoWithDept(ds, fuid);
	}

	public void getBangfuInfoByXian(DotSession ds, String rid, String fuid) {
		govBangfuDao.getBangfuInfoByXian(ds, rid, fuid);
	}

	public void getDeptInfoWithXian(DotSession ds, String rid, String xm) {
		govBangfuDao.getDeptInfoWithXian(ds, rid, xm);
	}

	public void getDeptInfoWithReport(DotSession ds, String rid) {
		govBangfuDao.getDeptInfoWithReport(ds, rid);
	}

	public void getBangfuDeptList(DotSession ds) {
		govBangfuDao.getBangfuDeptList(ds);
	}

	public void deleteBangfuDeptByfuid(DotSession ds, String fuid) {
		govBangfuDao.deleteBangfuDeptByfuid(ds, fuid);
	}

	public void getExcelFieldDataListByDept(DotSession ds, String rid,
			String fuid) {
		govBangfuDao.getExcelFieldDataListByDept(ds, rid, fuid);
	}

}
