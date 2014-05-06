package cn.voicet.dot.util;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogonUtils {

	/**
	 * @throws Exception 
	 * @see ��ҳ��¼�������֤��Ĺ���
	 */
	public static void rememberPassByCookie(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		// ��ȡҳ���еĵ�¼��������
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		// ����2��Cookie, �ֱ�������ŵ�¼��������
		// ����Cookie�д��ڵ������ַ�
		if(null!=account && null!=password){
			String codeName = URLEncoder.encode(account, "UTF-8");
			Cookie accountCookie = new Cookie("account", codeName);
			Cookie passwordCookie = new Cookie("password", password);
			
			// ����Cookie����Ч·��, ��Ч·������Ϊ��Ŀ�ĸ�·��
			accountCookie.setPath(request.getContextPath() + "/");
			passwordCookie.setPath(request.getContextPath() + "/");
		
			/*
			 *  ��ҳ���л�ȡ��ס�ҵĸ�ѡ���ֵ 
			 *  	�����ֵ, ����Cookie����Чʱ��
			 *  	���û��ֵ, ���Cookie����Чʱ��
			 */
			String rememberPass = request.getParameter("rememberPass");
			if (rememberPass!=null && rememberPass.equals("yes")) {
				// ����Cookie����Чʱ��
				accountCookie.setMaxAge(7*24*60*60);
				passwordCookie.setMaxAge(7*24*60*60);
			} else {
				// ���Cookie����Чʱ��
				accountCookie.setMaxAge(0);
				passwordCookie.setMaxAge(0);
			}
			response.addCookie(accountCookie);
			response.addCookie(passwordCookie);
		}
	}

}
