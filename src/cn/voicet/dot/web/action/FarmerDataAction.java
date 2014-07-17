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

import cn.voicet.dot.service.FarmerDataService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.StringHelper;
import cn.voicet.dot.util.VTXiang;

@Controller("farmerDataAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class FarmerDataAction extends BaseAction{
	
	private static Logger log = Logger.getLogger(FarmerDataAction.class);
	@Resource(name=FarmerDataService.SERVICE_NAME)
	private FarmerDataService farmerDataService;

	public String home() {
		return "show_farmer_import";
	}
	
	public String checkXM(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("xm:"+xm);
		farmerDataService.getOpnameByXm(ds, xm);
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
		boolean valid = true;
		String errMsg = "";
		Workbook wb = null;
		try {
			inStream = new FileInputStream(excel);
			wb = VTXiang.create(inStream);
			Sheet sheet = wb.getSheetAt(0);
			totalRow = sheet.getPhysicalNumberOfRows();
			log.info("totalRow:"+totalRow);
			Row fisrtRow = sheet.getRow(0);
			if(null!=fisrtRow.getCell(255))
			{
				fi = fisrtRow.getCell(255).getStringCellValue();
				log.info("fi:"+fi);
				if(fi.equalsIgnoreCase("FFI"))
				{
					ds.list = new ArrayList();
					for(int i=1; i<totalRow; i++)
					{
						vl=new String[14];
						bCheckOK=true;
						Row row = sheet.getRow(i);
						for(int j=0;j<14;j++)
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
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 户码不属于县["+xm+"], 或者户码长度不足15位<br/>";
										}
										break;
									case 1:
										String zhu = row.getCell(j).getStringCellValue();
										if(!StringHelper.checkNull(zhu)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 组名不能为空<br/>";
										}
										break;
									case 2:
										String hname = row.getCell(j).getStringCellValue();
										if(!StringHelper.checkNull(hname)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 户主姓名不能为空<br/>";
										}
										break;
									case 3:
										String rk = row.getCell(j).getStringCellValue();
										if(!StringHelper.isNumber(rk)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 人口格式不正确，请输入数字代码<br/>";
										}
										break;
									case 4:
										String laodl = row.getCell(j).getStringCellValue();
										if(!StringHelper.isNumber(laodl)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 劳动力格式不正确，请输入数字代码<br/>";
										}
										break;
									case 5:
										String gengd = row.getCell(j).getStringCellValue();
										if(!StringHelper.checkNull(gengd)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 承包耕地面积必须大于等于0<br/>";
										}
										break;
									case 6:
										String zhuf = row.getCell(j).getStringCellValue();
										if(!StringHelper.checkNull(zhuf)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 住房面积必须大于等于0<br/>";
										}
										break;
									case 7:
										String property = row.getCell(j).getStringCellValue();
										if(!StringHelper.isNumber(property)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 农户属性格式不正确，请输入数字代码<br/>";
										}
										break;
									case 8:
										String tel = row.getCell(j).getStringCellValue();
										
										break;
									case 9:
										String cause = row.getCell(j).getStringCellValue();
										if(!StringHelper.isNumber(cause)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 贫困原因格式不正确，请输入数字代码<br/>";
										}
										break;
									case 10:
										String card = row.getCell(j).getStringCellValue();
										if(!StringHelper.checkIdCard(card)){
											valid=false;
											errMsg += "第"+(i+1)+"行, 第"+(j+1)+"列, 户主身份证号码格式不正确，请输入正确的身份证号码<br/>";
										}
										break;
									case 11:
										String bfnane = row.getCell(j).getStringCellValue();
										
										break;
									case 12:
										String bftel = row.getCell(j).getStringCellValue();
										
										break;
									case 13:
										String bfwork = row.getCell(j).getStringCellValue();
										
										break;
									default:
										break;
									}
								}
								else
								{
									bCheckOK=false;
								}
								//电话号码, 帮扶人姓名, 帮扶人电话, 帮扶人职务
								if(null==row.getCell(8) || null==row.getCell(11) || null==row.getCell(12) || null==row.getCell(13))
								{
									bCheckOK=true;
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
					if(valid)
					{
						log.info("excel row count:"+ds.list.size());
						farmerDataService.batchImportFarmerData(ds);
						long endtime = System.currentTimeMillis();
						opTime = (endtime-starttime)/1000;
						log.info("消耗时间: "+opTime);
						request.setAttribute("importinfo", "文件 "+excelFileName+" 导入成功！共计导入年数据记录 "+ds.list.size()+" 条, 耗时 "+opTime+" 秒 !");
						ds.list=null;
						inStream.close();
					}
					else
					{
						request.setAttribute("importinfo",errMsg);	
					}
				}
				else
				{
					request.setAttribute("importinfo","请从农户资料维护页面,下载Excel模版文件整理数据");
				}
			}
			else
			{
				log.info("fi is null");
				request.setAttribute("importinfo","请从农户资料维护页面,下载Excel模版文件整理数据");
			}
		} catch (Exception e) {
			log.error(e);
		}
		
		return "show_farmer_import";
	}
	
	public String emptyFarmer(){
		DotSession ds = DotSession.getVTSession(request);
		log.info("emptyFarmer -> xm:"+xm);
		farmerDataService.emptyFarmerDataByXm(ds, xm);
		log.info("emptyFarmer -> Complete");
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
	
	
	public boolean checkHuma(String hm)
	{
		if(!hm.startsWith(xm) || hm.length()!=15)
		{
			return false;
		}
		return true;
	}
	
}
