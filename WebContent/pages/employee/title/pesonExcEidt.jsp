<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">

function chkData(){
	 if(confirm("确定要排除吗?")){
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
              <h:outputText value=" 人员管理 ->职称管理"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="人员姓名"></h:outputText>
               <h:inputText value="#{emptitledeptAduitmgrBB.itembo.personName}" readonly="true"></h:inputText>
               <h:outputText value="拟申报等级"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyLevel}"
                     alt="职称级别|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="申报专业"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="applyMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyMajor}"
                     alt="专业|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyMajor')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="申报资格"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{emptitledeptAduitmgrBB.itembo.applyTitle}"
                     alt="性别|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyTitle')" disabled="true"/>
               </h:panelGroup>
               <h:outputText value="排除原因"></h:outputText>
               <h:inputTextarea value="#{emptitledeptAduitmgrBB.itembo.excludeReson}" cols="50" rows="5" readonly="#{emptitledeptAduitmgrBB.edit=='false'}">
               </h:inputTextarea>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="排除" id="save" action="#{emptitledeptAduitmgrBB.extItem}"   styleClass="button01" onclick="javascript:return chkData()" rendered="#{emptitledeptAduitmgrBB.edit=='true'}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
