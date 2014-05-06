package cn.voicet.dot.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.voicet.dot.dao.GovIncomeDao;
import cn.voicet.dot.service.GovIncomeService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovIncomeForm;

@Transactional(readOnly=true)
@Service(GovIncomeService.SERVICE_NAME)
public class GovIncomeServiceImpl implements GovIncomeService {
	
	@Resource(name=GovIncomeDao.SERVICE_NAME)
	private GovIncomeDao govIncomeDao;

	public void getIncomeYear(DotSession ds) {
		govIncomeDao.getIncomeYear(ds);
	}

	public void getIncomeInfoBycbm(DotSession ds, String cbm, String year) {
		govIncomeDao.getIncomeInfoBycbm(ds, cbm, year);
	}

	public void saveIncomeYear(DotSession ds, GovIncomeForm govIncomeForm,
			String year) {
		govIncomeDao.saveIncomeYear(ds, govIncomeForm, year);
	}


}
