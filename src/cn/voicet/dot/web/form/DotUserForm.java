package cn.voicet.dot.web.form;

public class DotUserForm {
	private String account;		
	private String password;	
	private String rolename;
	private String roleid;
	private String oldpwd;
	private String newpwd;
	private int xflag = 0;
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		if(password.length()>0)
			this.password = password;
		else
			password = null;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getOldpwd() {
		return oldpwd;
	}
	public void setOldpwd(String oldpwd) {
		if(oldpwd.length()>0)
			this.oldpwd = oldpwd;
		else
			oldpwd=null;
	}
	public String getNewpwd() {
		return newpwd;
	}
	public void setNewpwd(String newpwd) {
		if(newpwd.length()>0)
			this.newpwd = newpwd;
		else
			newpwd = null;
	}
	public int getXflag() {
		return xflag;
	}
	public void setXflag(int xflag) {
		this.xflag = xflag;
	}
	
}
