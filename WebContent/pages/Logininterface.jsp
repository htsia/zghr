<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="./include/taglib.jsp" %>

<%
	String approtype=request.getParameter("approtype");
	session.setAttribute("approtype", approtype);
%>
<h:form id="form1">
   <c:verbatim>
   <table height=98% width=98%>
   <tr><td valign="middle" align="center">
       <span style="font-size: 14pt; font-family: ����_GB2312"><strong>���ڴ���,���Ժ�.....</strong></span>
   </td></tr>
   </table>
    </c:verbatim>
   <h:commandButton  id="login" style="display:none" value="��¼"  action="#{user_loginBB.login2}" />
</h:form>
<script type="text/javascript">
   var tcount;
   function doJump(){
     window.clearInterval(tcount);
     document.all("form1:login").click();
   }
   tcount=window.setInterval('doJump()', 500);
</script>
