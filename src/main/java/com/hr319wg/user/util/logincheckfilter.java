package com.hr319wg.user.util;

import java.io.IOException;
import java.util.Hashtable;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.util.CommonFuns;

public class logincheckfilter implements Filter {
	private Hashtable hash;

	public logincheckfilter() {
		this.hash = new Hashtable();
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		String filterName = CommonFuns.filterNull(filterConfig
				.getInitParameter("unfilterPath"));
		String[] a = filterName.split(",");
		if (a != null) {
			for (int i = 0; i < a.length; i++)
				this.hash.put(a[i].toUpperCase(), a[i].toUpperCase());
		}
	}

	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
		HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
		String uriStr = httpRequest.getRequestURI();
		String path = uriStr.toUpperCase().substring(0, uriStr.lastIndexOf("/"));
		if ((path.startsWith("/CSS")) || (path.startsWith("/JS"))
				|| (path.startsWith("/IMAGES"))
				|| (path.startsWith("/PAGES/PORTALLOGIN"))) {
			filterChain.doFilter(servletRequest, servletResponse);
			return;
		}
		if ((uriStr.equals("/pages/loginsc.jsp"))
				|| (uriStr.equals("/pages/loginjy.jsp"))
				|| (uriStr.equals("/ModifyPassword.jsf"))
				|| (uriStr.equals("/LoginModiPass.jsf"))
				|| (uriStr.equals("/Logininterface.jsf"))
				|| (uriStr.equals("/Logininterface2.jsf"))
				|| (uriStr.equals("/Login.jsf"))
				|| (uriStr.equals("/LoginByCardI.jsf"))
				|| (uriStr.equals("/RegLogin.jsf"))
				|| (uriStr.equals("/PortalLogin.jsf"))
				|| (uriStr.equals("/recruit/ResumeLogin.jsf"))
				|| (uriStr.equals("/recruit/register.jsf"))
				|| (uriStr.equals("/pages/overtime.jsp"))
				|| (uriStr.equals("/pages/noCopyRight.htm"))
				|| (uriStr.equals("/pages/stoptime.htm"))
				|| (uriStr.equals("/pages/LogOff.jsp"))
				|| (uriStr.equals("/eva/tempMasterLogin.jsf"))
				|| (uriStr.equals("/run/dataexchange/login.jsf"))
				|| (uriStr.equals("/lmscmi"))
				|| (uriStr.equals("/self/QueryOneBulletin.jsf"))
				|| (uriStr.equals("/self/QueryOneNews.jsf"))
				|| (uriStr.equals("/system/MorePublicBull.jsf"))
				|| (uriStr.equals("/system/MorePublicNews.jsf"))
				|| (uriStr.equals("/pages/include/template.jsp"))
				|| (uriStr.equals("/pages/include/templateLogin.jsp"))
				|| (uriStr.equals("/pages/system/shortmessage/checknew.jsp"))
				|| (uriStr.equals("/pages/common/SelOrg.jsp"))
				|| (uriStr.equals("/pages/common/CalendarDlg.jsp"))
				|| (uriStr.equals("/pages/common/SelCode.jsp"))
				|| (uriStr.equals("/pages/ajax/Org.jsp"))
				|| (uriStr.equals("/pages/ajax/getUserInfo.jsp"))
				|| (uriStr.equals("/pages/ajax/Code.jsp"))
				|| (uriStr.equals("/pages/ajax/Interpret.jsp"))
				|| (uriStr.equals("/pages/system/CardI/installDrv.html"))
				|| (uriStr.equals("/pages/system/CardI/cardI.cab"))
				|| (uriStr.equals("/pages/report/rptprint.cab"))
				|| (uriStr.equals("/index.jsp"))) {
			filterChain.doFilter(servletRequest, servletResponse);
			return;
		}
		if (("1".equals(Constants.BEGIN_STOP)) && (uriStr.equals("/Login.jsf"))) {
			httpResponse.sendRedirect("/pages/stoptime.htm");
			return;
		}
		if ((!path.equals(""))
				&& (this.hash.get(path) == null)
				&& (httpRequest.getSession().getAttribute("USER_INFO") == null)
				&& (httpRequest.getSession().getAttribute("OA_USER_INFO") == null)) {
			httpResponse.sendRedirect("/pages/overtime.jsp");
		} else {
			try {
				User user = (User) httpRequest.getSession().getAttribute("USER_INFO");
				UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
				api.maskUserOperTime(user.getUserId());
			} catch (Exception localException) {
			}
			filterChain.doFilter(servletRequest, servletResponse);
		}
	}

	public void destroy() {
	}
}