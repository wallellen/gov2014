package cn.voicet.dot.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 用过滤器解决中文件乱码
 * @author 向雪平
 * @version 13-04-26
 */
public class EncodingFilter implements Filter{

	@SuppressWarnings("unused")
	private FilterConfig config;
	private String encoding = "utf-8";
	
	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(encoding);
		chain.doFilter(request, response);
		response.setContentType("text/html;charset=utf-8");
	}

	public void init(FilterConfig config) throws ServletException {
		this.config=config;
        String s=config.getInitParameter("encoding");//获取初始化参数数，
        if(s!=null){
            this.encoding=s;
        }
	}
	
}
