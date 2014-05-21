package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovVillageProjectService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovVillageProjectForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govVillageProjectAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovVillageProjectAction extends BaseAction implements ModelDriven<GovVillageProjectForm>{

	@Resource(name=GovVillageProjectService.SERVICE_NAME)
	private GovVillageProjectService govVillageProjectService;
	private GovVillageProjectForm govVillageProjectForm = new GovVillageProjectForm();
	
	public GovVillageProjectForm getModel() {
		return govVillageProjectForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectSeason(ds);
		return "showVillageProject_season";
	}
	
	public String viewVillProjectList(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectXian(ds, navbm, crid);
		return "showVillageProject_shi";
	}
	
	public String gotoZhenLevel(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectnavBybm(ds, navbm);
		return "showVillageProject_zhen";
	}
	
	public String viewReportByZhen(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectInfo(ds, navbm, crid);
		return "showVillageProject_zhenDetail";
	}
	
	public String writeReportCun(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectInfo(ds, navbm, crid);
		return "showVillageProject_zhenDetail";
	}
	
	public String saveVillageProject(){
		DotSession ds = DotSession.getVTSession(request);
		govVillageProjectService.saveVillageProjectInfo(ds, govVillageProjectForm, crid);
		rflag=rflag+1;
		return writeReportCun();
	}
	
	public String deleteVillInfo(){
		govVillageProjectService.deleteVillageProjectInfoByPid(cm, crid, pid);
		rflag=rflag+1;
		return writeReportCun();
	}
	
	public String exportVillageProject() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectXian(ds, navbm, crid);
	    String fileName = new String(("省级财政支持村级集体经济发展项目实施进度-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"villageproject.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11");
	    generator.setDrawBoard();
	    generator.setEffectColNum(17);
	    generator.setCellName();
	    if(navbm.length()==2){
	    	generator.setCellName("市名");
	    }else if(navbm.length()==4){
	    	generator.setCellName("县名");
	    }else if(navbm.length()==6){
	    	generator.setCellName("乡(镇)名");
	    }
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportVillageProjectDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govVillageProjectService.getVillageProjectInfo(ds, navbm, crid);
	    String fileName = new String(("省级财政支持村级集体经济发展项目实施进度-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"villageproject-detail.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c2,c3,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19");
	    generator.setDrawBoard();
	    generator.setEffectColNum(17);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String cm;
	public String pid;
	private String title;
	private String sdt;
	private String edt;
	private String crid;
	private String navbm;
	private int rflag=1;
	private String areaName;
	public String getCm() {
		return cm;
	}
	public void setCm(String cm) {
		this.cm = cm;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getCrid() {
		return crid;
	}
	public void setCrid(String crid) {
		this.crid = crid;
	}
	public String getNavbm() {
		return navbm;
	}
	public void setNavbm(String navbm) {
		this.navbm = navbm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSdt() {
		return sdt;
	}
	public void setSdt(String sdt) {
		this.sdt = sdt;
	}
	public String getEdt() {
		return edt;
	}
	public void setEdt(String edt) {
		this.edt = edt;
	}
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
}
