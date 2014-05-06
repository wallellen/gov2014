package cn.voicet.dot.util;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

@SuppressWarnings("unchecked")
public class ExcelTemplateGenerator {
	private HSSFWorkbook workBook;
	private String fileName; 	//文件名
	private String filePath;	//文件路径
	private ArrayList fieldData;//数据内容	
	private int srowData;		//数据从第几行开始填充
	private int endcol;			//结束列数值
	private String colNameArr[];//列掩码
	private boolean isDrawBoard;//是否画边框
	private boolean isSetCellName;
	private String tCellName;
	
	public ExcelTemplateGenerator(String filePath, String fileName, int srowData, List fieldData) {
		this.fileName = fileName;
		this.filePath = filePath;
		this.fieldData = (ArrayList) fieldData;
		this.srowData = srowData;
	}
	
	public ExcelTemplateGenerator(){
		endcol=0;
		isSetCellName=false;
	}
	
	public void setCellName(String cellName){
		tCellName=cellName;
	}
	
	/** 设置列名 */
	public void setColList(String sListName){
		colNameArr=sListName.split(",");
	}
	
	/** 设置列数  */
	public void setEffectColNum(int iCol){
		endcol=iCol;
	}
	
	/** 设置边框 */
	public void setDrawBoard(){
		isDrawBoard=true;
	}
	
	public void setCellName(){
		isSetCellName=true;
	}
	
	/** 根据模板文件导出excel */
	public void exportExcelWithTemplate(HttpServletResponse response) throws Exception {
		ServletOutputStream out = response.getOutputStream(); //获得输出流 
		if(null!=filePath){
			File file = new File(filePath);
			if(file.exists() && file.isFile()){
				workBook = new HSSFWorkbook(new FileInputStream(filePath));
				//读取第一个工作簿
		       	HSSFSheet sheet = workBook.getSheetAt(0);
		       	//改变模板文件中的单元格值
		       	if(isSetCellName){
		       		HSSFRow row = sheet.getRow(0);  
		        	HSSFCell cell = row.getCell(0);
		        	cell.setCellValue(tCellName);  
		       	}
		        HSSFRow dataRow = null;
		        HSSFCell dataCell = null;
		        String sColName;
		        HSSFCellStyle style=null;
		        //设置边框
		        if(isDrawBoard){
			        style = workBook.createCellStyle();
			        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		        }
		        for (int i=0; i<fieldData.size(); i++){
					Map numMap=(Map)fieldData.get(i);
					dataRow = sheet.createRow(i+srowData);
					int dl= endcol>0 ? endcol : numMap.size();
					
					for(int j=0; j<dl; j++){
						dataCell = dataRow.createCell(j);
						if(isDrawBoard){
							dataCell.setCellStyle(style);
						}
						if(null!=colNameArr && colNameArr.length>0){
							if(colNameArr.length>j){
								sColName = colNameArr[j];
							}else{
								sColName ="^";
							}
						}else{
							sColName = "c"+String.valueOf(j);
						}
						if(sColName!="^"){
							dataCell.setCellValue((String)numMap.get(sColName));
						}
					}
				}
				//重置输出流
				response.reset();
				//设置导出Excel报表的导出形式
				response.setHeader("Content-Disposition", "attachment;filename=" + fileName);// 设定输出文件头
				response.setContentType("application/vnd.ms-excel;charset=UTF-8");	// 定义输出类型
				workBook.write(out);
			    // 设置输出形式
				//System.setOut(new PrintStream(out));
				// 刷新输出流
			}else{
				System.out.println("excelTemplate ["+filePath+"] not exist");
			}
		}
		out.flush();
		out.close();
	}
}
