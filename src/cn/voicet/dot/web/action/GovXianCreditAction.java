package cn.voicet.dot.web.action;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovXianCreditService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovXianCreditForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govXianCreditAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovXianCreditAction extends BaseAction implements ModelDriven<GovXianCreditForm>{

	private static Logger log = Logger.getLogger(GovXianCreditAction.class);
	@Resource(name=GovXianCreditService.SERVICE_NAME)
	private GovXianCreditService govXianCreditService;
	private GovXianCreditForm govXianCreditForm = new GovXianCreditForm();
	
	public GovXianCreditForm getModel() {
		return govXianCreditForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govXianCreditService.getXianCreditYear(ds);
		return "showCredit_year";
	}
	
	/** 县账号登录 */
	public String viewCreditYear(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewCreditYear -> year:"+year);
		govXianCreditService.getCreditInfoWithYear(ds, year, month, mode);
		return "showCredit_detail";
	}
	
	public String viewXianCreditWithXbm(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewCreditYear -> year:"+year+", xbm:"+xbm);
		govXianCreditService.getXianCreditByXbm(ds, year, xbm, month, mode);
		return "showCredit_detail";
	}
	
	/** 保存或更新  */
	public String saveXianCredit(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("saveXianCredit -> year:"+year);
		String xiaoeInfo = govXianCreditService.saveCreditInfo(ds, year, month, tsh, tsv, trh, trv, nh, nv, eh, ev);
		JSONObject json = new JSONObject();
		log.info("xiaoeInfo:"+xiaoeInfo);
		json.put("status", xiaoeInfo);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
			response.getWriter().flush();
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	public String deleteCreditInfo(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("deleteCreditInfo -> year:"+year+", month:"+month);
		govXianCreditService.deleteCreditInfoWithYearMonth(ds, year, month);
		rflag=rflag+1;
		return viewCreditYear();
	}
	
	/** 省账号登录，显示的报告列表 */
	public String viewCreditReport(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewCreditReport -> year:"+year);
		govXianCreditService.getShenCreditReportList(ds, year, month, mode);
		return "show_creditReport";
	}
	
	public String viewCreditMonthReport()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewCreditMonthReport -> year:"+year+", month:"+month);
		govXianCreditService.getCreditMonthReportList(ds, year, month, mode);
		return "show_monthCredit_detail";
	}
	
	/** 查看月份列表 */
	public String viewMonthList()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("viewMonthList -> year:"+year);
		govXianCreditService.getXianCreditMonth(ds, year);
		return "showCredit_month";
	}
	
	/** 导出按年度查看数据 */
	public String exportXiaoeYear() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govXianCreditService.getShenCreditReportList(ds, year, month, mode);
		String fileName = new String(("扶贫小额贷款发放进度-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"xiaoe-ffjd.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 2, ds.list);
	    generator.setColList("oname,tsh,tsv,th,tv,lsh,lsv,perc,xid");
	    generator.setDrawBoard();
	    generator.setEffectColNum(8);
	    generator.setLineBackGround();
		generator.exportExcelWithTemplate2(response);
		return null;
	}
	

	/** 导出按年度查看,月数据 */
	public String exportXiaoeMonth() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govXianCreditService.getXianCreditByXbm(ds, year, xbm, month, mode);
		String fileName = new String(("扶贫小额贷款发放、回收情况月统计-"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"xiaoe-month.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 4, ds.list);
	    generator.setColList("month,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
		generator.exportExcelWithTemplate(response);
		return null;
	}
	
	/** 导出按年度查看,月数据 */
	public String exportXiaoeByue() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govXianCreditService.getCreditMonthReportList(ds, year, month, mode);
		String fileName = new String(("扶贫小额贷款发放、回收情况 -"+title).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"xiaoeby.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 4, ds.list);
	    generator.setColList("oname,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,en,ev");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.setLineBackGround();
		generator.exportExcelWithTemplate2(response);
		return null;
	}
	private String year;
	private int month;
	private int mode;
	private String title;
	private String sdt;
	private String edt;
	private String areaName;	//地区名称
	private int rflag=1;		//return flag
	private String xbm;
	
	private int tsh;
	private float tsv;
	private int trh;
	private float trv;
	private int nh;
	private float nv;
	private int eh;
	private float ev;
	
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
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	public String getXbm() {
		return xbm;
	}
	public void setXbm(String xbm) {
		this.xbm = xbm;
	}
	public int getTsh() {
		return tsh;
	}

	public void setTsh(int tsh) {
		this.tsh = tsh;
	}

	public float getTsv() {
		return tsv;
	}

	public void setTsv(float tsv) {
		this.tsv = tsv;
	}

	public int getTrh() {
		return trh;
	}

	public void setTrh(int trh) {
		this.trh = trh;
	}

	public float getTrv() {
		return trv;
	}

	public void setTrv(float trv) {
		this.trv = trv;
	}

	public int getNh() {
		return nh;
	}

	public void setNh(int nh) {
		this.nh = nh;
	}

	public float getNv() {
		return nv;
	}

	public void setNv(float nv) {
		this.nv = nv;
	}

	public int getEh() {
		return eh;
	}

	public void setEh(int eh) {
		this.eh = eh;
	}

	public float getEv() {
		return ev;
	}

	public void setEv(float ev) {
		this.ev = ev;
	}
}
