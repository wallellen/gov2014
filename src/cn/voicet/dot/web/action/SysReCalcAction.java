package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.SysReCalcService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.SysReCalcForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("sysReCalcAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class SysReCalcAction extends BaseAction implements ModelDriven<SysReCalcForm>{

	@Resource(name=SysReCalcService.SERVICE_NAME)
	private SysReCalcService sysReCalcService;
	private SysReCalcForm sysReCalcForm = new SysReCalcForm();
	
	public SysReCalcForm getModel() {
		return sysReCalcForm;
	}
	
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		if(null == ds.map.get("param")){
			ds.map.put("param", ds.workyear);
		}
		return "home";
	}
	
	public String recal(){
		DotSession ds = DotSession.getVTSession(request);
		ds.map.put("cal", sysReCalcForm.getCal());
		if(null == ds.map.get("param")){
			ds.map.put("param", ds.workyear);
		}else{
			ds.map.put("param", sysReCalcForm.getParam());
		}
		sysReCalcService.reCalculateFamily(ds);
		return "home";
	}

}
