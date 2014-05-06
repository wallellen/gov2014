package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovKeyProjectService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovKeyProjectForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govKeyProjectAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovKeyProjectAction extends BaseAction implements ModelDriven<GovKeyProjectForm>{

	@Resource(name=GovKeyProjectService.SERVICE_NAME)
	private GovKeyProjectService govKeyProjectService;
	private GovKeyProjectForm govKeyProjectForm = new GovKeyProjectForm();
	
	public GovKeyProjectForm getModel() {
		return govKeyProjectForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectSeason(ds);
		return "showKeyProject_season";
	}
	
	public String viewKeyProjectList(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectZhen(ds, navbm, crid);
		return "showKeyProject_zhen";
	}
	
	public String writeReportZhen(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectInfo(ds, navbm, crid);
		return "showKeyProject_zhenDetail";
	}
	
	public String saveKeyProject(){
		DotSession ds = DotSession.getVTSession(request);
		govKeyProjectService.saveKeyProjectInfo(ds, govKeyProjectForm, crid);
		rflag=rflag+1;
		return writeReportZhen();
	}
	
	/** 删除项目 */
	public String deleteKeyProject(){
		govKeyProjectService.deleteKeyProjectByPid(bm,pid);
		rflag=rflag+1;
		return writeReportZhen();
	}
	
	public String exportKeyProject() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectZhen(ds, navbm, crid);
	    String fileName = new String(("关键工程项目实施进度和扶贫资金使用情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"keyproject.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8");
	    generator.setDrawBoard();
	    generator.setEffectColNum(10);
	    if(navbm.length()==4){
	    	generator.setCellName();
	    	generator.setCellName("县名");
	    }
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportKeyProjectDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectInfo(ds, navbm, crid);
	    String fileName = new String(("关键工程项目实施进度和扶贫资金使用情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"keyproject-detail.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(11);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	private String bm;
	private String pid;
	private String navbm;
	private String crid;
	private String title;
	private String sdt;
	private String edt;
	private int rflag=1;
	public String getBm() {
		return bm;
	}
	public void setBm(String bm) {
		this.bm = bm;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getNavbm() {
		return navbm;
	}
	public void setNavbm(String navbm) {
		this.navbm = navbm;
	}
	public String getCrid() {
		return crid;
	}
	public void setCrid(String crid) {
		this.crid = crid;
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
}
