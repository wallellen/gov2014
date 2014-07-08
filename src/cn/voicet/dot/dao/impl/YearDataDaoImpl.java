package cn.voicet.dot.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.YearDataDao;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.VTXiang;

@Repository(YearDataDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class YearDataDaoImpl extends CommonDaoImpl<Object> implements YearDataDao {
	
	public void batchImportYearData(final DotSession ds, final File excel) {
		System.out.println("test");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				PreparedStatement ps = null;
				String vl[];
	        	String storedProc = "{call sp_year_import_byweb(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
	        	//关闭事务自动提交
	        	conn.setAutoCommit(false);
	        	ps = conn.prepareStatement(storedProc);
	        	try {
					
					int rownum = 0;
					//第一行是标题，从第二行开始读取
					for(int i=0; i<ds.list.size(); i++){
						vl = (String[]) ds.list.get(i);
						System.out.println("vl:"+vl);
						ps.setString(1, vl[0]);
						ps.setInt(2, Integer.parseInt(vl[1]));
						ps.setFloat(3, Float.parseFloat(vl[2]));
						ps.setFloat(4, Float.parseFloat(vl[3]));
						ps.setFloat(5, Float.parseFloat(vl[4]));
						ps.setFloat(6, Float.parseFloat(vl[5]));
						ps.setFloat(7, Float.parseFloat(vl[6]));
						ps.setFloat(8, Float.parseFloat(vl[7]));
						ps.setFloat(9, Float.parseFloat(vl[8]));
						ps.setFloat(10, Float.parseFloat(vl[9]));
						ps.setFloat(11, Float.parseFloat(vl[10]));
						ps.setFloat(12, Float.parseFloat(vl[11]));
						ps.setFloat(13, Float.parseFloat(vl[12]));
						ps.setInt(14, Integer.parseInt(vl[13]));
						ps.setInt(15, Integer.parseInt(vl[14]));
						//读取第一列
			        	//批处理
			        	ps.addBatch();
			        	
			        	if(++rownum >= 1000){
			        		//执行批量更新    
			        		ps.executeBatch();
			        		//语句执行完毕，提交本事务 
			        		conn.commit();
			        		ps.clearBatch();
			        		rownum = 0;
			        	}
					}
					if(rownum > 0){
						ps.executeBatch();
						conn.commit();
						ps.clearBatch();
						
					}
					//
					if(ps != null){
						ps.close();
					}
					//inStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}

	public void batchImportYearData1(final DotSession ds, final File excel) {
		System.out.println("test");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Connection conn = session.connection();
				PreparedStatement ps = null;
	        	String storedProc = "{call sp_year_import_byweb(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
	        	//关闭事务自动提交
	        	conn.setAutoCommit(false);
	        	ps = conn.prepareStatement(storedProc);
	        	try {
					InputStream inStream = null; 
					inStream = new FileInputStream(excel);
					//创建工作簿
					Workbook wb = VTXiang.create(inStream);  
					//获取第一个表格
					Sheet sheet = wb.getSheetAt(0);
					//获取总行数
					int totalRow = sheet.getLastRowNum();
					//
					System.out.println("totalRow:"+totalRow);
					int rownum = 0;
					//第一行是标题，从第二行开始读取
					for(int i=1; i<=5; i++){
						Row row = sheet.getRow(i);
						//读取第一列
						
						row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
						row.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
						
						System.out.println("hm:"+row.getCell(0).getStringCellValue());
						
						ps.setString(1, String.valueOf(row.getCell(0).getStringCellValue()));
			        	ps.setInt(2, Integer.valueOf(row.getCell(1).getStringCellValue()));
			        	ps.setFloat(3, Float.valueOf(row.getCell(2).getStringCellValue()));
			        	ps.setFloat(4, Float.valueOf(row.getCell(3).getStringCellValue()));
			        	ps.setFloat(5, Float.valueOf(row.getCell(4).getStringCellValue()));
			        	ps.setFloat(6, Float.valueOf(row.getCell(5).getStringCellValue()));
			        	ps.setFloat(7, Float.valueOf(row.getCell(6).getStringCellValue()));
			        	ps.setFloat(8, Float.valueOf(row.getCell(7).getStringCellValue()));
			        	ps.setFloat(9, Float.valueOf(row.getCell(8).getStringCellValue()));
			        	ps.setFloat(10, Float.valueOf(row.getCell(9).getStringCellValue()));
			        	ps.setFloat(11, Float.valueOf(row.getCell(10).getStringCellValue()));
			        	ps.setFloat(12, Float.valueOf(row.getCell(11).getStringCellValue()));
			        	ps.setFloat(13, Float.valueOf(row.getCell(12).getStringCellValue()));
			        	ps.setInt(14, Integer.valueOf(row.getCell(13).getStringCellValue()));
			        	ps.setInt(15, Integer.valueOf(row.getCell(14).getStringCellValue()));
			        	
			        	//批处理
			        	ps.addBatch();
			        	if(++rownum >= 1000){
			        		//执行批量更新    
			        		ps.executeBatch();
			        		//语句执行完毕，提交本事务 
			        		conn.commit();
			        		ps.clearBatch();
			        		rownum = 0;
			        	}
					}
					if(rownum > 0){
						ps.executeBatch();
						conn.commit();
						ps.clearBatch();
						
					}
					
					if(ps != null){
						ps.close();
					}
					inStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}

}
