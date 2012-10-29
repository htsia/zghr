<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function refreshload() {
		document.all('form1:refresh1').click();
	}
</script>
<x:saveState value="#{attimportlogBB}"></x:saveState>
<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden value="#{attimportlogBB.pageInit}"></h:inputHidden>
	<h:commandButton id="refresh1" value="刷新" style="display:none;"
		action="#{attimportlogBB.doQuery}"></h:commandButton>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">查看导入日志</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGroup>
						<h:outputText value="记录数:#{attimportlogBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{attimportlogBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{attimportlogBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{attimportlogBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{attimportlogBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{attimportlogBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{attimportlogBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{attimportlogBB.last}"
							styleClass="button01"></h:commandButton>
					</h:panelGroup>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{attimportlogBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">

                    <h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{list.logID}" />
					</h:column>

                    <h:column>
						<c:facet name="header">
							<h:outputText value="服务标示" />
						</c:facet>
						<h:outputText value="#{list.machineID}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="接收时间" />
						</c:facet>
						<h:outputText value="#{list.createDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="开始序号" />
						</c:facet>
						<h:outputText value="#{list.minValue}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="终止序号" />
						</c:facet>
						<h:outputText value="#{list.maxValue}" />
					</h:column>

			        <h:column>
				     <c:facet name="header">
					  <h:outputText value="操作" />
				     </c:facet>
					 <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
						action="#{attimportlogBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{attimportlogBB.logID}"
							value="#{list.logID}" />
					 </h:commandButton>
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
</body>

