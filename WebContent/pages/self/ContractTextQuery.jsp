<%@ page contentType="text/html;charset=GBK" language="java" %>

<script language="javascript"	src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/Appclient.js"></script>

<%@ include file="/pages/include/taglib.jsp" %>

	<h:panelGrid width="75%" border="0" align="center">
		<h:panelGroup>
			<h:graphicImage  />
			<h:outputText value="�Ͷ���ͬ�ı�" style="font-weight:bold" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" align="center" width="95%"
		rendered="#{customerMagnifierBackingBean.flag}" cellpadding="3">
		<x:dataTable id="userdata" width="100%" align="center" border="1"
			value="#{customerMagnifierBackingBean.individualInfoList}"
			var="individualInfoList"
			rendered="#{customerMagnifierBackingBean.flag}"
			preserveDataModel="true" rows="10">
			<h:column>
				<f:facet name="header">
					<h:outputText value="���"></h:outputText>
				</f:facet>
				<h:outputText value="1" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ͬ���"></h:outputText>
				</f:facet>
				<h:outputText value="200323+01" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ͬ״̬"></h:outputText>
				</f:facet>
				<h:outputText value="��ǩ" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ͬ����"></h:outputText>
				</f:facet>
				<h:outputText value="�̶����޺�ͬ" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ʼʱ��"></h:outputText>
				</f:facet>
				<h:outputText value="1980-03-21" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��"></h:outputText>
				</f:facet>
				<h:outputText value="1985-03-01" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ժҪ"></h:outputText>
				</f:facet>
				<h:outputText value="" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�鿴��ͬ"></h:outputText>
				</f:facet>
				<h:outputLink value="http://www.ccb.cn" target="_new">
					<h:outputText value="�鿴" />
				</h:outputLink>
			</h:column>
		</x:dataTable>
	</h:panelGrid>

