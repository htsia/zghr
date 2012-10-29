<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>


<x:saveState value="#{resumeworkinfoBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{resumeworkinfoBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="subid" value="#{resumeworkinfoBB.subid}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 简历管理 ->工作经历编辑 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="单位名称"></h:outputText>
              <h:inputText value="#{resumeworkinfoBB.workbo.a019015}"></h:inputText>
               <h:outputText value="从事工作"></h:outputText>
               <h:inputText value="#{resumeworkinfoBB.workbo.a019020}"></h:inputText>
              	<h:outputText value="进入时间"></h:outputText>
               <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{resumeworkinfoBB.workbo.a019005}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
            	<h:outputText value="离开时间"></h:outputText>
               		<h:panelGroup>
                	<h:inputText styleClass="input" id="endDate" value="#{resumeworkinfoBB.workbo.a019010}"
                             readonly="true" alt="结束日期|0|d|50||"/>
               		<c:verbatim>
                  	<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                	</c:verbatim>
            	</h:panelGroup>
            	<h:outputText value="证明人"></h:outputText>
               <h:inputText value="#{resumeworkinfoBB.workbo.a019025}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{resumeworkinfoBB.save}"   styleClass="button01" rendered="#{resumeworkinfoBB.method=='0'}"/>
              <h:commandButton value="保存" id="update" action="#{resumeworkinfoBB.update}"   styleClass="button01" rendered="#{resumeworkinfoBB.method=='1'}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

