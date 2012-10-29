<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
	
</c:verbatim>
<script type="text/javascript">
   function selectItem(){
	   var reval=window.showModalDialog("/coalsafe/selStdSet.jsf", null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:no;resizable:yes;status:no;scroll:yes;");
	   if (reval != null && reval!="") {
         	var vars=reval.split(",");
           document.all("form1:taskStandard").value = vars[0];
         	document.all("form1:itemId").value = vars[1];
           return true;
         } else {
           return false;
        }
   }
</script>
<x:saveState value="#{coalOverseeMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{coalOverseeMgrBB.initEdit}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="违法人员"/>
            <h:panelGroup>
            	<h:inputText id="personName" value="#{coalOverseeMgrBB.amercebo.personName}" />
            	<h:inputHidden value="#{coalOverseeMgrBB.amercebo.personId}"></h:inputHidden>
               <h:commandButton styleClass="button_select" value="" onclick="return fPopUpBackPerTreeDlg('');" action="#{coalOverseeMgrBB.selPerson}" />
            </h:panelGroup>
            <h:outputText value="违法时间"/>
            <h:panelGroup>
            	<h:inputText id="operateTime" value="#{coalOverseeMgrBB.amercebo.operateTime}" readonly="true"></h:inputText>
            	<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',el:'form1:operateTime'})"></h:commandButton>
            </h:panelGroup>
            <h:outputText value="违法地点"/>
            <h:inputText id="address" value="#{coalOverseeMgrBB.amercebo.address}" />
            <h:outputText value="违法操作"/>
            <h:panelGroup>
            	<h:inputText id="taskStandard" value="#{coalOverseeMgrBB.amercebo.itemName}" />
            	<h:inputHidden id="itemId" value="#{coalOverseeMgrBB.amercebo.itemId}"></h:inputHidden>
            	<h:commandButton type="button" styleClass="button_select" onclick="selectItem()"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{coalOverseeMgrBB.saveAmerce}"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
