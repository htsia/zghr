<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="./include/taglib.jsp" %>

    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
        String loginName = CommonFuns.filterNull((String)session.getAttribute(Constants.USER_LOGINNAME));
    %>

<x:saveState value="#{user_upPasswordBB}"/>
<h:form id="formModifyPassword">
     <c:verbatim>
     <table  width=100%>
     <tr><td class=td_title>
     </c:verbatim>
             <h:graphicImage value="/images/tips.gif" />
             <h:outputText value="修改密码"/>
    <c:verbatim>
    </td></tr>

    <tr>
    <td height="300" valign="middle">
        <table width="300" align="center" >
            <tr><td colspan="2">
                系统要求你修改自己的密码，请输入两遍，然后点保存    
            </td></tr>

            <tr>
             <td>登录名</td>
             <td>
             <%=loginName%>
           </td></tr>

           <tr>
            <td>新密码</td>
            <td>
    </c:verbatim>
            <h:inputSecret value="#{user_loginBB.newPassword}" alt="新密码|0|s|50" styleClass="input"/>
    <c:verbatim>
           </td></tr>

           <tr>
           <td>确认密码</td>
           <td>
    </c:verbatim>
            <h:inputSecret value="#{user_loginBB.confirmPassword}" alt="确认密码|0|s|50" styleClass="input"/>
    <c:verbatim>
           </td></tr>

           <tr><td align="right" colspan="2">
    </c:verbatim>
                <h:commandButton value=" 保存 " onclick="return forsubmit(document.forms(0))" action="#{user_loginBB.loginUpdatePassword}" styleClass="button01">
                </h:commandButton>
    <c:verbatim>
        </td></tr>
        </table>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>