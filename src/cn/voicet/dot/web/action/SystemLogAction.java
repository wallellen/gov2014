package cn.voicet.dot.web.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.dot.service.SystemLogService;
import cn.voicet.dot.util.DotSession;

@Controller("systemLogAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class SystemLogAction extends BaseAction{

	@Resource(name=SystemLogService.SERVICE_NAME)
	private SystemLogService systemLogService;
	
	//��ȡ��ǰϵͳʱ��, ����ʽ��
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Date());
	private String startdate = date;
	private String enddate = date;
	private String msgtype;
	private String sender;
	private Integer totalPage;	//��ҳ��
	private int pageSize = 27;	//ÿҳ����
	private int curPage = 1;	//��ǰҳ, Ĭ��Ϊ��һҳ, Ϊ0ʱ,������ҳ����
	
	public String home() {
		//�����ʼ���� �� ��������Ϊ��, ��ѯ���Ϊ��ǰ���ڵ�ϵͳ��־
		if (request.getParameter("startdate") == "" || request.getParameter("enddate") == ""){
			startdate = date;
			enddate = date;
		}
		//�ж�, ��һҳС��1ʱ, ��һҳ������ҳ
		if(curPage<1){
			curPage=1;
		}
		totalPage = systemLogService.findLogTotalPage(startdate, enddate, msgtype, sender, pageSize);
		//�ж�,��һҳ������ҳ��ʱ, ��һҳ�������һҳ
		if(curPage>totalPage){
			curPage=totalPage;
		}
		List list = systemLogService.findLogInfo(startdate, enddate, msgtype, sender, curPage, pageSize);
		request.setAttribute("logList", list);
		return "home";
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	
}
