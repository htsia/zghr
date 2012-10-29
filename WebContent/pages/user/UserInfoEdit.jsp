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
        <h:inputHidden id="pageInit" value="#{user_userInfoBB.pageInit}"/>
        <h:inputHidden id="userId" value="#{user_userInfoBB.userId}"></h:inputHidden>
        <c:verbatim>
        <table width="100%" border="0" cellspacing="6" cellpadding="0" align="center">
            <tr>
                <td class="td_title">用户基本信息管理</td>
            </tr>
        </table>
        </c:verbatim>

        <c:verbatim>
        <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
                <td width="40%" height="24" class="td_form02">登录名</td>
                <td width="60%" colspan="2" class="td_form02">
        </c:verbatim>
                  <h:inputText value="#{user_userInfoBB.loginName}" readonly="#{!sys_commonInfoBB.enableModiPass}" styleClass="input" alt="登录名|0|s|30"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form02">昵称</td>
                <td width="60%" colspan="2" class="td_form02">
</c:verbatim>
                   <h:inputText value="#{user_userInfoBB.nickName}" styleClass="input" alt="昵称|0|s|30"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form02">自助信息查看级别</td>
                <td width="60%" colspan="2" class="td_form02">
</c:verbatim>
                    <h:selectOneMenu value="#{user_userInfoBB.infoLevel}">
                        <c:selectItems value="#{user_userInfoBB.selfLevel}"></c:selectItems>
                    </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
    
    <tr>
        <td width="40%" height="24" class="td_form02">
</c:verbatim>
        <h:outputText value="登录验证模式" rendered="#{user_userInfoBB.canModiType}"></h:outputText>
<c:verbatim>            
        </td>
        <td width="60%" colspan="2" class="td_form02">
</c:verbatim>
            <h:selectOneMenu value="#{user_userInfoBB.loginType}" rendered="#{user_userInfoBB.canModiType}">
                <c:selectItem itemValue="0" itemLabel="密码模式"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="I型身份卡"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="动态口令"></c:selectItem>
            </h:selectOneMenu>
<c:verbatim>
        </td>
    </tr>

            <tr>
                <td colspan="4" align="right">
</c:verbatim>
                    <h:commandButton styleClass="button01" onclick="return forsubmit(document.forms(0))" action="#{user_userInfoBB.updateUserInfo}" value="保存"></h:commandButton>
                    <h:commandButton styleClass="button01" value="返回" onclick="return winCancelClose()"></h:commandButton>
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

