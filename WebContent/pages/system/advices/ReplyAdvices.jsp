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
                <h:outputText value="回复建议"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid border="1" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="发送日期" />
            <h:outputText value="#{self_advicesEditBB.advbo.advSenddate}" />

            <h:outputText value="发送人" />
            <h:outputText value="#{self_advicesEditBB.advbo.advSendName}" />

			<h:outputText value="欲发机构" />
            <h:outputText value="#{self_advicesEditBB.advbo.advOrgName}" />

            <h:outputText value="标题" />
			<h:outputText  value="#{self_advicesEditBB.advbo.advSubject}" />

			<h:outputText value="内容" />
            <h:inputTextarea rows="10" cols="80" readonly="true"
                value="#{self_advicesEditBB.advbo.advContent}">
            </h:inputTextarea>

            <h:outputText value="回复" />
            <h:inputTextarea id="textarea" rows="10" cols="80"
                value="#{self_advicesEditBB.advbo.advReplyContent}">
            </h:inputTextarea>

		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:commandButton value="回复" action="#{self_advicesEditBB.replyAdvices}" styleClass="button01" />
			<h:commandButton value="返回" onclick="window.close();" type="button" styleClass="button01" />
		</h:panelGrid>
	</h:form>


