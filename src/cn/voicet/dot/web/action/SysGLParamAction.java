package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.SysGLParamService;
import cn.voicet.dot.util.DotSession;

@Controller("sysGLParamAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class SysGLParamAction extends BaseAction{

	@Resource(name=SysGLParamService.SERVICE_NAME)
	private SysGLParamService sysGLParamService;
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		sysGLParamService.getGlobalParamInfo(ds);
		return "home";
	}
	
	public String setParam(){
		DotSession ds = DotSession.getVTSession(request);
		ds.map.put("lockyear", lockyear);
		ds.map.put("workyear", workyear);
		sysGLParamService.setGlobalParamInfo(ds);
		return home();
	}
	public String workyear;
	public String lockyear;
	public String getWorkyear() {
		return workyear;
	}
	public void setWorkyear(String workyear) {
		this.workyear = workyear;
	}
	public String getLockyear() {
		return lockyear;
	}

	public void setLockyear(String lockyear) {
		if(lockyear.equals("true")){
			this.lockyear = "1";
		}else{
			this.lockyear = "0";
		}
	}
}
