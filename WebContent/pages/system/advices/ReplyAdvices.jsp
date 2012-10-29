<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{self_advicesEditBB}"/>
	<h:form id="BulletinEditForm">
      <h:inputHidden  value="#{self_advicesEditBB.initReply }"/>        
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="�ظ�����"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid border="1" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="��������" />
            <h:outputText value="#{self_advicesEditBB.advbo.advSenddate}" />

            <h:outputText value="������" />
            <h:outputText value="#{self_advicesEditBB.advbo.advSendName}" />

			<h:outputText value="��������" />
            <h:outputText value="#{self_advicesEditBB.advbo.advOrgName}" />

            <h:outputText value="����" />
			<h:outputText  value="#{self_advicesEditBB.advbo.advSubject}" />

			<h:outputText value="����" />
            <h:inputTextarea rows="10" cols="80" readonly="true"
                value="#{self_advicesEditBB.advbo.advContent}">
            </h:inputTextarea>

            <h:outputText value="�ظ�" />
            <h:inputTextarea id="textarea" rows="10" cols="80"
                value="#{self_advicesEditBB.advbo.advReplyContent}">
            </h:inputTextarea>

		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:commandButton value="�ظ�" action="#{self_advicesEditBB.replyAdvices}" styleClass="button01" />
			<h:commandButton value="����" onclick="window.close();" type="button" styleClass="button01" />
		</h:panelGrid>
	</h:form>


