package cn.voicet.dot.web.form;

public class GovFamilyForm {
	
	private String hname;	//户名
	private String htel;	//户主联系电话
	private String fields;	//耕地面积
	private String house;	//住房面积
	private int property;//农户属性
	private int dcause;	//贫困原因
	private String idcno;	//户主身份证号码
	private String frname;	//帮扶人姓名
	private String frwork;	//帮扶人职务
	private String frtel;	//帮扶人电话
	private String zhu;	//组名
	
	private String[] incomearr; //家庭收入级帮扶情况数组
	public String[] getIncomearr() {
		return incomearr;
	}
	public void setIncomearr(String[] incomearr) {
		this.incomearr = incomearr;
	}
	public String getHname() {
		return hname;
	}
	public void setHname(String hname) {
		this.hname = hname;
	}
	public String getHtel() {
		return htel;
	}
	public void setHtel(String htel) {
		this.htel = htel;
	}
	public String getFields() {
		return fields;
	}
	public void setFields(String fields) {
		this.fields = fields;
	}
	public String getHouse() {
		return house;
	}
	public void setHouse(String house) {
		this.house = house;
	}
	public int getProperty() {
		return property;
	}
	public void setProperty(int property) {
		this.property = property;
	}
	public int getDcause() {
		return dcause;
	}
	public void setDcause(int dcause) {
		this.dcause = dcause;
	}
	public String getIdcno() {
		return idcno;
	}
	public void setIdcno(String idcno) {
		this.idcno = idcno;
	}
	public String getFrname() {
		return frname;
	}
	public void setFrname(String frname) {
		this.frname = frname;
	}
	public String getFrwork() {
		return frwork;
	}
	public void setFrwork(String frwork) {
		this.frwork = frwork;
	}
	public String getFrtel() {
		return frtel;
	}
	public void setFrtel(String frtel) {
		this.frtel = frtel;
	}
	public String getZhu() {
		return zhu;
	}
	public void setZhu(String zhu) {
		this.zhu = zhu;
	}
	
}
