<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <x:saveState value="#{resumeImportTemBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{resumeImportTemBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ƹ���� -> ����ģ�涨��"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="ģ������"></h:outputText>
               <h:inputText id="placeName" value="#{resumeImportTemBB.tempbo.templateName}"></h:inputText>
			
               <h:outputText value="�Ƿ�����"></h:outputText>
               <h:selectOneMenu value="#{resumeImportTemBB.tempbo.isUse}">
                     <c:selectItem itemLabel="����" itemValue="0"/>
                     <c:selectItem itemLabel="����" itemValue="1"/>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{resumeImportTemBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
