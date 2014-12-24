package cn.voicet.dot.web.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovFarmerQueryService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovFarmerQueryForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govFarmerQueryAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class GovFarmerQueryAction extends BaseAction implements ModelDriven<GovFarmerQueryForm>{
 
	private static Logger log = Logger.getLogger(GovFarmerQueryAction.class);
	@Resource(name=GovFarmerQueryService.SERVICE_NAME)
	private GovFarmerQueryService govFarmerQueryService;
	private GovFarmerQueryForm govFarmerQueryForm = new GovFarmerQueryForm();
	
	public GovFarmerQueryForm getModel() {
		return govFarmerQueryForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		if(ds.getStackLevel()==0)
			ds.pushAllList();
		ds.initData();
		if(null!=govFarmerQueryForm.getQstr()){
			ds.map.put("qarr", govFarmerQueryForm.getQstr());
			ds.map.put("telhu", govFarmerQueryForm.getTelhu());
			govFarmerQueryService.getFarmerInfoList(ds);
		}
		log.info("farmernt:"+ds.map.get("farmernt"));
		log.info("peoplent:"+ds.map.get("peoplent"));
		return "home";
	}
	
	public String member(){
		DotSession ds = DotSession.getVTSession(request);
		if(ds.getStackLevel()==0)
			ds.pushAllList();
		ds.initData();
		if(null!=govFarmerQueryForm.getMemberstr()){
			ds.map.put("marr", govFarmerQueryForm.getMemberstr());
			govFarmerQueryService.getMemberInfoList(ds);
		}
		return "showMemberHome";
	}
	
	/** 导出农户信息 */
	public String exportFarmerInfo() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govFarmerQueryService.getAllFarmerInfoList(ds);
		//从上次查询的list中取数据ds.list
		log.info("list5 size:"+ds.list5.size());
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String fileName = "nhcx"+format.format(new Date())+".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"farmer.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 1, ds.list5);
	    generator.setColList("hm,govname,hname,property,population,telnum");
	    generator.setDrawBoard();
	    generator.setEffectColNum(6);
	    generator.exportExcelWithTemplate(response);
	    log.info("farmernt:"+ds.map.get("farmernt"));
		log.info("peoplent:"+ds.map.get("peoplent"));
		return null;
	}
	
	/** 导出人口信息 */
	public String exportMemberInfo() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		govFarmerQueryService.getAllMemberInfoList(ds);
		log.info("list size:"+ds.list.size());
		//从上次查询的list中取数据ds.list
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String fileName = "rkcx"+format.format(new Date())+".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"member.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 1, ds.list);
	    generator.setColList("c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
		return null;
	}
	
}
