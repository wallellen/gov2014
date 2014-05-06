package cn.voicet.dot.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 统计在线人数
 */
public class SessionCounter implements HttpSessionListener {

	public void sessionCreated(HttpSessionEvent event) {
        System.out.println("sessionCreated ++++++"); 
        ServletContext context=event.getSession().getServletContext(); 
        Integer count=(Integer)context.getAttribute("numSessions"); 
        if(count==null){ 
            count=new Integer(1); 
        }else{ 
            int co = count.intValue( ); 
            count= new Integer(co+1); 
        } 
        System.out.println("current user count: "+count); 
        context.setAttribute("numSessions", count);//保存人数 
        
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		System.out.println("sessionDestroyed ------"); 
        ServletContext context=event.getSession().getServletContext(); 
        Integer count=(Integer)context.getAttribute("numSessions"); 
        int co=count.intValue(); 
        count=new Integer(co-1); 
        context.setAttribute("numSessions", count); 
        System.out.println("current user count: "+count); 
	}

}
