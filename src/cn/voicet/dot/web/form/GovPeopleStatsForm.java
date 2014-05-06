package cn.voicet.dot.web.form;

public class GovPeopleStatsForm {
	
	private String aid = "1";
	private String tjstr;
	
	private String age;
	private String dibao;
	
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
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getDibao() {
		return dibao;
	}
	public void setDibao(String dibao) {
		this.dibao = dibao;
	}
}
