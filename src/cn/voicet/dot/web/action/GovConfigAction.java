package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovConfigService;
import cn.voicet.dot.util.DotSession;

@Controller("govConfigAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovConfigAction extends BaseAction{

	@Resource(name=GovConfigService.SERVICE_NAME)
	private GovConfigService govConfigService;
	
	private String isLogon;
	private String isEdit;
	private String isAudit;
	private String isAllow;	//1:允许, 0:禁止
	private String opCode;
	//角色权限字符串
	private String rolestr;
	
	public String home() {
		return "home";
	}
	
	/** browerView.jsp页面 管理权限  */
	public String manage() {
		DotSession ds = DotSession.getVTSession(request);
		String res = govConfigService.getRoleRight(ds, opCode);
		JSONObject json = new JSONObject();
		json.put("e", res);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
			response.getWriter().flush();
		} catch (Exception e) {
		}
		return null;
	}
	
	/** browerView.jsp页面  修改角色权限 */
	public String editRole() {
		DotSession ds = DotSession.getVTSession(request);
		String rightstr = isLogon+isEdit+isAudit;
		System.out.println(opCode+","+rightstr+","+isAllow);
		govConfigService.updateRoleRight(ds, opCode, isEdit);
		return null;
	}
	
	
	/** 初始化密码  */
	public String initPass() {
		DotSession ds = DotSession.getVTSession(request);
		govConfigService.initPasswordByOpCode(ds, opCode);
		return null;
	}
	
	/** configRole.jsp页面   角色权限配置   */
	public String edit() {
		DotSession ds = DotSession.getVTSession(request);
		govConfigService.configRole(ds, rolestr);
		return null;
	}
	
	public String getIsLogon() {
		return isLogon;
	}
	public void setIsLogon(String isLogon) {
		this.isLogon = isLogon;
	}
	public String getIsEdit() {
		return isEdit;
	}
	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}
	public String getIsAudit() {
		return isAudit;
	}
	public void setIsAudit(String isAudit) {
		this.isAudit = isAudit;
	}
	public String getIsAllow() {
		return isAllow;
	}
	public void setIsAllow(String isAllow) {
		this.isAllow = isAllow;
	}
	public String getOpCode() {
		return opCode;
	}
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}
	public String getRolestr() {
		return rolestr;
	}
	public void setRolestr(String rolestr) {
		this.rolestr = rolestr;
	}
}
