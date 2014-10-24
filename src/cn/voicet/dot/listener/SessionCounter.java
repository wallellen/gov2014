package cn.voicet.dot.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

/**
 * 统计在线人数
 */
public class SessionCounter implements HttpSessionListener {
	private static Logger log = Logger.getLogger(SessionCounter.class);
	public void sessionCreated(HttpSessionEvent event) {
		log.info("sessionCreated ++++++"); 
        ServletContext context=event.getSession().getServletContext(); 
        Integer count=(Integer)context.getAttribute("numSessions"); 
        if(count==null){ 
            count=new Integer(1); 
        }else{ 
            int co = count.intValue( ); 
            count= new Integer(co+1); 
        } 
        log.info("current user count: "+count); 
        context.setAttribute("numSessions", count);//保存人数 
        
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		log.info("sessionDestroyed ------"); 
        ServletContext context=event.getSession().getServletContext(); 
        Integer count=(Integer)context.getAttribute("numSessions"); 
        int co=count.intValue(); 
        count=new Integer(co-1); 
        context.setAttribute("numSessions", count); 
        log.info("current user count: "+count); 
	}

}
