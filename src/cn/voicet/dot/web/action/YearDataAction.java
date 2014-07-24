package cn.voicet.dot.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.YearDataService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.StringHelper;
import cn.voicet.dot.util.VTXiang;

@Controller("yearDataAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class YearDataAction extends BaseAction{
	
	private static Logger log = Logger.getLogger(YearDataAction.class);
	@Resource(name=YearDataService.SERVICE_NAME)
	private YearDataService yearDataService;

	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		yearDataService.getYearInfo(ds);
		return "show_year_import";
	}
	

	public String checkXM(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("xm:"+xm);
		yearDataService.getOpnameByXm(ds, xm);
		JSONObject jsonObj = new JSONObject();
		String ret = (String)ds.map.get("ret");
		String xbm = (String)ds.map.get("bm");
		String xname = (String)ds.map.get("oname");
		log.info("ret:"+ret+", xbm:"+xbm+", xname:"+xname);
		if(ret.equals("1"))
		{
			jsonObj.put("status", "ok");
		}
		else
		{
			jsonObj.put("status", "err");
		}
		jsonObj.put("xname", xname);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObj.toString());
			response.getWriter().flush();
		} catch (IOException e) {
		}
		return null;
	}
	
	public String importData(){
		String vl[];
		String fi;
		long starttime = System.currentTimeMillis();
		log.info("excel file: "+excel);
		DotSession ds = DotSession.getVTSession(request);
		InputStream inStream = null; 
		boolean bCheckOK=true;
		String errMsg = "";
		Workbook wb = null;
		try {
			inStream = new FileInputStream(excel);
			wb = VTXiang.create(inStream);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		Sheet sheet = wb.getSheetAt(0);
		totalRow = sheet.getPhysicalNumberOfRows();
		log.info("totalRow:"+totalRow);
		Row fisrtRow = sheet.getRow(0);
		if(null!=fisrtRow.getCell(255))
		{
			fi = fisrtRow.getCell(255).getStringCellValue();
			log.info("fi:"+fi);
			if(fi.equalsIgnoreCase("FYI"))
			{
				ds.list = new ArrayList();
				log.info("year data excel template files correctly, allow import...");
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
							if(vl[j].length()>0)
							{
								switch (j) {
								case 0:
									String hm = row.getCell(j).getStringCellValue();
									if(!checkHuma(hm))
									{
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 户码不属于县["+xm+"], 或者户码长度不足15位<br/>";
									}
									break;
								case 1:
									String year = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(year) || year.length()!=4){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 年份不能为空<br/>";
									}
									break;
								case 2:
									String total = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(total)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 家庭年总收入不能为空<br/>";
									}
									break;
								case 3:
									String crop = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(crop)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 种植业不能为空<br/>";
									}
									break;
								case 4:
									String livstock = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(livstock)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 养殖业不能为空<br/>";
									}
									break;
								case 5:
									String work = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(work)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 务工收入不能为空<br/>";
									}
									break;
								case 6:
									String bla = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(bla)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 领取低保、五保、养老收入不能为空<br/>";
									}
									break;
								case 7:
									String subside = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(subside)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 补贴性收入不能为空<br/>";
									}
									break;
								case 8:
									String other = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(other)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 其它收入不能为空<br/>";
									}
									break;
								case 9:
									String personal = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(personal)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 家庭人均收入不能为空<br/>";
									}
									break;
								case 10:
									String aid = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(aid)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 无偿帮扶资金收入不能为空<br/>";
									}
									break;
								case 11:
									String share = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(share)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 得到股份不能为空<br/>";
									}
									break;
								case 12:
									String loan = row.getCell(j).getStringCellValue();
									if(!StringHelper.checkNull(loan)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 小额贷款和互助资金不能为空<br/>";
									}
									break;
								case 13:
									String train = row.getCell(j).getStringCellValue();
									if(!StringHelper.isNumber(train)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 劳动力转移培训大于或等于0<br/>";
									}
									break;
								case 14:
									String job = row.getCell(j).getStringCellValue();
									if(!StringHelper.isNumber(job)){
										bCheckOK=false;
										errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 劳动力转移就业人数大于或等于0<br/>";
									}
									break;
								default:
									break;
								}
							}
							else
							{
								bCheckOK=false;
							}
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
				if(ds.list.size()>0)
				{
					try {
						yearDataService.batchImportYearData(ds);
						long endtime = System.currentTimeMillis();
						opTime = (endtime-starttime)/1000;
						log.info("消耗时间:"+opTime+"second");
						request.setAttribute("importinfo", "文件 "+excelFileName+" 导入成功！共计导入年收入及帮扶资料记录 "+ds.list.size()+" 条, 耗时 "+opTime+" 秒 !");
						ds.list=null;
						inStream.close();
					} catch (Exception e) {
						log.error(e.getMessage());
						request.setAttribute("importinfo", "文件 "+excelFileName+" 导入失败！不能重复导入年数据及帮扶资料!");
					}
				}
				else
				{
					request.setAttribute("importinfo",errMsg);	
				}
			}
			else
			{
				request.setAttribute("importinfo","请从年收入及帮扶资料维护页面,下载Excel模版文件整理数据");
			}
		}
		else
		{
			log.info("fi is null");
			request.setAttribute("importinfo","请从年收入及帮扶资料维护页面,下载Excel模版文件整理数据");
		}
		yearDataService.getYearInfo(ds);
		return "show_year_import";
	}
	
	public String emptyYear(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("emptyYear -> account:"+ds.account+", xm:"+xm+", year:"+year);
		yearDataService.emptyYearDataByXmWithYear(ds, xm, year);
		log.info("emptyYear -> Complete");
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
    private String year;
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
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public boolean checkHuma(String hm)
	{
		if(!hm.startsWith(xm) || hm.length()!=15)
		{
			return false;
		}
		return true;
	}
}
