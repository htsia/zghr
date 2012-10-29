<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:personID").value==""||document.all("form1:personID").value==null){
		alert("请选择考核人员");
	}else{
		forsubmit(document.forms(0)); 
	}	
}
</script>
<x:saveState value="#{evaauitGroupMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaauitGroupMgrBB.initPersonEidt}"></h:inputHidden>
    <h:panelGrid columns="2" columnClasses="td_form01,td_form02">
        <h:outputText value="人员"></h:outputText>
        <h:panelGroup>
            <h:inputHidden  id="personID" value="#{evaauitGroupMgrBB.itembo.personId}" ></h:inputHidden>
            <h:inputTextarea value="#{evaauitGroupMgrBB.itembo.personName}" readonly="true" id="personName" rows="5" cols="50">
            </h:inputTextarea>
            <h:commandButton styleClass="button_select" value="" onclick="return fPopUpBackPerTreeDlg('');" action="#{evaauitGroupMgrBB.selPerson}"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="权重" rendered="#{evaauitGroupMgrBB.isPurview=='0'}"></h:outputText>
        <h:inputText value="#{evaauitGroupMgrBB.itembo.purview}" rendered="#{evaauitGroupMgrBB.isPurview=='0'}"></h:inputText>
         <h:outputText value="考核人员类别"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{evaauitGroupMgrBB.itembo.masterType}"
                             alt="考核人员类别|0|s|52||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </c:verbatim>
             </h:panelGroup>
    </h:panelGrid>
    
    <h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="保存" styleClass="button01" action="#{evaauitGroupMgrBB.savePerson}" onclick="javascript:return forSave()"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>