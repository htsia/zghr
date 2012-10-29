<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{atttimeoffBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{atttimeoffBB.pageInit}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->������Ϣ�鿴" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="3" cellspacing="2" width="100%" align="center">
		<h:panelGroup>
			<h:outputText value="��¼��:#{atttimeoffBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{atttimeoffBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{atttimeoffBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{atttimeoffBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{atttimeoffBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{atttimeoffBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{atttimeoffBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{atttimeoffBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{atttimeoffBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:outputText value="#{list.personName}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="���ݿ�ʼʱ��" />
			</c:facet>
			<h:outputText value="#{list.beginTime}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="���ݽ���ʱ��" />
			</c:facet>
			<h:outputText value="#{list.endTime}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="��������" />
			</c:facet>
			<h:outputText value="#{list.lastDate}" />
		</h:column>
	</h:dataTable>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
