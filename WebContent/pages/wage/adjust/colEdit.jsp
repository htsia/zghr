<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:seq").value==""||document.all("form1:seq").value==null){
		alert("¼���������ݣ�");
		return false;
	}
	if(document.all("form1:title").value==""||document.all("form1:title").value==null){
		alert("¼���������ݣ�");
		return false;
	}
	if(document.all("form1:lowValue").value==""||document.all("form1:lowValue").value==null){
		alert("¼���������ݣ�");
		return false;
	}
	if(document.all("form1:highValue").value==""||document.all("form1:highValue").value==null){
		alert("¼���������ݣ�");
		return false;
	}
	
	forsubmit(document.forms(0)); 	
}
</script>

<x:saveState value="#{wageReformMgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{wageReformMgrBB.initColEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" �����׸� ->�׸��������� "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           	   <h:outputText value="���"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.colBo.seq}" id="seq"></h:inputText>
				<h:outputText value="��ʾ����"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.colBo.title}" id="title"></h:inputText>
               <h:outputText value="����"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.colBo.lowValue}" id="lowValue"></h:inputText>
               <h:outputText value="����"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.colBo.highValue}" id="highValue"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{wageReformMgrBB.save}"   styleClass="button01" onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
