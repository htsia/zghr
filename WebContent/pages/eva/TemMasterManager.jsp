<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <script type="text/javascript">
 function addTemMaster() {
	 if(document.all("form1:needCount").value==""){
		 alert("新增人数不能为空！");
		 return false;
	 }
     var reval = window.showModalDialog("/eva/PersonQuery3.jsf?planID="+document.all('form1:planID').value, null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
	 if (reval != null && reval!="") {
         var vars=reval.split("|");
         document.all("form1:personStr").value = vars[1];
         return true;
     } else {
         return false;
     }
}
 function modifyPassword(id){
     window.showModalDialog("/eva/TempMasterPasswordEdit.jsf?masterid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
     return false;
  }
 </script>
<x:saveState value="#{eva_tmpMasterManagerBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_tmpMasterManagerBB.pageInit}"/>
	<h:inputHidden id="planID" value="#{eva_tmpMasterManagerBB.planID}"/>
	<h:inputHidden id="personStr" value=""/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 ->临时主体管理"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">

        <h:panelGrid columns="1" align="right">
            <h:panelGroup>
                <h:outputText value="新增人数     "></h:outputText>
                <h:inputText id="needCount" value="#{eva_tmpMasterManagerBB.needCount}"></h:inputText>
                <h:outputText value="      "></h:outputText>
                <h:commandButton value="增加"  onclick="return addTemMaster()" styleClass="button01" action="#{eva_tmpMasterManagerBB.addPerson}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:dataTable value="#{eva_tmpMasterManagerBB.evaTempMasterList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="考核主体名称"/></c:facet>
            <h:outputText value="#{list.masterPName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="所属考核计划"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="是否启用"/></c:facet>
            <h:outputText value="#{list.isUseDesp}"/>
        </h:column>
		<h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="修改密码" onclick="return modifyPassword('#{list.masterID}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="删除" styleClass="button01" action="#{eva_tmpMasterManagerBB.deleteMaster}">
                    <x:updateActionListener property="#{eva_tmpMasterManagerBB.masterID}" value="#{list.masterID}"/>
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>