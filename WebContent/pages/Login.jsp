<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="./include/taglib.jsp" %>
<script type="text/javascript">
    // 用户/密码方式
    function doLogin(){
    	var name=document.getElementById("form1:loginName").value;
    	if(name==''){
    		alert("请输入用户名");
    		return false;
    	}
    	var name=document.getElementById("form1:password").value;
    	if(name==''){
    		alert("请输入密码");
    		return false;
    	}
    	document.getElementById("form1:login").click();
    	return false;
    }
</script>

<h:form id="form1">
<f:verbatim>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
       <tr>
           <td  height='100%' width='100%' ><img alt="" src='../<%=CommonUtil.getSYS_INTERFACE()[0]%>' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>
       </tr>
    </table>

    <table id="center" style='POSITION: absolute;' cellspacing=0 cellpadding=0 border=0>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>用户名<br>LoginName</font></td>
        <td width=5></td>
        <td>
</f:verbatim>
           <h:inputText id="loginName" styleClass="inputDark" alt="用户名|0|s|50"
                         value="#{user_loginBB.loginName}"  tabindex="1"/>
<f:verbatim>
        </td>  
		<td width=5></td>
    </tr>
    <tr>
        <td align="right"  height="40"><font color=<%=Constants.LOGIN_FONT_COLOR%>>密　码<br>Password</font></td>
        <td width=5></td>
        <td>
</f:verbatim>
        <h:inputSecret id="password" styleClass="inputDark" alt="密码|1|s|50"     value="#{user_loginBB.password}"  tabindex="2"/>
<f:verbatim>
       </td>
	    <td valign="middle" align="center">
</f:verbatim>
            <h:commandButton onclick="return doLogin();" styleClass="button01" type="button" value="#{user_loginBB.loginButton}" tabindex="3"/>
            <h:commandButton id="login" style="display:none;" action="#{user_loginBB.login}"/>
<f:verbatim>
        </td>
    </tr>
    </table>

    <table   id=bottom style='POSITION: absolute;' width='99%' cellspacing=0 cellpadding=0 border=0>
    <tr>
     <td align="right"><font color="black">
         <script type="text/javascript">
            document.write("屏幕分辨率(Screen Resolution):"+screen.width+"*"+screen.height+"<br>");
            document.write("浏览器(Browser):"+judgeBrowser());
         </script>
</f:verbatim>
            <h:outputText  value="   产品版本(Version):#{run_SystemInfoBackingBean.buildInfo}" />
            <h:outputText  value="   数据库(Database):#{run_SystemInfoBackingBean.dbType}(#{run_SystemInfoBackingBean.updateNo})" />
<f:verbatim>
           </font>
     </td>
    <tr>
    </table>
    <script type="text/javascript">
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
    </script>

</f:verbatim>
</h:form>
