package cn.voicet.dot.web.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovBangfuService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovBangfuForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govBangfuAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class GovBangfuAction extends BaseAction implements ModelDriven<GovBangfuForm>{

	@Resource(name=GovBangfuService.SERVICE_NAME)
	private GovBangfuService govBangfuService;
	private GovBangfuForm govBangfuForm = new GovBangfuForm();
	
	public GovBangfuForm getModel() {
		return govBangfuForm;
	}
	
	/** 后方单位挂钩帮扶情况双月报列表  */
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuMonth(ds);
		return "showBangFu_month";
	}
	
	/** 后方单位挂钩帮扶情况双月报列表-按后方单位汇总查看    */
	public String deptTotalView(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByDept(ds, rid, fuid);
		return "showBangFu_dept";
	}
	
	/** 后方单位挂钩帮扶情况双月报列表-	按县汇总查看    */
	public String xianTotalView(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByXian(ds, rid, fuid);
		return "showBangFu_xian";
	}
	
	/** 后方单位挂钩帮扶情况双月报列表-按后方单位汇总查看 -查看详细   */
	public String viewDeptDetail(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getXianInfoWithDept(ds, fuid);
		return "showBangFu_deptDetail";
	}
	
	/** 后方单位挂钩帮扶情况双月报列表-按县汇总查看 -查看详细   */
	public String viewXianDetail(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithXian(ds, rid, xm);
		return "showBangFu_xianDetail";
	}
	
	/** 县管理员登录填报  */
	public String writeReport(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithReport(ds, rid);
		return "showBangFu_xianList";
	}
	
	/** 保存后方单位信息 */
	public String saveBangfu(){
		DotSession ds = DotSession.getVTSession(request);
		rid = govBangfuForm.getBftxt()[13];
		govBangfuService.saveBangfuInfo(ds, govBangfuForm);
		rflag=rflag+1;
		return writeReport();
	}
	
	/** 保存后方单位名称 */
	public String saveBangfuDept(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.saveBangfuDeptName(ds, govBangfuForm);
		rflag=rflag+1;
		return deptManage();
	}
	
	/** 删除后方单位名称 */
	public String deleteBangfuDept(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.deleteBangfuDeptByfuid(ds, fuid);
		System.out.println(rflag);
		rflag=rflag+1;
		return deptManage();
	}
	
	/** 删除后方单位信息 */
	public String deleteBangfuInfo(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.deleteBangfuInfoWithIid(ds, rid, iid);
		rflag=rflag+1;
		return writeReport();
	}
	
	/** 添加后方单位信息 */
	public String addBangfu(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.getBangfuInfoWithGroup(ds);
		rflag=rflag+1;
		return "showBangFu_add";
	}
	
	/** 后方单位管理 */
	public String deptManage(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.getBangfuDeptList(ds);
		return "showBangFu_deptManage";
	}
	
	/** 导出后方单位信息 
	 * @throws Exception */
	public String exportWithDept() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
	    govBangfuService.getBangfuInfoByDept(ds, rid, fuid);
	    String fileName = new String(("省级后方单位挂钩帮扶情况-"+title+"-"+byunit).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-unit.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	
	
	/** 导出后方单位详细信息 
	 * @throws Exception */
	public String exportWithDeptDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getXianInfoWithDept(ds, fuid);
	    String fileName = new String(("省级后方单位挂钩帮扶情况-"+title+"-"+byunit+"-"+deptName).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-unit-detail.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	/** 导出县信息 
	 * @throws Exception */
	public String exportWithXian() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByXian(ds, rid, fuid);
	    String fileName = new String(("省级后方单位挂钩帮扶情况-"+title+"-"+byxian).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-xian.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	/** 导出县详细信息 
	 * @throws Exception */
	public String exportWithXianDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithXian(ds, rid, xm);
	    String fileName = new String(("省级后方单位挂钩帮扶情况-"+title+"-"+byxian+"-"+xianName).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-xian-detail.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	

	private String iid;
	private String rid;
	private String title;
	private String sdt;
	private String edt;
	private String fuid;
	private String xm;	//县码
	private String deptName;	//后方单位名称
	private String xianName;	//县名称
	private String byunit;
	private String byxian;
	private int rflag=1;
	
	public String getIid() {
		return iid;
	}
	public void setIid(String iid) {
		this.iid = iid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getFuid() {
		return fuid;
	}
	public void setFuid(String fuid) {
		this.fuid = fuid;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getXianName() {
		return xianName;
	}
	public void setXianName(String xianName) {
		this.xianName = xianName;
	}
	public String getByunit() {
		return byunit;
	}
	public void setByunit(String byunit) {
		this.byunit = byunit;
	}
	public String getByxian() {
		return byxian;
	}
	public void setByxian(String byxian) {
		this.byxian = byxian;
	}
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
	
}
