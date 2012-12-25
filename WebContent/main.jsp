<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.user.ucc.IUserManageUCC"%>
<html>
  <head><title>czgm</title></head>
  	<body>
  		<%
  			User user=(User)session.getAttribute("USER_INFO");
  			String url=request.getParameter("url");
  		    if(user==null){
	  			String username=request.getParameter("username");
	  			try {
	  				IUserManageUCC userucc = (IUserManageUCC) SysContext.getBean("user_userManageUccImpl");
	  				User user1 = userucc.verifyLogon(username, session, request);
	  				session.setAttribute("USER_INFO", user1);
	  			} catch (Exception e) {
	  				e.printStackTrace();
	  			}
  		    }
			request.getRequestDispatcher(url).forward(request, response);
  		%>
  	</body>
</html>