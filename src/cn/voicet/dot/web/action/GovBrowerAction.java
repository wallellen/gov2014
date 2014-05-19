package cn.voicet.dot.web.action;

import java.io.IOException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovBrowerService;
import cn.voicet.dot.service.GovFarmerQueryService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.GovFamilyForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govBrowerAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class GovBrowerAction extends BaseAction implements ModelDriven<GovFamilyForm>{

	private static Logger log = Logger.getLogger(GovBrowerAction.class);
	@Resource(name=GovBrowerService.SERVICE_NAME)
	private GovBrowerService govBrowerService;
	@Resource(name=GovFarmerQueryService.SERVICE_NAME)
	private GovFarmerQueryService govFarmerQueryService;
	
	private GovFamilyForm govFamilyForm = new GovFamilyForm();
	
	public GovFamilyForm getModel() {
		return govFamilyForm;
	}
	
	/** 地区信息列表首页 */
	public String home() {
		//根据ds.curBM显示列表信息，ds.curBM由各入口负责调整
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.getGovBrowerList(ds);
		if(null!=viewBM&&viewBM.length()>0){
			if(viewBM.length()<=ds.rbm.length()){
				ds.subPathTitle.setRoot(String.valueOf(ds.map.get("name")),ds.curBM, ds.rbm);
			} else {
				ds.subPathTitle.setInfoByEx(String.valueOf(ds.map.get("name")),ds.curBM, ds.curBM);
			}
		}
		if(!ds.subPathTitle.hasRoot()) {
			ds.subPathTitle.setRoot(String.valueOf(ds.map.get("name")),ds.curBM, ds.rbm);
		}
		ds.navPath=ds.subPathTitle.getHtmlString();
		ds.popAllList(0);
		return "home";
	}
	
	public String viewArea() {
		DotSession ds = DotSession.getVTSession(request);
		if(null!=viewBM && viewBM.length()>0) {
			ds.curBM = viewBM;
		} else {
			System.out.println("error viewBM is null");
		}
		ds.popAllList(0);
		return home();
	}
	
	public String returnList() {
		DotSession ds = DotSession.getVTSession(request);
		ds.popAllList(0);
		return "home";
	}
	
	/** 修改地区名称 */
	public String edit() {
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.updateGovDataInfo(ds, insBm, insName, insHtn, insPtn);
		return "edit";
	}
	
	/** 详情页面 */
	public String detail() {
		DotSession ds = DotSession.getVTSession(request);
		ds.map.put("rtf", rtf);	// 农户查询 详情返回去向
		if(null!=viewBM && viewBM.length()>0)
			ds.curHM= viewBM;
		ds.pushAllList();
		govBrowerService.getGovFamilyList(ds);
		ds.opCode ="";
		return "detail";
	}
	
	public String addFamily(){
		DotSession ds = DotSession.getVTSession(request);
		ds.opCode = "addfamily";
		ds.curHM="";
		ds.map.put("hm", "");
		ds.map.put("hname", "");
		ds.map.put("population", "");
		ds.map.put("labornum", "");
		ds.map.put("fields", "");
		ds.map.put("house", "");
		ds.map.put("property", "");
		ds.map.put("telnum", "");
		ds.map.put("dcause", "");
		ds.map.put("idcno", "");
		ds.map.put("frname", "");
		ds.map.put("frtel", "");
		ds.map.put("frwork", "");
		ds.map.put("lastyear", "");
		ds.map.put("intotal", "");
		ds.map.put("inpersonal","");
		
		ds.map.put("rtf", rtf);
		ds.pushAllList();
		return "detail";
	}
	/** 添加家庭户主信息 */
	
	public String saveFamily(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("saveFamily-> zhu:"+govFamilyForm.getZhu());
		govBrowerService.saveFamilyInfo(ds, govFamilyForm);
		govBrowerService.getGovFamilyList(ds);
		ds.opCode = "saveFamily";
		return "detail";
		//return detail();
	}
	
	/** 保存并返回  */
	public String saveFamilyEx(){
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.saveFamilyInfo(ds, govFamilyForm);
		govBrowerService.getGovFamilyList(ds);
		ds.opCode = "saveFamily";
		ds.map.put("rtf","home");
		return backup();
	}
	
	/** 保存或更新家庭成员信息  */
	public String saveMember() {
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.saveMemberInfo(ds, mid, uname, sex, age, school, education, health, dcno, labors, works, bla, tbfd);
		ds.opCode = "saveMember";
		ds.map.put("rtf","home");
		return "showFamily";
	}
	
	/** 保存或更新家庭收入及帮扶情况  */
	public String saveYear() {
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.saveYearInfo(ds, govFamilyForm);
		ds.opCode = "saveYear";
		return familyIncome();
	}
	
	/** 删除家庭成员信息 */
	public String deleteMember(){
		DotSession ds = DotSession.getVTSession(request);
		govBrowerService.deleteMemberInfo(ds, mid);
		ds.opCode = "deleteMember";
		return "showFamily";
	}
	
	/** 打印家庭详细信息 */
	public String printFamily() {
		DotSession ds = DotSession.getVTSession(request);
		if(null!=viewBM&&viewBM.length()>0) {
			ds.curHM = viewBM;
		}
		ds.pushAllList();
		govBrowerService.getReportFamilyInfo(ds);
		return "reportHome";
	}
	
	/** browerView.jsp页面 返回按钮 */
	public String returnPrevious() {
		DotSession ds = DotSession.getVTSession(request);
		ds.subPathTitle.rollBack();
		ds.curBM = ds.subPathTitle.getCurKey();
		return home();
	}
	
	/** browerView.jsp页面按钮 */
	public String overView() {
		DotSession ds = DotSession.getVTSession(request);
		if(page.equals("property")){
			ds.popAllList(0);
			return "property";
		}else if(page.equals("situation")){
			ds.popAllList(0);
			return "situation";
		}else if(page.equals("dcause")){
			ds.popAllList(0);
			return "dcause";
		}else{
			return "home";
		}
	}
	
	public String backup() {
		DotSession ds = DotSession.getVTSession(request);
		// home farmer
		ds.popAllList();
		//
		if(ds.opCode.equals("saveFamily")){
			if(ds.map.get("rtf").equals("home"))
				govBrowerService.getGovBrowerList(ds);
			else
				govFarmerQueryService.getFarmerInfoList(ds);
			ds.opCode="";
		}
		return (String) ds.map.get("rtf");
	}
	
	/** 查看扶贫情况 */
	public String viewPoverty(){
		DotSession ds = DotSession.getVTSession(request);
		if(null!=proYear && proYear.length()>0){
			govBrowerService.getProvertyInfoByYear(ds, Integer.parseInt(proYear));
		}else{
			//默认当前年
			if(null==ds.map.get("proYear"))
				ds.map.put("proYear", ds.workyear);
		}
		return "situation";
	}
	
	/** 查看 */
	public String viewReportFamily(){
		DotSession ds = DotSession.getVTSession(request);
		ds.pushAllList();
		ds.curHM = viewBM;
		govBrowerService.getReportFamilyInfo(ds);
		
		ds.map.put("rtf", "home");
		return "viewFamily";
	}
	
	/** 农户查询页面查看 */
	public String viewReportFamilyWithQuery(){
		DotSession ds = DotSession.getVTSession(request);
		ds.pushAllList();
		ds.curHM = viewBM;
		govBrowerService.getReportFamilyInfo(ds);
		ds.map.put("rtf", "farmer");
		ds.opCode="saveFamily";
		return "viewFamily";
	}

	/** 家庭成员信息 */
	public String itemFamily(){
		DotSession ds = DotSession.getVTSession(request);
		ds.opCode ="";
		return "detail";
	}
	
	/** 家庭收入帮扶情况 */
	public String familyIncome() {
		DotSession ds = DotSession.getVTSession(request);
		ds.pushAllList();
		govBrowerService.findFamilyYearInfoWithTab2(ds);
		return "familyIncomeHome";
	}
	
	public String isDirect(){
		DotSession ds = DotSession.getVTSession(request);
		ds.map.put("bmhm", bmhm);
		ds.bmhm = bmhm;
		govBrowerService.isDirectWithBmHm(ds);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", ds.map.get("isbh"));
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObj.toString());
			response.getWriter().flush();
		} catch (IOException e) {
		}
		return null;
	}
	
	
	
	private String viewBM="";
	private String hbm;
	public String insBm;
	public String insName;
	public int insHtn;
	public int insPtn;
	
	//成员信息
	private int mid;
	private String uname;
	private int sex;
	private int age;
	private int school;
	private int education;
	private int health;
	private String dcno;
	private int labors;
	private int works;
	private int bla;
	private int tbfd;
	
	/*
	 * page=property 农户属性
	 * page=situation 扶贫情况
	 * page=dcause 贫困原因
	 */
	private String page;
	private String rtf;
	
	private String proYear;	//扶贫情况年
	
	private String bmhm;	// 编码户码，是否进入
	
	public String getViewBM() {
		return viewBM;
	}
	public void setViewBM(String viewBM) {
		this.viewBM = viewBM;
	}
	public String getHbm() {
		return hbm;
	}
	public void setHbm(String hbm) {
		this.hbm = hbm;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getSchool() {
		return school;
	}
	public void setSchool(int school) {
		this.school = school;
	}
	public int getEducation() {
		return education;
	}
	public void setEducation(int education) {
		this.education = education;
	}
	public int getHealth() {
		return health;
	}
	public void setHealth(int health) {
		this.health = health;
	}
	public String getDcno() {
		return dcno;
	}
	public void setDcno(String dcno) {
		if(dcno.length()>0)
			this.dcno = dcno;
		else
			this.dcno = "0";
	}
	public int getLabors() {
		return labors;
	}
	public void setLabors(int labors) {
		this.labors = labors;
	}
	public int getWorks() {
		return works;
	}
	public void setWorks(int works) {
		this.works = works;
	}
	public int getBla() {
		return bla;
	}
	public void setBla(int bla) {
		this.bla = bla;
	}
	public int getTbfd() {
		return tbfd;
	}
	public void setTbfd(int tbfd) {
		this.tbfd = tbfd;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getRtf() {
		return rtf;
	}
	public void setRtf(String rtf) {
		this.rtf = rtf;
	}
	public String getProYear() {
		return proYear;
	}
	public void setProYear(String proYear) {
		this.proYear = proYear;
	}
	public String getBmhm() {
		return bmhm;
	}
	public void setBmhm(String bmhm) {
		this.bmhm = bmhm;
	}
}
