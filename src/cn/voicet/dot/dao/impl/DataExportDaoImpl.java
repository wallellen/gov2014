package cn.voicet.dot.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.struts2.ServletActionContext;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.dot.dao.DataExportDao;
import cn.voicet.dot.util.BytesConvert;
import cn.voicet.dot.util.DotSession;

@Repository(DataExportDao.SERVICE_NAME)
@SuppressWarnings("deprecation")
public class DataExportDaoImpl extends CommonDaoImpl<Object> implements DataExportDao {

	public String exportXianDataByBM(final DotSession ds, final String zipFileName) {
		String zipFullName = (String)getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String path = ServletActionContext.getServletContext().getRealPath("download")+"/";
				
				String fullName = path+zipFileName+".zip";
				try {
					ZipOutputStream out = new ZipOutputStream(new FileOutputStream(fullName));
					String sb="";   
					byte[] buffer = new byte[1024];
					String proc = "{call mp_export_xian(?)}";
					Connection conn = session.connection();
					CallableStatement cs = conn.prepareCall(proc);
					cs.setString(1, ds.rbm);
					cs.execute();
					ResultSet rs = null;
					boolean bHaveLine=false;
					int rid=0;
					ds.initData();
					//
					while(cs.getUpdateCount()!=-1);
					while((rs = cs.getResultSet())!=null&&rid++<4)
					{
						bHaveLine=false;
						int iclm=cs.getMetaData().getColumnCount();
			    		out.putNextEntry(new ZipEntry("b"+rid+".txt"));
			    		while(rs.next())
						{
							if(bHaveLine) sb=sb+"\r\n";
							for(int j=0;j<iclm;j++)
							{
								if(j>0)
								{
									sb=sb+",";
								}
								//
								sb=sb+rs.getString(j+1);
							}
							bHaveLine=true;
							//
							if(sb.length()>4*1024)
							{
								byte [] b=BytesConvert.StringToBytes(sb, "utf-8");
								out.write(b,0,b.length);
								sb="";
							}
						}
						//
						if(sb.length()>2)
						{
							byte [] b=BytesConvert.StringToBytes(sb, "utf-8");
							out.write(b,0,b.length);
							sb="";
						}
						//
						out.closeEntry();
						while(cs.getUpdateCount()!=-1);
						cs.getMoreResults();
					}
					//
					String readPath = ServletActionContext.getServletContext().getRealPath("down")+"/";
					File readmeFile = new File(readPath+"导出文件说明.txt");
					FileInputStream fis = new FileInputStream(readmeFile);
					String filename = readmeFile.getName(); 
					out.setEncoding("utf-8");
					out.putNextEntry(new ZipEntry(filename));
					int len;
			        //读入需要下载的文件的内容，打包到zip文件
			        while((len = fis.read(buffer))>0){
			        	out.write(buffer,0,len);
			        }
					//
		    		out.closeEntry();
					fis.close();
					out.close();
				} catch (Exception e) {
				}
				return fullName;
			}
		});
		return zipFullName;
	}
	
	
	
}
