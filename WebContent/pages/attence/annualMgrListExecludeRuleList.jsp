<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{annualMgrListBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{annualMgrListBB.pageInit1}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���������ݼ���Ա�б�" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
							<h:panelGroup>
							<h:outputText value="��¼��:#{annualMgrListBB.mypage1.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{annualMgrListBB.mypage1.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{annualMgrListBB.mypage1.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="��ǰΪ��#{annualMgrListBB.mypage1.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{annualMgrListBB.first1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{annualMgrListBB.pre1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{annualMgrListBB.next1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{annualMgrListBB.last1}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
		<x:dataTable value="#{annualMgrListBB.lists1}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="���" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="����" />
				</c:facet>
				<h:outputText value="#{list.personName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="�ų�����" />
				</c:facet>
				<h:outputText value="#{list.modeName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="ԭ��" />
				</c:facet>
				<h:outputText value="#{list.cause}" />
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
