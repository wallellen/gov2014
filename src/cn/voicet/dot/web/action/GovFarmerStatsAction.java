package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovFarmerStatsService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govFarmerStatsAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class GovFarmerStatsAction extends BaseAction implements ModelDriven<GovFarmerStatsForm>{

	@Resource(name=GovFarmerStatsService.SERVICE_NAME)
	private GovFarmerStatsService govFarmerStatsService;
	private GovFarmerStatsForm govFarmerStatsForm = new GovFarmerStatsForm();
	
	public GovFarmerStatsForm getModel() {
		return govFarmerStatsForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		if(ds.getStackLevel()==0)
			ds.pushAllList();
		if(null!=govFarmerStatsForm.getAid() && null!=govFarmerStatsForm.getTjstr()){
			govFarmerStatsService.getFarmerSumInfo(ds, govFarmerStatsForm);
		}else{
			if(null==ds.map.get("aidFarmer")){
				// …Ë÷√ƒ¨»œƒÍ
				ds.map.put("aidFarmer", 1);
				ds.map.put("tjstrFarmer", "3");
				if(null==ds.map.get("paramFarmer"))
					ds.map.put("paramFarmer", ds.workyear);
			}
			ds.list5 = null;
		}
		return "home";
	}
}
