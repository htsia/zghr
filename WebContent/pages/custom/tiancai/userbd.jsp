<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<x:saveState value="#{tiancaiBB}" />
<h:form id="form1">
	<h:inputHidden value="#{tiancaiBB.userbdInit}"/>
	<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">财务中间库 -> 人员变动查询</td>
        </tr>
    </table>
    </c:verbatim>
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
			
		<x:dataTable value="#{tiancaiBB.userbdList1}"
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
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{user.user_code}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{user.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{user.user_code}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工类别" />
				</f:facet>
				<h:outputText value="#{user.user_type}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="原机构" />
				</f:facet>
				<h:outputText value="#{user.old_dept_id}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="新机构" />
				</f:facet>
				<h:outputText value="#{user.new_dept_id}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="变动类型" />
				</f:facet>
				<h:outputText value="#{user.change_type}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="变动时间" />
				</f:facet>
				<h:outputText value="#{user.change_date}"></h:outputText>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
