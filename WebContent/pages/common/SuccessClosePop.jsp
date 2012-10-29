<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head></head>
<body>
    <script type="text/javascript">
        <%
           User user=(User)session.getAttribute(Constants.USER_INFO);
           String msg=LanguageSupport.getResource("MSG-0009","²Ù×÷³É¹¦",user.getLoginLang());
           out.print("alert('"+msg+"!');");
        %>
        window.returnValue = "ok";
        window.close();
    </script>
</body>
</html>
