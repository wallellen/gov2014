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
	
	/** �󷽵�λ�ҹ�������˫�±��б�  */
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuMonth(ds);
		return "showBangFu_month";
	}
	
	/** �󷽵�λ�ҹ�������˫�±��б�-���󷽵�λ���ܲ鿴    */
	public String deptTotalView(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByDept(ds, rid, fuid);
		return "showBangFu_dept";
	}
	
	/** �󷽵�λ�ҹ�������˫�±��б�-	���ػ��ܲ鿴    */
	public String xianTotalView(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByXian(ds, rid, fuid);
		return "showBangFu_xian";
	}
	
	/** �󷽵�λ�ҹ�������˫�±��б�-���󷽵�λ���ܲ鿴 -�鿴��ϸ   */
	public String viewDeptDetail(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getXianInfoWithDept(ds, fuid);
		return "showBangFu_deptDetail";
	}
	
	/** �󷽵�λ�ҹ�������˫�±��б�-���ػ��ܲ鿴 -�鿴��ϸ   */
	public String viewXianDetail(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithXian(ds, rid, xm);
		return "showBangFu_xianDetail";
	}
	
	/** �ع���Ա��¼�  */
	public String writeReport(){
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithReport(ds, rid);
		return "showBangFu_xianList";
	}
	
	/** ����󷽵�λ��Ϣ */
	public String saveBangfu(){
		DotSession ds = DotSession.getVTSession(request);
		rid = govBangfuForm.getBftxt()[13];
		govBangfuService.saveBangfuInfo(ds, govBangfuForm);
		rflag=rflag+1;
		return writeReport();
	}
	
	/** ����󷽵�λ���� */
	public String saveBangfuDept(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.saveBangfuDeptName(ds, govBangfuForm);
		rflag=rflag+1;
		return deptManage();
	}
	
	/** ɾ���󷽵�λ���� */
	public String deleteBangfuDept(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.deleteBangfuDeptByfuid(ds, fuid);
		System.out.println(rflag);
		rflag=rflag+1;
		return deptManage();
	}
	
	/** ɾ���󷽵�λ��Ϣ */
	public String deleteBangfuInfo(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.deleteBangfuInfoWithIid(ds, rid, iid);
		rflag=rflag+1;
		return writeReport();
	}
	
	/** ��Ӻ󷽵�λ��Ϣ */
	public String addBangfu(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.getBangfuInfoWithGroup(ds);
		rflag=rflag+1;
		return "showBangFu_add";
	}
	
	/** �󷽵�λ���� */
	public String deptManage(){
		DotSession ds = DotSession.getVTSession(request);
		govBangfuService.getBangfuDeptList(ds);
		return "showBangFu_deptManage";
	}
	
	/** �����󷽵�λ��Ϣ 
	 * @throws Exception */
	public String exportWithDept() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
	    govBangfuService.getBangfuInfoByDept(ds, rid, fuid);
	    String fileName = new String(("ʡ���󷽵�λ�ҹ�������-"+title+"-"+byunit).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-unit.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	
	
	/** �����󷽵�λ��ϸ��Ϣ 
	 * @throws Exception */
	public String exportWithDeptDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getXianInfoWithDept(ds, fuid);
	    String fileName = new String(("ʡ���󷽵�λ�ҹ�������-"+title+"-"+byunit+"-"+deptName).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-unit-detail.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	/** ��������Ϣ 
	 * @throws Exception */
	public String exportWithXian() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getBangfuInfoByXian(ds, rid, fuid);
	    String fileName = new String(("ʡ���󷽵�λ�ҹ�������-"+title+"-"+byxian).getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"bangfu-xian.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 3, ds.list);
	    generator.setColList("c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
        return null;
	}
	
	/** ��������ϸ��Ϣ 
	 * @throws Exception */
	public String exportWithXianDetail() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		ds.initData();
		govBangfuService.getDeptInfoWithXian(ds, rid, xm);
	    String fileName = new String(("ʡ���󷽵�λ�ҹ�������-"+title+"-"+byxian+"-"+xianName).getBytes("gb2312"), "ISO8859-1") +".xls";
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
	private String xm;	//����
	private String deptName;	//�󷽵�λ����
	private String xianName;	//������
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
