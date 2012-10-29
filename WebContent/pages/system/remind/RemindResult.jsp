<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);

			%>
<f:verbatim>
	<link rel="stylesheet" type="text/css"		href="<%=request.getContextPath()%>/css/style.css" />
	<script language="javascript" 		src="<%=request.getContextPath()%>/js/check.js"></script>
	<script language="javascript" 		src="<%=request.getContextPath()%>/js/checkAll.js"></script>
	<script language="javascript" 		src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</f:verbatim>

<x:saveState value="#{run_RemindResultBackingBean}" />
<h:inputHidden value="#{run_RemindResultBackingBean.pageInit}" />
<h:form id="form1">
	<h:panelGrid width="90%" columns="1" align="center">
		<h:outputText value=" ��ѯ���ѽ���б�" style="width:100%" />

		<f:verbatim>
			<HR color="#6392C6" noShade width="99%" align="center">
		</f:verbatim>

		<h:commandButton value="�� ��"
			action="#{run_RemindResultBackingBean.doRemindResult}"
			styleClass="button01" />
		<h:outputText escape="false" value="��ҳ�б�" />
		<x:dataTable value="#{run_RemindResultBackingBean.remBriefList}"
			rowIndexVar="index" var="briefList" width="88%"
			columnClasses="left,left,left">
			<h:column>
				<f:facet name="header">
					<h:outputText value="���" />
				</f:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column rendered="false">
				<h:outputText escape="false" value="#{briefList.remId}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����б�" />
				</f:facet>

				<h:outputLink value="jjj">
					<h:outputText escape="false" value="#{briefList.remMsg}" />
				</h:outputLink>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
		<h:outputText escape="false" value="��ɫ�趨���������б�" />
		<x:dataTable value="#{run_RemindResultBackingBean.roleBriefList}"
			rowIndexVar="index" var="briefList" width="88%"
			columnClasses="center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="���" />
				</f:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column rendered="false">
				<h:outputText escape="false" value="#{briefList.remindId}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����б�" />
				</f:facet>

				<h:commandLink value="#{briefList.remindMsg}"
					action="#{run_RemindResultBackingBean.viewDetail}">
					<f:param name="run_remindid_detail" value="#{briefList.remindId}" />
					<f:param name="run_remindid_msg" value="#{briefList.remindMsg}" />		
				</h:commandLink>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
		<h:outputText escape="false" value="������Ŀ���������б�:" />
		<x:dataTable value="#{run_RemindResultBackingBean.remResultList}"
			rowIndexVar="index" var="resultList" width="88%"
			columnClasses="center">

			<h:column>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column rendered="false">
				<h:outputText escape="false" value="#{resultList.resultId}" />
			</h:column>
			<h:column>
				<h:outputText escape="false" value="#{resultList.remRslt}" />
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>

