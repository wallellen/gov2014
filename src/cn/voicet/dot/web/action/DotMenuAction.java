package cn.voicet.dot.web.action;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.DotUserService;
import cn.voicet.dot.util.DotRoleMenu;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.LogonUtils;
import cn.voicet.dot.web.form.DotUserForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("dotMenuAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class DotMenuAction extends BaseAction implements ModelDriven<DotUserForm> {
	
	private static Logger LOG = Logger.getLogger(DotMenuAction.class);
	@Resource(name=DotUserService.SERVICE_NAME)
	private DotUserService dotUserService;
	private DotUserForm dotUserForm = new DotUserForm();
	
	public DotUserForm getModel() {
		return dotUserForm;
	}
	private String roleid;
	
	/** 首页面 */
	public String home() throws Exception {
		return "home";
	}
	
	/** 用户登录 */
	public String login() throws Exception{
		String xmlFilePath = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/appconfig.xml");
		DotRoleMenu roleMenu = (DotRoleMenu)ServletActionContext.getServletContext().getAttribute("vta");
		if (roleMenu == null) {
			roleMenu = new DotRoleMenu();
			roleMenu.loadInfoFromXML(xmlFilePath);
			ServletActionContext.getServletContext().setAttribute("vta", roleMenu);
		}
		if (request.getSession().getAttribute("vts")==null) {
			DotSession ds = new DotSession();
			request.getSession().setAttribute("vts", ds);
		}
		DotSession ds=DotSession.getVTSession(request);
		Map<String, String> map = dotUserService.dotUserLogin(dotUserForm);
		ds.username=map.get("username");
		ds.password = dotUserForm.getPassword();
		ds.account=dotUserForm.getAccount();
		ds.rbm = map.get("rbm");
		ds.rbn = map.get("rbn");
		ds.roleName = map.get("rolename");
		ds.roleID=map.get("roleid");
		ds.isedit = Integer.valueOf(map.get("isedit"));
		ds.workyear=Integer.valueOf(map.get("workyear"));
		ds.yearlock=Integer.valueOf(map.get("yearlock"));
		// 记住密码操作
		LogonUtils.rememberPassByCookie(request, response);
		if (ds.roleID.equals("0")) {
			this.addFieldError("error", "您输入的账号或密码不正确");
			return "error";
		}
		ds.curBM=ds.rbm;
		ds.subPathTitle.initPath();
		LOG.info("account: ["+ds.account+"] login success, isedit="+ds.isedit);
		return "mainHome";
	}
	
	/** 注销 */
	public String logout() {
		DotSession ds=DotSession.getVTSession(request);
		ds.clear();
		request.getSession().invalidate();
		return "logout";
	}
	
	public String closeWindow(){
		System.out.println("clear session");
		request.getSession().invalidate();
		return null;
	}
	
	/** */
	public String logouterror() {
		return "logout";
	}

	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	
}
