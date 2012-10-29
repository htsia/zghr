<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.ucc.impl.ShortMessageUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.List" %>
<html>
  <head><title></title>
      <script type="text/javascript">
      <%
          ShortMessageUCC rc=(ShortMessageUCC)SysContext.getBean("sys_SMUCC");
          User user = (User) (session.getAttribute(Constants.USER_INFO));
          List list=rc.getMessageForPop(user.getUserId());
          if (list!=null && list.size()>0){
              out.print("window.open('/system/ReadMessage.jsf','_blank','height=300, width=500, top=10, left=10,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');");          
          }
      %>
      </script>
  </head>
  <body >
  <form>
      <input type="hidden" value="true" id="checkNew">
  </form>
  </body>
</html>