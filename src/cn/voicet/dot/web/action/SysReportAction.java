package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.SysReportService;
import cn.voicet.dot.util.DotSession;

@Controller("sysReportAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class SysReportAction extends BaseAction{

	@Resource(name=SysReportService.SERVICE_NAME)
	private SysReportService sysReportService;
	
	public String home() {
		return "home";
	}
	
	public String configReport(){
		DotSession ds=DotSession.getVTSession(request);
		ds.initData();
		sysReportService.getSysReportInfo(ds, reportflag);
		return "showReport";
	}
	
	public String saveReport(){
		sysReportService.saveReportInfo(reportflag, pstr, isde);
		rflag=rflag+1;
		return configReport();
	}
	
	public String deleteReport(){
		sysReportService.deleteReportByRid(reportflag, drid);
		rflag=rflag+1;
		return configReport();
	}
	
	private String reportflag;
	private String reportName;
	private String[] pstr;	//添加修改报告参数数组
	private String isde;	//添加修改报告复选框
	private int rflag=1;	//return flag;
	private int drid;
	
	public String getReportflag() {
		return reportflag;
	}
	public void setReportflag(String reportflag) {
		if(reportflag.equals("1")){
			this.reportflag = "year_items";
		}else if(reportflag.equals("2")){
			this.reportflag = "keyprj_items";
		}else if(reportflag.equals("3")){
			this.reportflag = "chunprj_items";
		}else if(reportflag.equals("4")){
			this.reportflag = "jiangbu_items";
		}else if(reportflag.equals("5")){
			this.reportflag = "hourfang_items";
		}else{
			this.reportflag = reportflag;
		}
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String[] getPstr() {
		return pstr;
	}
	public void setPstr(String[] pstr) {
		this.pstr = pstr;
	}

	public String getIsde() {
		return isde;
	}
	public void setIsde(String isde) {
		this.isde = isde;
	}
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
	public int getDrid() {
		return drid;
	}
	public void setDrid(int drid) {
		this.drid = drid;
	}
}
