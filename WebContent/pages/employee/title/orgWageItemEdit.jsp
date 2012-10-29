<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{empTitleChangeBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{empTitleChangeBB.initOrgWageItemEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ա���� -> н�ʹ����趨 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="ָ������"></h:outputText>
               <h:inputText value="#{empTitleChangeBB.orgTitleWagebo.wageItemDes}" readonly="true"></h:inputText>
               <h:outputText value="����"></h:outputText>
               <h:selectOneRadio value="#{empTitleChangeBB.orgTitleWagebo.wageType}">
               		<c:selectItem itemLabel="����" itemValue="1"/>
               		<c:selectItem itemLabel="��ʽ" itemValue="2"/>
               		<c:selectItem itemLabel="�׸ļ���" itemValue="9"/>
               </h:selectOneRadio>
               <h:outputText value="˳��"></h:outputText>
               <h:inputText value="#{empTitleChangeBB.orgTitleWagebo.wageOrder}" readonly="true"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{empTitleChangeBB.saveOrgWageItem}"   styleClass="button01" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
