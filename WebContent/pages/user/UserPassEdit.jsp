<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>


    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>    

<script type="text/javascript">
    function doCheck(){
        if (document.all("formUserInfoEdit:pwd").value==null || document.all("formUserInfoEdit:pwd").value==""){
            alert("请输入密码");
            return false;
        }
        if (document.all("formUserInfoEdit:pwd").value!=document.all("formUserInfoEdit:pwd2").value){
            alert("两次输入密码不一致");
            return false;
        }
        return true;
    }
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
        alert("修改完成！")
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
                <td class="td_title">用户密码管理</td>
            </tr>
        </table>

        <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
                <td width="40%" height="24" class="td_form01">登录名</td>
                <td width="60%" colspan="2" class="td_form02">
         </c:verbatim>
                   <h:inputText readonly="true" value="#{user_userInfoBB.loginName}" styleClass="input" alt="登录名|0|s|30"/>
         <c:verbatim>
                </td>
            </tr>
            <tr>
                <td width="40%" height="24" class="td_form01">输入密码</td>
                <td width="60%" class="td_form02">
         </c:verbatim>
                <h:inputSecret id="pwd" value="#{user_userInfoBB.loginPwd}" styleClass="input"
                                                                 alt="密码|0|s|30"/>
         <c:verbatim>
                </td>
            </tr>
            <tr>
                <td width="40%" height="24" class="td_form01">再次输入密码</td>
                <td width="60%" class="td_form02">
         </c:verbatim>
                   <h:inputSecret id="pwd2"  styleClass="input"  alt="密码|0|s|30"/>
         <c:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
         </c:verbatim>
                    <h:commandButton styleClass="button01" onclick="return doCheck();" action="#{user_userInfoBB.updateUserInfo}" value="保存"></h:commandButton>
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


