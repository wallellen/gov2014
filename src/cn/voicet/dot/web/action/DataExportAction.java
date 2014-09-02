package cn.voicet.dot.web.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.DataExportService;
import cn.voicet.dot.util.DotSession;

@Controller("dataExportAction")
@Scope("prototype")
@SuppressWarnings( "serial")
public class DataExportAction extends BaseAction {

	private static Logger log = Logger.getLogger(DataExportAction.class);
	@Resource(name = DataExportService.SERVICE_NAME)
	private DataExportService dataExportService;

	public String home() {
		return "show_export";
	}

	public String exportData() {

		DotSession ds = DotSession.getVTSession(request);
		String zipFullName = dataExportService.exportXianDataByBM(ds,zipFileName);
		log.info("zipFullName:"+zipFullName);
		downloadZip(zipFullName);
		return null;
	}
	
	private void downloadZip(String zipFileName){
		try {
			File file = new File(zipFileName);  
			String filename = file.getName();  
			log.info("filename:"+filename);
			InputStream fis = new BufferedInputStream(new FileInputStream(zipFileName));  
			byte[] buffer = new byte[fis.available()];  
			fis.read(buffer);  
			fis.close();  
			filename = new String(filename.getBytes(), "ISO8859-1");
			response.reset();  
			response.setContentType("application/zip;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Content-Disposition", "attachment;filename="+filename);  
			response.addHeader("Content-Length", "" + file.length()); // 设置返回的文件类型  
			OutputStream outputStream = new BufferedOutputStream(response.getOutputStream()); // 得到向客户端输出二进制数据的对象   
			outputStream.write(buffer); // 输出数据  
			outputStream.flush();  
			outputStream.close();
		} catch (Exception e) {
			
		}
	}


	private String zipFileName;
	public String getZipFileName() {
		return zipFileName;
	}
	public void setZipFileName(String zipFileName) {
		DotSession ds = DotSession.getVTSession(request);
		if(zipFileName.length()>0){
			this.zipFileName = zipFileName;
		}else{
			this.zipFileName = "【"+ds.rbm+"】"+ds.rbn+"";
		}
	}
	
}
