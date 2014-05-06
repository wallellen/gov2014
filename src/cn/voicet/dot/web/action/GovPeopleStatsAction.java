package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovPeopleStatsService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovPeopleStatsForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govPeopleStatsAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class GovPeopleStatsAction extends BaseAction implements ModelDriven<GovPeopleStatsForm>{

	@Resource(name=GovPeopleStatsService.SERVICE_NAME)
	private GovPeopleStatsService govPeopleStatsService;
	private GovPeopleStatsForm govPeopleStatsForm = new GovPeopleStatsForm();
	
	public GovPeopleStatsForm getModel() {
		return govPeopleStatsForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		if(ds.getStackLevel()==0)
			ds.pushAllList();
		if(null!=govPeopleStatsForm.getAid() && null!=govPeopleStatsForm.getTjstr()){
			govPeopleStatsService.getPeopleSumInfo(ds, govPeopleStatsForm);
		}else{
			if(null==ds.map.get("aidPeople")){
				ds.map.put("aidPeople", 1);
				ds.map.put("tjstrPeople", "3");
			}
			ds.list5 = null;
		}
		return "home";
	}
}
