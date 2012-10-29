<%@ page import="com.hr319wg.sys.ucc.impl.PortalFunUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.bo.PortalFunctionBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.UserPortalBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <body>
      <%
          try {
              String itemID = request.getParameter("itemID");
              if (itemID != null) {
                  PortalFunUCC pc = (PortalFunUCC) SysContext.getBean("sys_portalUCC");
                  UserPortalBO ub=pc.findUserPortalBO(itemID);
                  PortalFunctionBO pb = pc.findPortalFunctionBO(ub.getFunID());
                  if (PortalFunctionBO.MODE_POP.equals(pb.getUimode())){
                      out.println("<script language='javascript'>");
                      out.println("  window.open('"+pc.getConnect(ub,pb)+"', \"_blank\", \"height=\"+screen.height+\", width=\"+screen.width+\",toolbar=no,scrollbars=\"+scroll+\",menubar=no\");");
                      out.println("</script>");
                  }
                  else{
                    response.sendRedirect(pc.getConnect(ub,pb));
                  }
              }
          }
          catch (Exception e) {
              out.println("进入应用出错,"+e.getMessage());
          }
      %>
  </body>
</html>