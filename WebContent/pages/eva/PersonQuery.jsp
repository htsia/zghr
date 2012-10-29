<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:personID").value==""||document.all("form1:personID").value==null){
		alert("请选择人员");
		return false;
	}else if(document.all("form1:planMode").value=="0"){
		if(document.all("form1:templateID").value==""||document.all("form1:templateID").value==null){
			alert("请选择模板");
			return false;
		}
	}else{
		forsubmit(document.forms(0)); 
	}	
}
</script>
<x:saveState value="#{eva_objectBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_objectBB.initAdd}"></h:inputHidden>
    <h:inputHidden id="planMode" value="#{eva_objectBB.planMode}"></h:inputHidden>
    <h:panelGrid columns="2" columnClasses="td_form01,td_form02">
        <h:outputText value="姓名"></h:outputText>
        <h:panelGroup>
            <h:inputHidden  id="personID" value="#{eva_objectBB.personIds}" ></h:inputHidden>
            <h:inputTextarea value="#{eva_objectBB.personNames}" cols="60" rows="5">
            </h:inputTextarea>
            <h:commandButton styleClass="button_select" value="" onclick="return fPopUpBackPerTreeDlg('');" action="#{eva_objectBB.selPerson2}"></h:commandButton>
        </h:panelGroup>
        <h:outputText value="模板" rendered="#{eva_objectBB.planMode=='0'}"/>
        <h:selectOneMenu id="templateID" value="#{eva_objectBB.templateId}" rendered="#{eva_objectBB.planMode=='0'}">
              <c:selectItems value="#{eva_objectBB.templates}"></c:selectItems>
        </h:selectOneMenu>   
    </h:panelGrid>
    
    <h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="保存" styleClass="button01" action="#{eva_objectBB.saveAddPerson}" onclick="javascript:return forSave()"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>