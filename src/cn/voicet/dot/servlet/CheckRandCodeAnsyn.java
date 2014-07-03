package cn.voicet.dot.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

public class CheckRandCodeAnsyn extends HttpServlet {

	private static Logger log = Logger.getLogger(CheckRandCodeAnsyn.class);
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			String vercode = request.getParameter("vercode");
			log.info("vercode:"+vercode);
			log.info("rand:"+request.getSession().getAttribute("rand"));
			JSONObject jsonObj = new JSONObject();
			if (null!=request.getSession().getAttribute("rand") && !vercode.trim().equals((String) request.getSession().getAttribute("rand"))) 
			{
				jsonObj.put("status", "vercodeerror");
			}
			else
			{
				jsonObj.put("status", "ok");
			}
			try {
				
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(jsonObj.toString());
				response.getWriter().flush();
			} catch (IOException e) {
				
			}
	}

}
