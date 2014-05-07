package cn.voicet.dot.web.action;

import javax.annotation.Resource;

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
			govFarmerQueryService.getFarmerInfoList(ds);
		}
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
	
	public String exportMemberInfo() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		//从上次查询的list中取数据
		String fileName = new String(("人口统计").getBytes("gb2312"), "ISO8859-1") +".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"member.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 1, ds.list);
	    generator.setColList("c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12");
	    generator.setDrawBoard();
	    generator.setEffectColNum(13);
	    generator.exportExcelWithTemplate(response);
		return null;
	}
	
}
