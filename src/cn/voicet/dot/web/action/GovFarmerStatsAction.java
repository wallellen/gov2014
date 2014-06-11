package cn.voicet.dot.web.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.GovFarmerStatsService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.util.ExcelTemplateGenerator;
import cn.voicet.dot.web.form.GovFarmerStatsForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("govFarmerStatsAction")
@Scope("prototype")
@SuppressWarnings({"serial","unchecked"})
public class GovFarmerStatsAction extends BaseAction implements ModelDriven<GovFarmerStatsForm>{

	private static Logger log = Logger.getLogger(GovFarmerStatsAction.class);
	@Resource(name=GovFarmerStatsService.SERVICE_NAME)
	private GovFarmerStatsService govFarmerStatsService;
	private GovFarmerStatsForm govFarmerStatsForm = new GovFarmerStatsForm();
	
	public GovFarmerStatsForm getModel() {
		return govFarmerStatsForm;
	}
	
	public String home() {
		DotSession ds = DotSession.getVTSession(request);
		if(ds.getStackLevel()==0)
			ds.pushAllList();
		if(null!=govFarmerStatsForm.getAid() && null!=govFarmerStatsForm.getTjstr()){
			govFarmerStatsService.getFarmerSumInfo(ds, govFarmerStatsForm);
		}else{
			if(null==ds.map.get("aidFarmer")){
				// 设置默认年
				ds.map.put("aidFarmer", 1);
				ds.map.put("tjstrFarmer", "3");
				if(null==ds.map.get("paramFarmer"))
					ds.map.put("paramFarmer", ds.workyear);
			}
			ds.list5 = null;
		}
		return "home";
	}
	
	public String exportFarmerStatsInfo() throws Exception{
		DotSession ds = DotSession.getVTSession(request);
		Map map = new HashMap();
		map.put("c0", "地区名称");
		map.put("c2", ds.map.get("c2"));
		map.put("c3", ds.map.get("c3"));
		map.put("c4", ds.map.get("c4"));
		map.put("c5", ds.map.get("c5"));
		map.put("c6", ds.map.get("c6"));
		map.put("c7", ds.map.get("c7"));
		map.put("c8", ds.map.get("c8"));
		map.put("c9", ds.map.get("c9"));
		ds.list5.add(0, map);
		
		//从上次查询的list中取数据ds.list
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String fileName = "nhfzhz"+format.format(new Date())+".xls";
	    String filePath = request.getSession().getServletContext().getRealPath("excelTemplate")+"/"+"farmerstats.xls";
	    ExcelTemplateGenerator generator = new ExcelTemplateGenerator(filePath, fileName, 0, ds.list5);
	    generator.setColList("c0,c2,c3,c4,c5,c6,c7,c8,c9");
	    generator.setDrawBoard();
	    generator.setEffectColNum(9);
	    generator.exportExcelWithTemplate3(response);
		
		return null;
	}
}
