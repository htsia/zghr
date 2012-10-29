<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
</script>

<x:saveState value="#{ResumeManageRecuitBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{ResumeManageRecuitBB.initA837}"></h:inputHidden>
      <h:inputHidden id="subid" value="#{ResumeManageRecuitBB.subid}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" �������� ->������������༭ "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                <h:outputText value="��Ŀ"></h:outputText>
                <h:inputText value="#{ResumeManageRecuitBB.a837Bo.a837701}"></h:inputText>
                <h:outputText value="����������"></h:outputText>
                <h:inputText value="#{ResumeManageRecuitBB.a837Bo.a837702}"></h:inputText>
              	<h:outputText value="����ʱ��"></h:outputText>
                <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{ResumeManageRecuitBB.a837Bo.a837700}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
            	<h:outputText value="λ��"></h:outputText>
            	<h:inputText value="#{ResumeManageRecuitBB.a837Bo.a837704}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{ResumeManageRecuitBB.saveA837bo}"   styleClass="button01" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

