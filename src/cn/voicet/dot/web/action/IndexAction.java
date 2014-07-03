package cn.voicet.dot.web.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("indexAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class IndexAction extends BaseAction {
	
	public String home(){
		return "home";
	}
}
