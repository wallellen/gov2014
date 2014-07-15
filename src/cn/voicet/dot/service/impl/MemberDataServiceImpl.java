package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.MemberDataDao;
import cn.voicet.dot.service.MemberDataService;
import cn.voicet.dot.util.DotSession;

@Transactional(readOnly=true)
@Service(MemberDataService.SERVICE_NAME)
public class MemberDataServiceImpl implements MemberDataService {
	@Resource(name=MemberDataDao.SERVICE_NAME)
	private MemberDataDao memberDataDao;
	public void batchImportMemberData(DotSession ds) {
		memberDataDao.batchImportMemberData(ds);
	}
	public void emptyMemberDataByXm(DotSession ds, String xm) {
		memberDataDao.emptyMemberDataByXm(ds, xm);
	}
}
