<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:personID").value==""||document.all("form1:personID").value==null){
		alert("��ѡ�񿼺���Ա");
	}else{
		forsubmit(document.forms(0)); 
	}	
}
</script>
<x:saveState value="#{eva_objectBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_objectBB.addmaster}"></h:inputHidden>
    <h:inputHidden value="#{eva_objectBB.objectID}"></h:inputHidden>
        <h:inputHidden id="superId" value="#{eva_objectBB.orgId}"></h:inputHidden>
    <h:panelGrid columns="2" columnClasses="td_form01,td_form02">
        <h:outputText value="��Ա"></h:outputText>
        <h:panelGroup>
            <h:inputHidden  id="personID" value="#{eva_objectBB.masterbo.personID}" ></h:inputHidden>
            <h:inputTextarea readonly="true" id="personName" value="#{eva_objectBB.masterbo.personName}" rows="5" cols="40"></h:inputTextarea>
            <h:commandButton styleClass="button_select" value="" onclick="return fPopUpBackPerTreeDlg('');" action="#{eva_objectBB.selPerson}"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="Ȩ��" rendered="#{eva_objectBB.isPurview=='0'}"></h:outputText>
        <h:inputText value="#{eva_objectBB.masterbo.purview}" rendered="#{eva_objectBB.isPurview=='0'}"></h:inputText>
         <h:outputText value="������Ա���"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{eva_objectBB.masterbo.masterType}"
                             alt="������Ա���|0|s|52||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </c:verbatim>
             </h:panelGroup>
    </h:panelGrid>
    
    <h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="����" styleClass="button01" action="#{eva_objectBB.savemaster}" onclick="javascript:return forSave()"></h:commandButton>
            <h:commandButton value="����" onclick="window.close();" type="button" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>