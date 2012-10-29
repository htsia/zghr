<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function sendCard(){
        var step="";
        var ret;
        try{
           var pass=document.all("formUserInfoEdit:password").value;
           if (pass==""){
               alert("请输入发卡密码!")
               return false;
           }
           var ePass=document.all('cardIApi');
           step="未找到卡";
           ePass.OpenDevice(1, "");
           var flag="12345678901234567890123456789012";
           step="读取标示出错";
           flag=ePass.GetStrProperty(0x0B,0,"");
           if (flag.indexOf("(11)")==-1){
              step="打开身份卡出错";
              ePass.OpenDevice(0, "");
           }
           step="发卡密码不对";
           ret=ePass.VerifyPIN(0x00000000,pass);
           step="发卡出错";
           ePass.OpenFile(0x00000020,2);
           var uid="",name="";
           uid=document.all("formUserInfoEdit:uuid").value;
           name=document.all("formUserInfoEdit:userId").value;
           ePass.Write(0x00,0,0,uid,uid.length);
           ePass.Write(0x00,0,40,name,name.length);
           ePass.CloseDevice();
       }
       catch(err){
           alert(step);
           return false;
       }
       return forsubmit(document.forms(0));
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
        window.returnValue=true;
        window.close();
        return true;
    }
</script>
    <x:saveState value="#{user_userCardBB}"/>
    <h:form id="formUserInfoEdit" >
        <c:verbatim>
            <OBJECT id="cardIApi" style="LEFT: 0px; TOP: 0px" height="0" width="0" classid="clsid:C7672410-309E-4318-8B34-016EE77D6B58" name="cardIApi" VIEWASTEXT>
            </OBJECT>
        </c:verbatim>
        <h:inputHidden id="pageInit" value="#{user_userCardBB.pageInit}"/>
        <h:inputHidden id="userId" value="#{user_userCardBB.userId}"></h:inputHidden>
        <h:inputHidden id="uuid" value="#{user_userCardBB.uuid}"></h:inputHidden>
        <c:verbatim>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td class="td_title"><img src="/images/tips.gif" alt="">发放I型身份卡</td>
                <td class="td_title" align="right">
                    <script type="text/javascript">
                        if (!installDrv()) {
                            document.write("<input type='button' class='button01' OnClick='return startInstall();' value='安装驱动'>");
                        }
                    </script>
                </td>
            </tr>
        </table>
        <br>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="40%" height="24" class="td_form01">登录名</td>
                <td width="60%"  class="td_form02">
</c:verbatim>
                  <h:inputText id="loginName" value="#{user_userCardBB.loginName}" readonly="true" styleClass="input" alt="登录名|0|s|30"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="40%" height="24" class="td_form01">发卡状态</td>
                <td width="60%" colspan="2" class="td_form02">
            </c:verbatim>
                  <h:inputText value="#{user_userCardBB.cardStatus}" styleClass="input" />
            <c:verbatim>
                </td>
            </tr>

              <tr>
                    <td width="40%" height="24" class="td_form01">发卡密码</td>
                    <td width="60%"  class="td_form02">
                </c:verbatim>
                      <h:inputSecret id="password" styleClass="inputDark" size="22"></h:inputSecret>
                <c:verbatim>
                    </td>
            </tr>

                    <tr>
                        <td width="40%" height="24" class="td_form01">登陆模式</td>
                        <td width="60%" colspan="2" class="td_form02">
                    </c:verbatim>
                          <h:selectBooleanCheckbox value="#{user_userCardBB.modiMode}"></h:selectBooleanCheckbox>
                          <h:outputText value="修改为身份卡模式"></h:outputText>
                    <c:verbatim>
                        </td>
                    </tr>

            <tr>
                <td height="10" colspan="2" align="right">
                </td>
            </tr>

            <tr>
                <td colspan="2" align="right">
</c:verbatim>
                    <h:commandButton styleClass="button01" onclick="return sendCard();" action="#{user_userCardBB.deployCard}" value="发卡"></h:commandButton>
                    <h:commandButton styleClass="button01" value="返回" onclick="return winCancelClose()"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>        
    </h:form>
