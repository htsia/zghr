<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>


    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>    
    <script type="text/javascript">
       function fPopUpRoleInfoDlg(){
            showx = event.screenX - event.offsetX - 250;
            showy = event.screenY - event.offsetY + 18;
            retval = window.showModalDialog("/pages/user/SelRoleList.jsp", "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                document.forms[0]["formUserManager:selRoleId"].value = retval;
                return true;
            }
            return false;
        }

        function winCancelClose(){
            window.returnValue=false;
            window.close();
            return false;
        }

        function winOKClose(){
            window.returnValue=true;
            window.close();
            return true;
        }
    </script>

    <x:saveState value="#{user_userInfoBB}"/>
    <h:form id="formUserInfoEdit" >
        <h:inputHidden id="pageInit" value="#{user_userInfoBB.modiLevel}"/>
        <h:inputHidden id="userId" value="#{user_userInfoBB.userId}"></h:inputHidden>

        <c:verbatim>
        <table width="100%" border="0" cellspacing="6" cellpadding="0" align="center">
            <tr>
                <td class="td_title">�޸�����Ȩ��</td>
            </tr>
        </table>

        <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
                <td width="40%" height="24" class="td_form01">������Ϣ�鿴����</td>
                <td width="60%" colspan="2" class="td_form02">
       </c:verbatim>
                    <h:selectOneMenu value="#{user_userInfoBB.infoLevel}">
                        <c:selectItems value="#{user_userInfoBB.selfLevel}"></c:selectItems>
                    </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
</c:verbatim>
                    <h:commandButton styleClass="button01" onclick="return forsubmit(document.forms(0))" action="#{user_userInfoBB.updateUserInfoLevel}" value="����"></h:commandButton>
                    <h:commandButton styleClass="button01" value="����" onclick="return winCancelClose()"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>        
    </h:form>

<script type="text/javascript">
    scrpt = "<%=request.getAttribute("closeScript")%>";
    if(scrpt=="OK"){
       winOKClose();
    }
 </script>
