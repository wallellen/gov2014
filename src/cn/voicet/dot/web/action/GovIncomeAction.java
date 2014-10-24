package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovIncomeService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovIncomeForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govIncomeAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovIncomeAction extends BaseAction implements ModelDriven<GovIncomeForm>{

	@Resource(name=GovIncomeService.SERVICE_NAME)
	private GovIncomeService govIncomeService;
	private GovIncomeForm govIncomeForm = new GovIncomeForm();
	
	public GovIncomeForm getModel() {
		return govIncomeForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govIncomeService.getIncomeYear(ds);
		request.setAttribute("yearList", ds.list);
		ds.list=null;
		return "showIncome_year";
	}
	
	/** 查看年收入 */
	public String viewYearIncome(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govIncomeService.getIncomeInfoBycbm(ds, cbm, year);
		request.setAttribute("yearList", ds.list);
		ds.list=null;
		return "showIncome_detail";
	}
	
	/** 查看具体户年收入 */
	public String viewIncomeHu(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govIncomeService.getIncomeInfoBycbm(ds, cbm, year);
		request.setAttribute("yearList", ds.list);
		ds.list=null;
		return "showIncome_hu";
	}
	
	
	
	
	public String saveIncome(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govIncomeService.saveIncomeYear(ds, govIncomeForm, year);
		rflag=rflag+1;
		return viewIncomeHu();
	}
	
	/** 导出年收入 */
	public String exportIncome() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govIncomeService.getIncomeInfoBycbm(ds, cbm, year);
		String fileName = new String(("年收入及帮扶情况-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"income.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14");
	    generator.setDrawBoard();
	    generator.setEffectColNum(15);
		generator.exportExcelWithTemplate(response);
		return null;
	}
	
	
	private String cbm;
	private String year;
	private String title;
	private String sdt;
	private String edt;
	private String areaName;	//地区名称
	private int rflag=1;		//return flag
	public String getCbm() {
		return cbm;
	}
	public void setCbm(String cbm) {
		this.cbm = cbm;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
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
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
}
