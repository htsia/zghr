<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{getRecuitNoticeBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{getRecuitNoticeBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="noticeid" value="#{getRecuitNoticeBB.noticeId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 招聘管理 -> 通知通告管理" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="98%" align="left" >
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="发送者"></h:outputText>
			<h:inputText id="bookName" value="#{getRecuitNoticeBB.noticebo.senderName}"></h:inputText>

			<h:outputText value="内容"></h:outputText>
			<h:inputTextarea value="#{getRecuitNoticeBB.noticebo.content}" cols="60" rows="5"></h:inputTextarea>

		</h:panelGrid>
		<h:panelGrid align="right">
              <h:commandButton value="已读" id="save" action="#{getRecuitNoticeBB.read}" styleClass="button01"/>
           </h:panelGrid>
	</h:panelGrid>

</h:form>
