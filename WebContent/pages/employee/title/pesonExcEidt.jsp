<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">

function chkData(){
	 if(confirm("ȷ��Ҫ�ų���?")){
     	return forsubmit(document.forms(0));
	 }
 }
</script>   


<x:saveState value="#{emptitledeptAduitmgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{emptitledeptAduitmgrBB.initExcEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ա���� ->ְ�ƹ���"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��Ա����"></h:outputText>
               <h:inputText value="#{emptitledeptAduitmgrBB.itembo.personName}" readonly="true"></h:inputText>
               <h:outputText value="���걨�ȼ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyLevel}"
                     alt="ְ�Ƽ���|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="�걨רҵ"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="applyMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyMajor}"
                     alt="רҵ|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyMajor')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="�걨�ʸ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyTitle}"
                     alt="�Ա�|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyTitle')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="�ų�ԭ��"></h:outputText>
               <h:inputTextarea value="#{emptitledeptAduitmgrBB.itembo.excludeReson}" cols="50" rows="5" readonly="#{emptitledeptAduitmgrBB.edit=='false'}">
               </h:inputTextarea>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="�ų�" id="save" action="#{emptitledeptAduitmgrBB.extItem}"   styleClass="button01" onclick="javascript:return chkData()" rendered="#{emptitledeptAduitmgrBB.edit=='true'}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
