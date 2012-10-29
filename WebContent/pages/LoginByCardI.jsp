<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="./include/taglib.jsp" %>
<script type="text/javascript">
    function doLogin(){
        // 身份卡
        document.all("form1:loginMode").value="1";
        return forsubmit(document.forms(0));
    }
    //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }
    //XMLHttpRequest状态改变时要执行的函数
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
                //解析从xml文件得到的结果,动态画树
                parseResults();
            }
        }
    }

    //解析从xml文件得到的结果
    function parseResults() {
        var results = xmlHttp.responseXML;
        var person = null;
        var trees = results.getElementsByTagName("PersonInfo");
        for (var i = 0; i < trees.length; i++) {
            person = trees[i];
            document.all("form1:loginName").value = person.getElementsByTagName("name")[0].firstChild.nodeValue;
        }
    }
    
</script>

<h:form id="form1">
<f:verbatim>
    <object CLASSID="clsid:0272DA76-96FB-449E-8298-178876E0EA89"
        BORDER="0" VSPACE="0" HSPACE="0" ALIGN="TOP" HEIGHT="0" WIDTH="0"
        id="cardIApi" style="LEFT: 0px; TOP: 0px"
        name="cardIApi" VIEWASTEXT>
    </object>

    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
       <tr>
           <td  height='100%' width='100%' ><img alt="" src='../images/maininterface/login_backgroud.jpg' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>
       </tr>
    </table>

    <table   id="center" style='POSITION: absolute;' width='300' cellspacing=0 cellpadding=0 border=0>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;用户名：</font></td>
        <td>
</f:verbatim>
             <h:inputHidden id="loginID"  value="#{user_loginBB.cardID}"/>
             <h:inputHidden id="loginMode" value="#{user_loginBB.loginMode}"></h:inputHidden>
             <h:inputText id="loginName" styleClass="inputDark" alt="用户名|0|s|50" size="22" readonly="true" tabindex="1"/>
<f:verbatim>
        </td>
        <td width="54" rowspan="2">
</f:verbatim>
            <h:commandButton  onclick="return doLogin();" styleClass="button01" value="#{user_loginBB.loginButton}"
                    action="#{user_loginBB.login}" tabindex="3"/>
<f:verbatim>
            <br>
            <input type="button" class="button01" id="insDrv" onclick="return startInstall();" value='安装插件' style="display:none">
        </td>
    </tr>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;密　码：</font></td>
        <td>
</f:verbatim>
        <h:inputSecret id="password" styleClass="inputDark" alt="密码|0|s|50"     value="#{user_loginBB.password}" size="22" tabindex="2"/>
<f:verbatim>
       </td>
    </tr>
    <tr>
        <td align="left" ><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;验证方式：</font></td>
        <td colspan="2">
            <INPUT type="radio" ID="Radio1" VALUE="Radio1" CHECKED NAME="RadioGroup"><font color=<%=Constants.LOGIN_FONT_COLOR%>>I型身份卡</font>
            <INPUT type="radio" ID="Radio2" VALUE="Radio2"   NAME="RadioGroup" onclick="window.location.href='/Login.jsf'"><font color=<%=Constants.LOGIN_FONT_COLOR%>>用户密码模式</font>
        </td>
    </tr>
    </table>

    <table   id=bottom style='POSITION: absolute;' width='99%' cellspacing=0 cellpadding=0 border=0>
    <tr>
     <td align="right">
         <script type="text/javascript">
            document.write("本系统自动适应分辨率，您现在的分辨率是:"+screen.width+"*"+screen.height+"<br>");
            document.write("您的浏览器:"+judgeBrowser());
         </script>
</f:verbatim>
            <h:outputText  value="   产品版本:#{run_SystemInfoBackingBean.buildInfo}" />
            <h:outputText  value="   数据库:#{run_SystemInfoBackingBean.dbType}(#{run_SystemInfoBackingBean.updateNo})" />
<f:verbatim>
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
</f:verbatim>
</h:form>

<script type="text/javascript">
    var logintop=document.body.clientHeight/3*2;
    var loginleft=document.body.clientWidth /3*2;
    document.all("center").style.top=logintop;
    document.all("center").style.left=loginleft;

    logintop=document.body.clientHeight*0.86;
    document.all("bottom").style.top=logintop;
    //debugger;
    try{
        if (installDrv()){
            var ePass=document.all('cardIApi');
            ePass.OpenDevice(1, "");
            var flag="12345678901234567890123456789012";
            flag=ePass.GetStrProperty(0x0B,0,"");
            if (flag.indexOf("(11)")==-1){
               ePass.OpenDevice(0, "");
            }
            ePass.OpenFile(0x00000010,2);
            var uid="",name="";
            uid=ePass.Read(0,0,0,40);
            userid=ePass.Read(0,0,40,60);
            document.all('form1:loginID').value=uid;
            ePass.CloseDevice();

            createXMLHttpRequest();
            xmlHttp.open("GET", "/pages/ajax/getUserInfo.jsp?UserID="+userid, true);
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.send(null);
        }
        else{
           document.all("form1:loginName").value="请先安装插件";
           document.all("insDrv").style.display="block";
        }
    }
    catch(err){
         document.all("form1:loginName").value="请插入卡";
    }
</script>

