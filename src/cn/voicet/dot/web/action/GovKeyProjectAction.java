package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.jfree.util.Log;
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

	private static Logger log = Logger.getLogger(GovKeyProjectAction.class);
	@Resource(name=GovKeyProjectService.SERVICE_NAME)
	private GovKeyProjectService govKeyProjectService;
	private GovKeyProjectForm govKeyProjectForm = new GovKeyProjectForm();
	
	public GovKeyProjectForm getModel() {
		return govKeyProjectForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		govKeyProjectService.getKeyProjectSeason(ds);
		return "showKeyProject_season";
	}
	
	/** 片区项目列表 */
	public String viewPianquProject(){
		DotSession ds = DotSession.getVTSession(request);
		//pqid is null
		govKeyProjectService.getPianquInfoList(ds, navbm, crid);
		log.info("viewPianquProject-> ds.list.size:"+ds.list.size());
		if(ds.list.size()==1)
		{
			log.info("viewPianquProject-> pqid:"+ds.map.get("pqid"));
			govKeyProjectService.getKeyProjectListByPiqnquId(ds, navbm, crid);
			return "showKeyProject_zhenDetail";
		}
		if(ds.list.size()==0)
		{
			govKeyProjectService.getKeyProjectSeason(ds);
			return "showKeyProject_season";
		}
		return "show_pianqu";
	}
	
	/** 县项目列表 */
	public String viewKeyProjectList(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewKeyProjectList-> navbm:"+navbm);
		govKeyProjectService.getKeyProjectZhen(ds, navbm, crid);
		return "showKeyProject_zhen";
	}
	
	/** 项目详细信息 */
	public String writeReportZhen(){
		DotSession ds = DotSession.getVTSession(request);
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
		DotSession ds = DotSession.getVTSession(request);
		govKeyProjectService.deleteKeyProjectByPid(ds,bm,pid,crid);
		rflag=rflag+1;
		return writeReportZhen();
	}
	
	/** 导出片区项目列表 */
	public String exportPianProject() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govKeyProjectService.getPianquInfoList(ds, navbm, crid);
	    String fileName = new String(("关键工程项目实施进度和扶贫资金使用情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"keypianqu.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("oname,m,pry,spr,sspr,opr,pyt,spy");
	    generator.setDrawBoard();
	    generator.setEffectColNum(11);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportKeyProject() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govKeyProjectService.getKeyProjectZhen(ds, navbm, crid);
	    String fileName = new String(("关键工程项目实施进度和扶贫资金使用情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"keyproject.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("bm,oname,m,pry,spr,sspr,opr,pyt,spy");
	    generator.setDrawBoard();
	    generator.setEffectColNum(11);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportKeyProjectDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		log.info("exportKeyProjectDetail-> pqid:"+ds.map.get("pqid"));
		govKeyProjectService.getKeyProjectInfo(ds, navbm, crid);
	    String fileName = new String(("关键工程项目实施进度和扶贫资金使用情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"keyproject1.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("itemname,oname,prt,spr,sspr,opr,pyt,spy,yt,yp,np");
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
	private String areaName;
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
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
}
