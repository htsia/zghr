<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.NavigateBO" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title>
          <link href="/css/style.css" rel="stylesheet" type="text/css"/>
      </title>
  </head>
 <body  BGCOLOR=<%=Constants.BGCOLOR%>>
      <%
          String module=request.getParameter("moduleID");
      %>
      <map name="Map">
          <%
              User user = (User) session.getAttribute(Constants.USER_INFO);
              SysAPI api = (SysAPI) SysContext.getBean("sys_SysAPI");
              UserAPI useapi = (UserAPI) SysContext.getBean("user_pmsAPI");
              List list = api.getNaviList(module);
              for (int i = 0; i < list.size(); i++) {
                  NavigateBO nb = (NavigateBO) list.get(i);
                  OperateBO oo = SysCacheTool.findOperate(nb.getOperateID());
                  if (useapi.checkOperate(user,oo.getOperateId())==0){
                      out.println("<area  alt=\""+oo.getOperateName()+"\" shape=\"rect\" coords=\"" + nb.getCoords() + "\" href=\"javascript:window.location='" + oo.getUrl() + "'\" >");
                  }
              }
          %>
      </map>
      <table width="98%" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td align="center">
                    <img src="/images/navigate/<%=module%>.jpg" alt="" usemap="#Map" style = "border:0px" >
                </td>
            </tr>
      </table>
  </body>
</html>