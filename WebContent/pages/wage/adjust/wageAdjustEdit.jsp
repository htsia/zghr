<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	if(document.all('form1:beginDate').value==""){
		alert("����ʱ�䲻Ϊ��");
		return  false;
	}else{
		forsubmit(document.forms(0));
	} 	
}
</script>

<x:saveState value="#{wage_nomalAdjListBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{wage_nomalAdjListBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" н����� ->  ��������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��������"></h:outputText>
               <h:inputText value="#{wage_nomalAdjListBB.adjustbo.orgName}"></h:inputText>
               <h:outputText value="������Ա"></h:outputText>
               <h:inputText value="#{wage_nomalAdjListBB.adjustbo.personName}"></h:inputText>
              	<h:outputText value="����ʱ��"></h:outputText>
               <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{wage_nomalAdjListBB.adjustbo.adjCreateDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{wage_nomalAdjListBB.saveAdjust}"   styleClass="button01" onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

