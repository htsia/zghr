<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function winCancelClose(){
        window.returnValue=false;
        window.close();
        return false;
    }
</script>
    <x:saveState value="#{user_userCardBB}"/>
    <h:form id="formUserInfoEdit" >
        <h:inputHidden id="pageInit" value="#{user_userCardBB.pageInit}"/>
        <h:inputHidden id="userId" value="#{user_userCardBB.userId}"></h:inputHidden>

        <c:verbatim>
        <table width="99%" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td class="td_title"><img src="/images/tips.gif" alt="">���Ŷ�̬���</td>
            </tr>
        </table>
        <br>

        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="40%" height="24" class="td_form01">��¼��</td>
                <td width="60%"  class="td_form02">
</c:verbatim>
                  <h:inputText id="loginName" value="#{user_userCardBB.loginName}" readonly="true" styleClass="input" alt="��¼��|0|s|30"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form01">����״̬</td>
                <td width="60%" colspan="2" class="td_form02">
            </c:verbatim>
                  <h:inputText value="#{user_userCardBB.cardStatus}" styleClass="input" />
            <c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form01">��ID</td>
                <td width="60%" colspan="2" class="td_form02">
            </c:verbatim>
                  <h:inputText value="#{user_userCardBB.cardId}" styleClass="input" />
            <c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form01">��½ģʽ</td>
                <td width="60%" colspan="2" class="td_form02">
            </c:verbatim>
                  <h:selectBooleanCheckbox value="#{user_userCardBB.modiMode}"></h:selectBooleanCheckbox>
                  <h:outputText value="�޸�Ϊ��̬����ģʽ"></h:outputText>
            <c:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="8" align="right">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
</c:verbatim>
                    <h:commandButton styleClass="button01" action="#{user_userCardBB.deployOTPCard}" value="����"></h:commandButton>
                    <h:commandButton styleClass="button01" value="����" onclick="return winCancelClose()"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>        
    </h:form>
