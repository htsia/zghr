<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
       function doLogin(){
           document.all('init').value="1";
           form1.submit();
           return true;
       }
    </script>
</head>
<body>
  <form action="/pages/EmbedLogin.jsp" id="form1">
      <table>
          <tr>
              <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;用户名：</font></td>
              <td>
                 <input type="text" name="loginName" id="loginName" class="inputDark" alt="用户名|0|s|50"   size="22" tabindex="1"/>
              </td>
              <td width="54" rowspan="2">
                  <input type="hidden" name="init" value="0">
                  <input type="button"  class="button01" value="登录"   onclick="return doLogin();" tabindex="3"/>
              </td>
          </tr>

          <tr height=10></tr>
          <tr>
              <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;密　码：</font></td>
              <td>
                <input type="password" name="password" id="password" class="inputDark" alt="密码|0|s|50"  size="22" tabindex="2"/>
             </td>
          </tr>
      </table>
  </form>
</body>
<script type="text/javascript">
    <%
        if ("1".equals(request.getParameter("init"))){
            String loginName=CommonFuns.filterNull(request.getParameter("loginName"));
            String passwd=CommonFuns.filterNull(request.getParameter("password"));
            if (!"".equals(loginName) && !"".equals(passwd)){
                out.println("window.open('/Logininterface2.jsf?USERID="+loginName+"&PASSWD="+passwd+"','','top=0,left=0,width='+screen.width+',height='+screen.height);");
            }
            else{
                out.println("alert('请输入用户名、密码！');");
            }
        }
    %>

</script>

</html>