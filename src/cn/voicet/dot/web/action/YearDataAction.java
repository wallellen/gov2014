package cn.voicet.dot.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.YearDataService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.VTXiang;

@Controller("yearDataAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class YearDataAction extends BaseAction{
	
	private static Logger log = Logger.getLogger(YearDataAction.class);
	@Resource(name=YearDataService.SERVICE_NAME)
	private YearDataService yearDataService;

	public String home() {
		return "show_year_import";
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
			totalRow = sheet.getLastRowNum();
			ds.list = new ArrayList();
			for(int i=1; i<totalRow; i++)
			{
				vl=new String[15];
				bCheckOK=true;
				Row row = sheet.getRow(i);
				for(int j=0;j<15;j++)
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
				}
				if(bCheckOK)
				{
					ds.list.add(vl);
				}
			}
			log.info("excel row count:"+ds.list.size());
			yearDataService.batchImportYearData(ds);
			long endtime = System.currentTimeMillis();
			opTime = (endtime-starttime)/1000;
			log.info("����ʱ��: "+opTime);
			request.setAttribute("importinfo", "���Ƶ��������ݼ�¼ "+ds.list.size()+" ��, ��ʱ "+opTime+" �� !");
			inStream.close();
		} catch (Exception e) {
			log.error(e);
		}
		
		return "show_year_import";
	}
	
	//myFile����������װ�ϴ����ļ�  
    private File excel;  
    //myFileContentType����������װ�ϴ��ļ�������  
    private String excelContentType;  
    //myFileFileName����������װ�ϴ��ļ����ļ���  
    private String excelFileName;
    //excel�ļ����� 
    private int totalRow;
    //��������ʱ��
    private double opTime;
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
}
