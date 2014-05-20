package cn.voicet.dot.web.action;

import java.io.IOException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.DotUserService;
import cn.voicet.dot.util.DotSession;

@Controller("dotUserAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class DotUserAction extends BaseAction {

	@Resource(name=DotUserService.SERVICE_NAME)
	private DotUserService dotUserService;
	
	private String oldpwd;
	private String newpwd;
	
	/** ÐÞ¸ÄÃÜÂë */
	public String updatepwd() {
		DotSession ds=DotSession.getVTSession(request);
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		if(!basePath.contains("gov"))
		{
			ds.sflag=0;
		}
		else
		{
			ds.sflag=1;
		}
		JSONObject jsonObj = new JSONObject();
		Integer res = dotUserService.updateUserPassword(ds, oldpwd, newpwd);
		if(res==1){
			jsonObj.put("status", "1");
			ds.password = newpwd;
		}else if(res==0){
			jsonObj.put("status", "0");
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObj.toString());
			response.getWriter().flush();
		} catch (IOException e) {
		}
		return null;
	}
	
	public String getNewpwd() {
		return newpwd;
	}
	public void setNewpwd(String newpwd) {
		this.newpwd = newpwd;
	}
	public String getOldpwd() {
		return oldpwd;
	}
	public void setOldpwd(String oldpwd) {
		this.oldpwd = oldpwd;
	}
	
}
