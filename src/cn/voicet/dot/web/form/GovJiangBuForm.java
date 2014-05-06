package cn.voicet.dot.web.form;

public class GovJiangBuForm {
	private String rid;	//批次号
	private String jbstr;
	private Integer[] jbtxt;	//查询条件数组
	private String navbm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getJbstr() {
		return jbstr;
	}
	public void setJbstr(String jbstr) {
		this.jbstr = jbstr;
	}
	public Integer[] getJbtxt() {
		return jbtxt;
	}
	public void setJbtxt(Integer[] jbtxt) {
		this.jbtxt = jbtxt;
	}
	public String getNavbm() {
		return navbm;
	}
	public void setNavbm(String navbm) {
		this.navbm = navbm;
	}
	
}
