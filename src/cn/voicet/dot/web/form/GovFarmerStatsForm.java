package cn.voicet.dot.web.form;

public class GovFarmerStatsForm {
	private String aid="1";		//统计编号1, 2, 3
	private String tjstr;	//统计字符串
	
	// 设置默认年
	private String param;	//
	
	private String arg1;	//年份
	private String arg2;	//年份
	
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getTjstr() {
		return tjstr;
	}
	public void setTjstr(String tjstr) {
		if(tjstr.length()>0)
			this.tjstr = tjstr;
		else
			this.tjstr = "3";
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getArg1() {
		return arg1;
	}
	public void setArg1(String arg1) {
		this.arg1 = arg1;
	}
	public String getArg2() {
		return arg2;
	}
	public void setArg2(String arg2) {
		this.arg2 = arg2;
	}	
}
