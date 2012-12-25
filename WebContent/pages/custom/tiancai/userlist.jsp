<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<x:saveState value="#{tiancaiBB}" />
<h:form id="form1">
	<h:inputHidden value="#{tiancaiBB.userInit}"/>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid align="right">
			<h:panelGroup>
				<h:outputText
					value="记录数:#{tiancaiBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{tiancaiBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{tiancaiBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{tiancaiBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{tiancaiBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{tiancaiBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{tiancaiBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{tiancaiBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
			
		<x:dataTable value="#{tiancaiBB.userList1}"
			headerClass="td_top" rowIndexVar="index" var="user" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="序号" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所在部门" />
				</f:facet>
				<h:outputText value="#{user.a001705}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{user.a001001}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{user.a001735}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人员类别" />
				</f:facet>
				<h:outputText value="#{user.a001054}"></h:outputText>
			</h:column>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="姓名简拼" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001002}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="姓名全拼" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001241}"></h:outputText> --%>
<%-- 			</h:column> --%>
			<h:column>
				<f:facet name="header">
					<h:outputText value="公民身份号码" />
				</f:facet>
				<h:outputText value="#{user.a001077}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="性别" />
				</f:facet>
				<h:outputText value="#{user.a001007}"></h:outputText>
			</h:column>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="年龄" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001206}"></h:outputText> --%>
<%-- 			</h:column> --%>
			<h:column>
				<f:facet name="header">
					<h:outputText value="民族" />
				</f:facet>
				<h:outputText value="#{user.a001021}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="入校时间" />
				</f:facet>
				<h:outputText value="#{user.a001044}"></h:outputText>
			</h:column>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="oa账户名" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001230}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="财务系统编号" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001245}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="出生日期" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001011}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="校龄" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.A001225}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="参加工作时间" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.A001041}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="工龄" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001215}"></h:outputText> --%>
<%-- 			</h:column> --%>
<%-- 			<h:column> --%>
<%-- 				<f:facet name="header"> --%>
<%-- 					<h:outputText value="档案编号" /> --%>
<%-- 				</f:facet> --%>
<%-- 				<h:outputText value="#{user.a001229}"></h:outputText> --%>
<%-- 			</h:column> --%>
		</x:dataTable>
	</h:panelGrid>
</h:form>
