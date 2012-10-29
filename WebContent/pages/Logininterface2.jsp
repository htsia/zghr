<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%@ include file="./include/taglib.jsp" %>
   <c:verbatim>
   <script type="text/javascript">
        var time;
        function doJump(){
            window.clearInterval(time);
            if (document.all('form1:loginName').value!='' &&
                document.all('form1:password').value!=''){
                document.getElementById("checkSubmitFlg").value="0";
                document.all("form1:login").click();
            }
        }
   </script>
   </c:verbatim>
   <h:form id="form1">
       <h:outputText value="正在处理......"></h:outputText>
       <h:inputHidden id="loginName" value="#{user_loginBB.loginName}"></h:inputHidden>
       <h:inputHidden id="password" value="#{user_loginBB.password}"></h:inputHidden>
       <h:commandButton  id="login" style="display:none" value="登录"  action="#{user_loginBB.login}" />
   </h:form>
    <script type="text/javascript">
       <%
           String loginName=CommonFuns.filterNull(request.getParameter("form1:loginName"));
           String passwd=CommonFuns.filterNull(request.getParameter("form1:password"));
           if (!"".equals(loginName) && !"".equals(passwd)){
              out.println("document.all('form1:loginName').value='"+loginName+"';");
              out.println("document.all('form1:password').value='"+passwd+"';");
           }
           else{
              out.println("document.all('form1:loginName').value='';");
              out.println("document.all('form1:password').value='';");
           }
       %>
        time=window.setInterval('doJump()', 600);
    </script>

