<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="./include/taglib.jsp" %>
<script type="text/javascript">
    // �û�/���뷽ʽ
    function doLogin(){
        document.all("form1:loginMode").value="0";
        return forsubmit(document.forms(0));
    }
</script>

<h:form id="form1">
<f:verbatim>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
       <tr>
           <td  height='100%' width='100%' ><img alt="" src='../images/maininterface/login_backgroud.jpg' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>
       </tr>
    </table>

    <table id="center" style='POSITION: absolute;' cellspacing=0 cellpadding=0 border=0>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>�û���<br>LoginName</font></td>
        <td width=5></td>
        <td>
</f:verbatim>
           <h:inputText id="loginName" styleClass="inputDark" alt="�û���|0|s|50"
                         value="#{user_loginBB.loginName}"  tabindex="1"/>
<f:verbatim>
        </td>  
		<td width=5></td>
    </tr>
    <tr>
        <td align="right"  height="40"><font color=<%=Constants.LOGIN_FONT_COLOR%>>�ܡ���<br>Password</font></td>
        <td width=5></td>
        <td>
</f:verbatim>
        <h:inputSecret id="password" styleClass="inputDark" alt="����|0|s|50"     value="#{user_loginBB.password}"  tabindex="2"/>
<f:verbatim>
       </td>
	    <td valign="middle" align="center">
</f:verbatim>
            <h:inputHidden id="loginMode" value="#{user_loginBB.loginMode}"></h:inputHidden>
            <h:commandButton  onclick="return doLogin();" styleClass="button01" value="#{user_loginBB.loginButton}"
                    action="#{user_loginBB.login}" tabindex="3"/>
<f:verbatim>
        </td>
    </tr>
    <%
       if ("1".equals(Constants.ENABLE_LOGINCARD)){
    %>
    <tr>
        <td  align="right" ><font color=<%=Constants.LOGIN_FONT_COLOR%>>��֤��ʽ<br>Verify By</font></td>
        <td width=5></td>
        <td>
            <INPUT type="radio" ID="Radio1" VALUE="Radio1" CHECKED NAME="RadioGroup"><font color=<%=Constants.LOGIN_FONT_COLOR%>>����ģʽ(Password)</font>
            <!-- �޸Ŀ�ʼ2 -->
			<!-- <INPUT type="radio" ID="Radio2" VALUE="Radio2"   NAME="RadioGroup" onclick="window.location.href='/LoginByCardI.jsf'"><font color=<%=Constants.LOGIN_FONT_COLOR%>>I����ݿ�(ID Card)</font> -->
			<!-- �޸Ľ���2 -->
		</td>
		<td width=5></td>
    </tr>
    <%
        }
    %>
    </table>

    <table   id=bottom style='POSITION: absolute;' width='99%' cellspacing=0 cellpadding=0 border=0>
    <tr>
     <td align="right"><font color="black">
         <script type="text/javascript">
            document.write("��Ļ�ֱ���(Screen Resolution):"+screen.width+"*"+screen.height+"<br>");
            document.write("�����(Browser):"+judgeBrowser());
         </script>
</f:verbatim>
            <h:outputText  value="   ��Ʒ�汾(Version):#{run_SystemInfoBackingBean.buildInfo}" />
            <h:outputText  value="   ���ݿ�(Database):#{run_SystemInfoBackingBean.dbType}(#{run_SystemInfoBackingBean.updateNo})" />
<f:verbatim>
           </font>
     </td>
    <tr>

    <tr>
    <td align="right">
</f:verbatim>
            <h:outputText  value="   ��Ȩ���:#{run_SystemInfoBackingBean.powerInfo}" rendered="#{run_SystemInfoBackingBean.powerInfo!=''}"/>
<f:verbatim>
    </td>
    <tr>
    </table>
    <script type="text/javascript">
//<!-- �޸Ŀ�ʼ1 -->
		function setpos(){
			var logintop=document.body.clientHeight/5*2+10;
			var loginleft=document.body.clientWidth /3*2-20;
			document.all("center").style.top=logintop;
			document.all("center").style.left=loginleft;

			logintop=document.body.clientHeight*0.86;
			document.all("bottom").style.top=logintop;
		}
		setpos();

		window.onresize=setpos;
		document.all("form1:loginName").focus();
		
//<!-- �޸Ľ���1 -->
    </script>

</f:verbatim>
</h:form>
