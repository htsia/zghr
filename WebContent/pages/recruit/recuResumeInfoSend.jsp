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
        var returnvlaue=true;
		if(document.all('form1:textarea').value==null || document.all('form1:textarea').value==""){
        	alert("请点击通知内容框来获取内容!");
        	returnvlaue=false;
        	return false;
        }
		if(document.all('form1:time').value==null || document.all('form1:time').value==""||document.all('form1:address').value==null || document.all('form1:address').value==""){
			if(!confirm("是否忽略时间和地址发送邮件")){
				returnvlaue=false;
			}else{
				returnvlaue=true;
			}
        }
        if(returnvlaue==true){
	    	showProcessBar();
	        return true;
        }else{
        	return false;
        }
    }
    function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	 }
</script>
    <x:saveState value="#{recu_resumeInfoBB}"/>
	<h:form id="form1" >
		 
	  <h:inputHidden value="#{recu_resumeInfoBB.initSendInfo}"/>
	  <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{recu_resumeInfoBB.getSendEmail}"></h:commandButton>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="招聘管理>>发送面试通知"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
		
		<h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="面试时间"></h:outputText>
               <h:inputText id="time"  value="#{recu_resumeInfoBB.time}" size="50" maxlength="50"></h:inputText>              
               
               <h:outputText value="面试地址"></h:outputText>
               <h:inputText id="address" value="#{recu_resumeInfoBB.address}" size="50" maxlength="50"></h:inputText>
               
               <h:outputText value="通知内容"></h:outputText>
               <h:inputTextarea id="textarea" readonly="true" value="#{recu_resumeInfoBB.content}"  rows="10" cols="50" onclick="document.all('form1:refresh').click();"></h:inputTextarea>
           </h:panelGrid>
           <f:verbatim>
            <br>
        </f:verbatim>
           <h:panelGrid columns="2"  width="20%" align="right">
              <h:commandButton value="发送" id="save" onclick="return forCheck();"   action="#{recu_resumeInfoBB.resumeEmailSuccess}"  styleClass="button01"/>
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


