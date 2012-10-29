<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="./include/taglib.jsp" %>
 
<h:form id="form1">
<f:verbatim>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
       <tr>
           <td  height='100%' width='100%' ><img alt="" src='../images/maininterface/login_backgroud.jpg' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>
       </tr>
    </table>

    <table   id="center" style='POSITION: absolute;' width='400' cellspacing=0 cellpadding=0 border=0>
    <tr height="35">
        <td></td>
        <td></td>
        <td width="54" rowspan="2"></td>
    </tr>
   <tr height="35">
        <td></td>
        <td></td>
        <td width="54" rowspan="2"></td>
    </tr>
   <tr height="20">
        <td></td>
        <td></td>
        <td width="54" rowspan="2"></td>
    </tr>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;身份证号：</font></td>
        <td>
</f:verbatim>
            <h:inputText id="loginName" styleClass="inputDark" alt="用户名|0|s|50"
                         value="#{user_loginBB.loginName}" size="22" tabindex="1"/>
<f:verbatim>
        </td>
        <td width="54" rowspan="2"></td>
    </tr>
    <tr height=10></tr>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;密　码：</font></td>
        <td>
</f:verbatim>
        <h:inputSecret id="password" styleClass="inputDark" alt="密码|0|s|50"     value="#{user_loginBB.password}" size="22" tabindex="2"/>
        
<f:verbatim>
       </td>
        <td width="54" rowspan="2"></td>
    </tr>
     <tr height="35">
        <td align="right"></td>
        <td></td>
        <td width="54" rowspan="2"></td>
    </tr>
    <tr>
        <td align="right"></td>
        <td align="center">
</f:verbatim>
       <h:commandButton  onclick="return forsubmit(document.forms(0))" styleClass="button01" value="#{user_loginBB.loginButton}"
                    action="#{user_loginBB.resumeLogin}" tabindex="3"/>
       <h:outputText value="                "></h:outputText>
      <h:commandButton styleClass="button01" value="注册" action="#{user_loginBB.registe}" tabindex="3"/>
<f:verbatim>
       </td>
        <td width="54" rowspan="2"></td>
    </tr>
   	<tr>
    	<td ></td>
    	<td align="right">
	</td>
    </tr>
    </table>
	<table   id=bottom style='POSITION: absolute;' width='99%' cellspacing=0 cellpadding=0 border=0>
    <tr>
     <td align="right">
         <script type="text/javascript">
            document.write("本系统自动适应分辨率，您现在的分辨率是:"+screen.width+"*"+screen.height);
         </script>
     </td>
    <tr>

    <tr>
    <td align="right">
      <%
          out.println(CommonFuns.filterNull(Constants.COMPANY_NAME));
      %>
    </td>
    <tr>
    </table>
    <script type="text/javascript">
        var logintop=document.body.clientHeight/2*1-30;
        var loginleft=document.body.clientWidth /2*1;
        document.all("center").style.top=logintop;
        document.all("center").style.left=loginleft;

        logintop=document.body.clientHeight*0.86;
        document.all("bottom").style.top=logintop;
    </script>

</f:verbatim>
</h:form>

