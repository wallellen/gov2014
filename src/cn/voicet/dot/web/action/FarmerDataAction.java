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
			ds.map.put("importXM", xm);
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
		//boolean valid = true;
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
					log.info("farmer data excel template files correctly, allow import...");
					for(int i=1; i<totalRow; i++)
					{
						bCheckOK=true;
						vl=new String[14];
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
										log.info("hm:"+hm);
										if(!checkHuma(hm))
										{
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ���벻������["+xm+"], ���߻��볤�Ȳ���15λ<br/>";
										}
										break;
									case 1:
										String zhu = row.getCell(j).getStringCellValue();
										log.info("zhu:"+zhu);
										if(!StringHelper.checkNull(zhu)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ��������Ϊ��<br/>";
										}
										break;
									case 2:
										String hname = row.getCell(j).getStringCellValue();
										log.info("hname:"+hname);
										if(!StringHelper.checkNull(hname)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ������������Ϊ��<br/>";
										}
										break;
									case 3:
										String rk = row.getCell(j).getStringCellValue();
										log.info("rk:"+rk);
										if(!StringHelper.isNumber(rk)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, �˿ڸ�ʽ����ȷ�����������ִ���<br/>";
										}
										break;
									case 4:
										String laodl = row.getCell(j).getStringCellValue();
										log.info("laodl:"+laodl);
										if(!StringHelper.isNumber(laodl)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, �Ͷ�����ʽ����ȷ�����������ִ���<br/>";
										}
										break;
									case 5:
										String gengd = row.getCell(j).getStringCellValue();
										log.info("gengd:"+gengd);
										if(!StringHelper.checkNull(gengd)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, �а��������������ڵ���0<br/>";
										}
										break;
									case 6:
										String zhuf = row.getCell(j).getStringCellValue();
										log.info("zhuf:"+zhuf);
										if(!StringHelper.checkNull(zhuf)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ס�����������ڵ���0<br/>";
										}
										break;
									case 7:
										String property = row.getCell(j).getStringCellValue();
										log.info("property:"+property);
										if(!StringHelper.isNumber(property)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ũ�����Ը�ʽ����ȷ�����������ִ���<br/>";
										}
										break;
									case 8:
										String tel = row.getCell(j).getStringCellValue();
										log.info("tel:"+tel);
										break;
									case 9:
										String cause = row.getCell(j).getStringCellValue();
										log.info("cause:"+cause);
										if(!StringHelper.isNumber(cause)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, ƶ��ԭ���ʽ����ȷ�����������ִ���<br/>";
										}
										break;
									case 10:
										String card = row.getCell(j).getStringCellValue();
										log.info("card:"+card);
										if(!StringHelper.checkIdCard(card)){
											bCheckOK=false;
											errMsg += "��"+(i+1)+"��, ��"+(j+1)+"��, �������֤�����ʽ����ȷ����������ȷ�����֤����<br/>";
										}
										break;
									case 11:
										String bfnane = row.getCell(j).getStringCellValue();
										log.info("bfnane:"+bfnane);
										break;
									case 12:
										String bftel = row.getCell(j).getStringCellValue();
										log.info("bftel:"+bftel);
										break;
									case 13:
										String bfwork = row.getCell(j).getStringCellValue();
										log.info("bfwork:"+bfwork);
										break;
									default:
										break;
									}
								}
								else
								{
									if(j!=8 && j!=11 && j!=12 && j!=13)
									{
										errMsg+="["+excelFileName+"]�ļ��е���������Ϊ��,�밴Ҫ��������������";
										bCheckOK=false;
									}
								}
							}
							else
							{
								//�绰����, ���������, ����˵绰, �����ְ��
								if(j!=8 && j!=11 && j!=12 && j!=13)
								{
									errMsg+="["+excelFileName+"]�ļ��е���������Ϊ��,�밴Ҫ��������������";
									bCheckOK=false;
								}
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
							farmerDataService.batchImportFarmerData(ds);
							long endtime = System.currentTimeMillis();
							opTime = (endtime-starttime)/1000;
							log.info("����ʱ��:"+opTime+"second");
							request.setAttribute("importinfo", "�ļ� "+excelFileName+" ����ɹ������Ƶ���ũ�����ݼ�¼ "+ds.list.size()+" ��, ��ʱ "+opTime+" �� !");
							ds.list=null;
							inStream.close();
						} catch (Exception e) {
							log.error(e);
							request.setAttribute("importinfo", "�ļ� "+excelFileName+" ����ʧ��");
						}
					}
					else
					{
						request.setAttribute("importinfo",errMsg);	
					}
				}
				else
				{
					request.setAttribute("importinfo","���ũ������ά��ҳ��,����Excelģ���ļ���������");
				}
			}
			else
			{
				log.info("fi is null");
				request.setAttribute("importinfo","���ũ������ά��ҳ��,����Excelģ���ļ���������");
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
		if(hm.startsWith(xm) && hm.length()==15)
		{
			return true;
		}
		return false;
	}
	
}
