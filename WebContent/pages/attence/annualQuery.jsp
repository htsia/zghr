<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">

function PunshCardmanager(itemID){
    window.open("/pages/attence/annualQueryExel.jsp?recId="+document.all('form1:recID').value, "", "dialogWidth:1000px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}

</script>
<x:saveState value="#{annualMgrListBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{annualMgrListBB.queryInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{annualMgrListBB.superId}"></h:inputHidden>
	<h:inputHidden id="recID" value="#{annualMgrListBB.recID}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> 年假管理->实时数据查询</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8 align="center"></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGrid align="left">
						<h:panelGroup>
                            <h:outputText value="姓名和员工编号:"></h:outputText>
                            <h:inputText value="#{annualMgrListBB.personValue}" styleClass="input"></h:inputText>
                            <h:commandButton value="查询" action="#{annualMgrListBB.queryVO}"
								styleClass="button01"></h:commandButton>
                            <h:commandButton value="全部导出" style="button" onclick="PunshCardmanager();"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="4">
						<h:panelGroup>
							<h:outputText value="记录数:#{annualMgrListBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{annualMgrListBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{annualMgrListBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{annualMgrListBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{annualMgrListBB.qryFirst}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{annualMgrListBB.gryPre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{annualMgrListBB.gryNext}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{annualMgrListBB.gryLast}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{annualMgrListBB.queryVoList}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="人员姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="进入本单位时间" />
						</c:facet>
						<h:outputText value="#{list.enterDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="参加工作时间" />
						</c:facet>
						<h:outputText value="#{list.workDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="假期天数" />
						</c:facet>
						<h:outputText value="#{list.canLeaveDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="已休天数" />
						</c:facet>
						<h:outputText value="#{list.haveLeaveDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="剩余天数" />
						</c:facet>
						<h:outputText value="#{list.avaLeaveDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界日期" />
						</c:facet>
						<h:outputText value="#{list.criticalDate}" />
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>





