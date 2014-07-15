package cn.voicet.dot.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.MemberDataService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.VTXiang;

@Controller("memberDataAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class MemberDataAction extends BaseAction{
	
	private static Logger log = Logger.getLogger(MemberDataAction.class);
	@Resource(name=MemberDataService.SERVICE_NAME)
	private MemberDataService memberDataService;

	public String home() {
		return "show_member_import";
	}
	
	public String importData(){
		String vl[];
		
		long starttime = System.currentTimeMillis();
		log.info("excel file: "+excel);
		DotSession ds = DotSession.getVTSession(request);
		InputStream inStream = null; 
		boolean bCheckOK=true;
		Workbook wb = null;
		try {
			inStream = new FileInputStream(excel);
			wb = VTXiang.create(inStream);
			Sheet sheet = wb.getSheetAt(0);
			totalRow = sheet.getPhysicalNumberOfRows();
			log.info("totalRow:"+totalRow);
			//
			Row fisrtRow = sheet.getRow(0);
				String fi = null;
				if(null!=fisrtRow.getCell(255))
				{
					fi = fisrtRow.getCell(255).getStringCellValue();
					log.info("fi:"+fi);
					if(fi.equalsIgnoreCase("FMI"))
					{
						ds.list = new ArrayList();
						for(int i=1; i<totalRow; i++)
						{
							vl=new String[12];
							bCheckOK=true;
							Row row = sheet.getRow(i);
							for(int j=0;j<12;j++)
							{
								if(null != row.getCell(j))
								{
									row.getCell(j).setCellType(HSSFCell.CELL_TYPE_STRING);
									vl[j] = row.getCell(j).getStringCellValue();
									if(vl[j].length()<=0) bCheckOK=false;
								}
								else
								{
									bCheckOK=false;
								}
								//残疾证号为空
								if(null==row.getCell(6))
								{
									bCheckOK=true;
								}
							}
							if(bCheckOK)
							{
								ds.list.add(vl);
							}
						}
						log.info("excel row count:"+ds.list.size());
						memberDataService.batchImportMemberData(ds);
						long endtime = System.currentTimeMillis();
						opTime = (endtime-starttime)/1000;
						log.info("消耗时间: "+opTime);
						request.setAttribute("importinfo", "文件 "+excelFileName+" 导入成功！共计导入年数据记录 "+ds.list.size()+" 条, 耗时 "+opTime+" 秒 !");
						ds.list=null;
						inStream.close();
					}
					else
					{
						request.setAttribute("importinfo","请从家庭成员资料维护页面,下载Excel模版文件整理数据");
					}
				}
				else
				{
					log.info("fi is null");
					request.setAttribute("importinfo","请从家庭成员资料维护页面,下载Excel模版文件整理数据");
				}
		} catch (Exception e) {
			log.error(e);
		}
		
		return "show_member_import";
	}
	
	public String emptyMember(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("emptyMember -> xm:"+xm);
		memberDataService.emptyMemberDataByXm(ds, xm);
		log.info("emptyMember -> Complete");
		return null;
	}
	
	//myFile属性用来封装上传的文件  
    private File excel;  
    //myFileContentType属性用来封装上传文件的类型  
    private String excelContentType;  
    //myFileFileName属性用来封装上传文件的文件名  
    private String excelFileName;
    //excel文件行数 
    private int totalRow;
    //操作消耗时间
    private double opTime;
    private String xm;
	public File getExcel() {
		return excel;
	}
	public void setExcel(File excel) {
		this.excel = excel;
	}
	public String getExcelContentType() {
		return excelContentType;
	}
	public void setExcelContentType(String excelContentType) {
		this.excelContentType = excelContentType;
	}
	public String getExcelFileName() {
		return excelFileName;
	}
	public void setExcelFileName(String excelFileName) {
		this.excelFileName = excelFileName;
	}
	public int getExcelRowCount() {
		return totalRow;
	}
	public void setExcelRowCount(int excelRowCount) {
		this.totalRow = excelRowCount;
	}
	public double getOpTime() {
		return opTime;
	}
	public void setOpTime(double opTime) {
		this.opTime = opTime;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
}
