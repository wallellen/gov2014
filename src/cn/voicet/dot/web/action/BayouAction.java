package cn.voicet.dot.web.action;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.BayouService;
import cn.voicet.dot.util.DotSession;
import cn.voicet.dot.web.form.BayouForm;

import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
@Controller("bayouAction")
@Scope("prototype")
public class BayouAction extends BaseAction implements ModelDriven<BayouForm>{

	private static Logger log = Logger.getLogger(BayouAction.class);
	
	@Resource(name=BayouService.SERVICE_NAME)
	private BayouService bayouService;
	
	private BayouForm bayouForm = new BayouForm();
	
	public BayouForm getModel() {
		return bayouForm;
	}
	
	/**
	 * 查询人有信息列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null==bayouForm.getAreabm())
		{
			bayouForm.setAreabm(ds.rbm);
		}
		log.info("areabm:"+bayouForm.getAreabm());
		bayouService.queryBayouInfo(ds, bayouForm);
		log.info("list size:"+ds.list.size());
		//
		Map map;
		String html = "";
		String sXXCName[]=new String[3];
		String returnBTN = "";
		if(null==bayouForm.getRetbtn())
		{
			returnBTN = "操作";
		}
		else
		{
			returnBTN += "<input type='button' onclick='history.go(-"+rflag+")' value='返回' class='button43'/>";
		}
		html+="<div class='Contentbox_shi'>";
		html += "<table cellspacing='0' cellpadding='0' width='100%'>";
		html += "<tr class='tabtr1'>" +
		"<td width='25%'>地区名称</td>" +
		"<td width='25%'>地区名称</td>" +
		"<td width='25%'>"+
		returnBTN + 
		"</td>" +
		"</tr>";
		String temp = "";
		String aflag = "";
		int rn=0;
		for (int i=0; i<ds.list.size(); i++) {
			map = (Map) ds.list.get(i);
			int id = Integer.parseInt(map.get("id").toString());
			int idd = Integer.parseInt(map.get("idd").toString());
			String name= (String)map.get("name");
			String bm= (String)map.get("bm");
			//
			if(bm.length()==6)
			{
				aflag = "<a href='bayou_query.do?areabm="+bm+"&retbtn=y&shiname="+sXXCName[0]+"&xianname="+name+"'>进入</a>";
			}
			else if(bm.length()==12)
			{
				aflag = "<a href='bayou_view.do?areabm="+bm+"&zhenname="+sXXCName[0]+"&cunname="+name+"'>查看</a>&nbsp;&nbsp;";
				if(ds.rbm.length()==2)
				{
					aflag += "<a href='bayou_deletecun.do?areabm="+bm+"&retbtn=y&zhenname="+sXXCName[0]+"&cunname="+name+"'>删除</a>";;
				}
			}
			//
			if(idd==0 && temp.length()>0)
			{
				temp=temp.replace("#ROWSPAN_NUM#",String.valueOf(rn-1));
				html+=temp;
				temp="";
				rn=0;
			}
			if(rn==0)
			{
				temp="<tr>"
					+"<td rowspan='#ROWSPAN_NUM#'>"+name+"</td>"
					+"<td>#NAME#</td>"
					+ "<td>"
					+ aflag
					+ "</td>"
					+"</tr>";
				sXXCName[0]=name;
			}
			else if(rn==1)
			{
				temp=temp.replace("<td></td>", "<td>"+aflag+"</td>");
				temp=temp.replace("#NAME#", name);
				log.info("temp:"+temp);
			}
			//
			else
			{
				temp += "<tr>"
					+ "<td>"+name+"</td>"
					+ "<td>"
					+ aflag
					+ "</td>"
					+ "</tr>";
			}
			rn++;
		}
		if(temp.length()>0)
		{
			temp=temp.replace("#ROWSPAN_NUM#",String.valueOf(rn-1));
			html+=temp;
			rn=0;
		}
		html+="</table></div>";
		request.setAttribute("h", html);
		//
		ds.map.put("shiname", bayouForm.getShiname());
		ds.map.put("xianname", bayouForm.getXianname());
		return "show_bayou";
	}
	
	/**
	 * 查看八有信息
	 */
	public String view()
	{
		DotSession ds = DotSession.getVTSession(request);
		ds.map.put("zhenname", bayouForm.getZhenname());
		ds.map.put("cunname", bayouForm.getCunname());
		log.info("ds map:"+ds.map);
		//
		log.info("areabm:"+bayouForm.getAreabm());
		Map<String, Object> map = bayouService.queryBayouDetailInfo(bayouForm);
		log.info("map:"+map);
		request.setAttribute("byMap", map);
		return "show_bayou_detail";
	}
	
	/**
	 * 更新
	 */
	public String saveBayou()
	{
		log.info("areabm:"+bayouForm.getAreabm());
		log.info("bytxt[] length:"+bayouForm.getBytxt().length);
		bayouService.saveBayouInfo(bayouForm);
		rflag = rflag+1;
		log.info("rflag:"+rflag);
		return view();
	}
	
	/** 打印家庭详细信息 */
	public String printBayou() {
		Map<String, Object> map = bayouService.queryBayouDetailInfo(bayouForm);
		log.info("map:"+map);
		request.setAttribute("byMap", map);
		return "show_bayou_report";
	}
	
	public String addcun()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("areabm:"+bayouForm.getAreabm());
		bayouService.addCunWithAreabm(ds, bayouForm);
		bayouForm.setAreabm(bayouForm.getAreabm().substring(0, 6));
		rflag = rflag+1;
		return query();
	}
	
	public String deletecun()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("areabm:"+bayouForm.getAreabm());
		bayouService.deleteCunByAreabm(ds, bayouForm);
		bayouForm.setAreabm(bayouForm.getAreabm().substring(0, 6));
		rflag = rflag+1;
		return query();
	}
	
	
	
	private int rflag=1;
	public int getRflag() {
		return rflag;
	}
	public void setRflag(int rflag) {
		this.rflag = rflag;
	}
}
