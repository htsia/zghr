<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>

<script type="text/javascript">
    function forCheck() {
        
        if (document.all('form1:time').value==null || document.all('form1:time').value=="") {
            alert("请填写报到时间!");
            return false;
        }
        if (document.all('form1:address').value==null || document.all('form1:address').value=="") {
            alert("请填写报到地点!");
            return false;
        }
       if(document.all('form1:textarea').value==null || document.all('form1:textarea').value==""){
        	
        	alert("请点击通知内容框来获取内容!");
        	return false;
        }
       	showProcessBar();
        return true;
    }
    function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	 }
</script>
    <x:saveState value="#{recu_registerManageBB}"/>
	<h:form id="form1" >
		 
	  <h:inputHidden value="#{recu_registerManageBB.initReportSendInfo}"/>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="招聘管理>>发送报到通知"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
		
		<h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="报到时间"></h:outputText>
               <h:inputText id="time" value="#{recu_registerManageBB.time}"  size="50" maxlength="50"></h:inputText>              
               
               <h:outputText value="报到地址"></h:outputText>
               <h:inputText id="address" value="#{recu_registerManageBB.address}" size="50" maxlength="50"></h:inputText>
               
               <h:outputText value="通知报到内容"></h:outputText>
               <h:inputTextarea id="textarea" readonly="true" value="#{recu_registerManageBB.content}"  rows="10" cols="50"></h:inputTextarea>
           </h:panelGrid>
           <f:verbatim>
            <br>
        </f:verbatim>
           <h:panelGrid columns="2"  width="20%" align="center">
              <h:commandButton value="发送" id="save" onfocus="return forCheck();"  action="#{recu_registerManageBB.sendReportInfo}"  styleClass="button01"/>
              <h:commandButton value="返回" action="sys_newslist" styleClass="button01" />
          
           </h:panelGrid>
      </h:panelGrid>
       <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
	</h:form>


