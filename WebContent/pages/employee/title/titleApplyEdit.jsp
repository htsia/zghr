<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <x:saveState value="#{emptitleapplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{emptitleapplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ְ�ƹ��� -> �걨����"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="���"></h:outputText>
               <h:inputText  value="#{emptitleapplyBB.emptitleapplybo.year}"></h:inputText>
			
                <h:outputText value="��ʼ����"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{emptitleapplyBB.emptitleapplybo.beginDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="��������"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{emptitleapplyBB.emptitleapplybo.endDate}"
                             readonly="true" alt="��������|0|d|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                </c:verbatim>
            </h:panelGroup>
               
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{emptitleapplyBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
