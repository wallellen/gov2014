package cn.voicet.dot.util;

import java.io.OutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;

public class ExcelFileGenerator {
private HSSFWorkbook workBook = null;
	
	
	
	
	
	
	private String fileName = "省级后方单位挂钩帮扶情况"; //excel标题数据集
	private ArrayList fieldData = null; //excel数据内容	
	
	public ExcelFileGenerator(String fileName, List fieldData) {
		this.fileName = fileName;
		this.fieldData = (ArrayList) fieldData;
	}
	
	public HSSFWorkbook createWorkbook() {
		workBook = new HSSFWorkbook();
		// 创建sheet
       	HSSFSheet sheet = workBook.createSheet(fileName+System.currentTimeMillis());
        // 生成一个样式
       	HSSFCellStyle style = workBook.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        // 生成一个字体
        HSSFFont font = workBook.createFont();
        font.setColor(HSSFColor.VIOLET.index);
        font.setFontHeightInPoints((short) 12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        // 把字体应用到当前的样式
        style.setFont(font);
        // 设置自动换行
        style.setWrapText(true);
        // 创建第一行，标题
        HSSFRow row1 = sheet.createRow(0);
        HSSFRow row2 = sheet.createRow(1);
        HSSFRow row3 = sheet.createRow(2);
        String[] cellTitle1 = {"序号","省级后方单位名称","挂钩帮扶村情况","","","","挂钩帮扶全县情况"};
        String[] cellTitle2 = {"","","所在乡镇名称","挂钩村名称","到村项目资金(万元)","到村项目个数(个)","1.无偿帮扶资金投入合计(万元)","其中","","2.实施帮扶项目总数(个)","其中","","3.帮扶实物折价(万元)","4.现场办公人次合计","其中",""};
        String[] cellTitle3 = {"","","","","","","","后方单位自筹资金(万元)","协调资金(万元)","","完成项目数(个)","在建项目数(个)","","","单位领导","中层及以下人员"};
        sheet.addMergedRegion(new CellRangeAddress(0, 2, 0, 0));	//序号
        sheet.addMergedRegion(new CellRangeAddress(0, 2, 1, 1));	//单位名称
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 5));	//
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 6, 15));
        
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 7, 8));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 10, 11));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 14, 15));
        
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 2, 2));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 3, 3));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 4, 4));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 5, 5));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 6, 6));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 9, 9));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 12, 12));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 13, 13));
        for (int i = 0; i < cellTitle1.length; i++) {
			Cell cell = row1.createCell(i);
			cell.setCellStyle(style);
			cell.setCellValue(cellTitle1[i]);
		}
        for (int i = 0; i < cellTitle2.length; i++) {
			Cell cel2 = row2.createCell(i);
			cel2.setCellStyle(style);
			cel2.setCellValue(cellTitle2[i]);
		}
        for (int i = 0; i < cellTitle3.length; i++) {
			Cell cel3 = row3.createCell(i);
			cel3.setCellStyle(style);
			cel3.setCellValue(cellTitle3[i]);
		}
        for (int i = 1; i <= fieldData.size(); i++){
			Map numMap=(Map)fieldData.get(i-1);
			//创建数据行, 数据行从1开始
			HSSFRow dataRow = sheet.createRow(i+2);
			sheet.setColumnWidth(1, 8000);
			for (int j = 0; j < 16; j++) {
				Cell dataCell = dataRow.createCell(j);
				switch (j) {
				case 0:
					dataCell.setCellValue((String)numMap.get("c0"));
					break;
				case 1:
					dataCell.setCellValue((String)numMap.get("c1"));
					break;
				case 2:
					dataCell.setCellValue("");
					break;
				case 3:
					dataCell.setCellValue("");
					break;
				case 4:
					dataCell.setCellValue((String)numMap.get("c2"));
					break;
				case 5:
					dataCell.setCellValue((String)numMap.get("c3"));
					break;
				case 6:
					dataCell.setCellValue((String)numMap.get("c4"));
					break;
				case 7:
					dataCell.setCellValue((String)numMap.get("c5"));
					break;
				case 8:
					dataCell.setCellValue((String)numMap.get("c6"));
					break;
				case 9:
					dataCell.setCellValue((String)numMap.get("c7"));
					break;
				case 10:
					dataCell.setCellValue((String)numMap.get("c8"));
					break;
				case 11:
					dataCell.setCellValue((String)numMap.get("c9"));
					break;
				case 12:
					dataCell.setCellValue((String)numMap.get("c10"));
					break;
				case 13:
					dataCell.setCellValue((String)numMap.get("c11"));
					break;
				case 14:
					dataCell.setCellValue((String)numMap.get("c12"));
					break;
				case 15:
					dataCell.setCellValue((String)numMap.get("c13"));
					break;
				}
			}
		}
		return workBook;
	}
	
	public void expordExcel(HttpServletResponse response, OutputStream out) throws Exception {
		workBook = createWorkbook();
		// 重置输出流
		response.reset();
		// 设置导出Excel报表的导出形式
		response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName).getBytes(), "UTF-8"));// 设定输出文件头
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");	// 定义输出类型
		workBook.write(out);
		// 设置输出形式
		System.setOut(new PrintStream(out));
		// 刷新输出流
		out.flush();
		out.close();
	}
	
	/**
	 * 从模块导出excel
	 */
	public void exportExcelWithTemplateex(HttpServletResponse response, OutputStream out) throws Exception {
		workBook = new HSSFWorkbook();
		//读取第一个工作簿
       	HSSFSheet sheet = workBook.getSheetAt(0);
       	
        HSSFRow dataRow = null;  
        HSSFCell dataCell = null; 
        for (int i=0; i<fieldData.size(); i++){
			Map numMap=(Map)fieldData.get(i);
			dataRow = sheet.createRow(i+2);
			int d=0;
			for (int j=0; j<=numMap.size(); j++) {
				dataCell = dataRow.createCell(j);
				switch (j) {
				case 0:
					dataCell.setCellValue((String)numMap.get("c1"));
					break;
				case 1:
					dataCell.setCellValue((String)numMap.get("c2"));
					break;
				case 2:
					dataCell.setCellValue((String)numMap.get("c3"));
					break;
				case 3:
					dataCell.setCellValue((String)numMap.get("c4"));
					break;
				case 4:
					dataCell.setCellValue((String)numMap.get("c5"));
					break;
				case 5:
					dataCell.setCellValue((String)numMap.get("c6"));
					break;
				case 6:
					dataCell.setCellValue((String)numMap.get("c7"));
					break;
				case 7:
					dataCell.setCellValue((String)numMap.get("c8"));
					break;
				case 8:
					dataCell.setCellValue((String)numMap.get("c9"));
					break;
				case 9:
					dataCell.setCellValue((String)numMap.get("c10"));
					break;
				case 10:
					dataCell.setCellValue((String)numMap.get("c11"));
					break;
				case 11:
					dataCell.setCellValue((String)numMap.get("c12"));
					break;
				case 12:
					dataCell.setCellValue((String)numMap.get("c13"));
					break;
				case 13:
					dataCell.setCellValue("");
					break;
				}
			}
		}
		// 重置输出流
		response.reset();
		// 设置导出Excel报表的导出形式
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);// 设定输出文件头
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");	// 定义输出类型
		workBook.write(out);
		out.close();
	}
}
