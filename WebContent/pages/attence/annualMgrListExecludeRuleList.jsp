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
			<h:outputText value="不符合年休假人员列表" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
							<h:panelGroup>
							<h:outputText value="记录数:#{annualMgrListBB.mypage1.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{annualMgrListBB.mypage1.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{annualMgrListBB.mypage1.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{annualMgrListBB.mypage1.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{annualMgrListBB.first1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{annualMgrListBB.pre1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{annualMgrListBB.next1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{annualMgrListBB.last1}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
		<x:dataTable value="#{annualMgrListBB.lists1}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="序号" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="姓名" />
				</c:facet>
				<h:outputText value="#{list.personName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="排除类型" />
				</c:facet>
				<h:outputText value="#{list.modeName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="原因" />
				</c:facet>
				<h:outputText value="#{list.cause}" />
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
