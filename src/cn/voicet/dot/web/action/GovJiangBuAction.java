package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovJiangBuService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovJiangBuForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govJiangBuAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovJiangBuAction extends BaseAction implements ModelDriven<GovJiangBuForm>{

	@Resource(name=GovJiangBuService.SERVICE_NAME)
	private GovJiangBuService govJiangBuService;
	private GovJiangBuForm govJiangBuForm = new GovJiangBuForm();
	
	public GovJiangBuForm getModel() {
		return govJiangBuForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govJiangBuService.getJiangBuYear(ds);
		return "showJiangBu_year";
	}
	
	/** 奖补到户情况半年报列表-查看 */
	public String xianListView(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govJiangBuService.getJiangBuXianInfo(ds, crid);
		return "showJiangBu_xian";
	}
	
	public String viewXianDetail(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govJiangBuService.getJiangBuInfoWithXian(ds, cbm, crid);
		return "showJiangBu_xianDetail";
	}
	
	/** 当前编码不到村，进入 */
	public String gotoCunLevel(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		if(null==navbm){
			navbm = request.getParameter("navbm");
		}
		govJiangBuService.getJiangBunavBybm(ds, navbm);
		return "showJiangBu_cun";
	}
	
	/** 直接到村填报 */
	public String writeReport(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		if(null==navbm){
			navbm = request.getParameter("navbm");
		}
		govJiangBuService.getJiangBuInfo(ds, navbm, crid);
		return "showjiangBu_huDetail";
	}
	
	public String saveJiangBu(){
		DotSession ds = DotSession.getVTSession(request);
		govJiangBuService.saveJiangBuInfo(ds, govJiangBuForm, crid);
		rflag=rflag+1;
		return writeReport();
	}
	
	public String deleteJiangBuInfo(){
		govJiangBuService.deleteJiangBuInfoWithRid(chm, crid);
		rflag=rflag+1;
		return writeReport();
	}
	
	public String exportJiangbu() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govJiangBuService.getJiangBuXianInfo(ds, crid);
	    String fileName = new String(("脱贫奔小康财政奖补到户项目实施情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"jiangbu.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    //generator.setColList("oname,t1,t2,t3,t4,t5,t6,t7,v,v1,v2,v3");
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(12);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportJiangbuDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govJiangBuService.getJiangBuInfoWithXian(ds, cbm, crid);
	    String fileName = new String(("脱贫奔小康财政奖补到户项目实施情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"jiangbu.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(12);
	    generator.setCellName();
	    if(cbm.length()==2){
	    	generator.setCellName("市名称");
	    }else if(cbm.length()==4){
	    	generator.setCellName("县名称");
	    }else if(cbm.length()==6){
	    	generator.setCellName("镇名称");
	    }else if(cbm.length()==9){
	    	generator.setCellName("村名称");
	    }
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	public String exportJiangbuTohu() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		if(null==navbm){
			navbm = request.getParameter("navbm");
		}
		govJiangBuService.getJiangBuInfo(ds, navbm, crid);
	    String fileName = new String(("脱贫奔小康财政奖补到户项目实施情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"jiangbu-hu.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c0,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.setGouCharacter();
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	private String chm;
	private String crid;
	private String title;
	private String sdt;
	private String edt;
	private String cbm;
	private String xianName;
	private String navbm;
	private int rflag=1;	//返回标记
	public String getChm() {
		return chm;
	}
	public void setChm(String chm) {
		this.chm = chm;
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
	public String getCbm() {
		return cbm;
	}
	public void setCbm(String cbm) {
		this.cbm = cbm;
	}
	public String getXianName() {
		return xianName;
	}
	public void setXianName(String xianName) {
		this.xianName = xianName;
	}
	public String getNavbm() {
		return navbm;
	}
	public void setNavbm(String navbm) {
		this.navbm = navbm;
	}
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
}
