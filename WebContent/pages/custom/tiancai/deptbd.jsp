<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<x:saveState value="#{tiancaiBB}" />
<h:form id="form1">
	<h:inputHidden value="#{tiancaiBB.deptbdInit}"/>
	<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">财务中间库 -> 机构变动查询</td>
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
			
		<x:dataTable value="#{tiancaiBB.deptbdList1}"
			headerClass="td_top" rowIndexVar="index" var="dept" id="dateList"
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
					<h:outputText value="机构名称" />
				</f:facet>
				<h:outputText value="#{dept.dept_name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="机构类别" />
				</f:facet>
				<h:outputText value="#{dept.dept_type}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="原主管机构" />
				</f:facet>
				<h:outputText value="#{dept.old_mainDeptID}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="新主管机构" />
				</f:facet>
				<h:outputText value="#{dept.new_mainDeptID}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="合并到机构" />
				</f:facet>
				<h:outputText value="#{dept.appendToDeptID}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="变动类型" />
				</f:facet>
				<h:outputText value="#{dept.change_type}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="变动时间" />
				</f:facet>
				<h:outputText value="#{dept.change_date}"></h:outputText>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
