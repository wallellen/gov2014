package cn.voicet.dot.web.form;

public class GovFarmerQueryForm {
	
	/** 高级选项 */
	private String[] qstr;	//查询农户条件数组
	private String[] memberstr;	//查询人口条件数组
	
	private String telhu;

	public String[] getQstr() {
		return qstr;
	}
	public void setQstr(String[] qstr) {
		this.qstr = qstr;
	}
	public String[] getMemberstr() {
		return memberstr;
	}
	public void setMemberstr(String[] memberstr) {
		this.memberstr = memberstr;
	}
	public String getTelhu() {
		return telhu;
	}
	public void setTelhu(String telhu) {
		this.telhu = telhu;
	}
}
