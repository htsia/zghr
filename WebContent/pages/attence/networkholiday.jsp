<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
			window.showModalDialog("/attence/networkholidayChild.jsf?itemID="+id, "",
					"dialogWidth:" + screen.width * 0.4 + "px; dialogHeight:"+ screen.height * 0.3+ "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem(id) {
		window.showModalDialog(
						"/attence/networkholidayChildAdd.jsf?itemID="+id,
						"",
						"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"+ screen.height * 0.9+ "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{networkholidayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{networkholidayBB.pageInit}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{networkholidayBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{networkholidayBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{networkholidayBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{networkholidayBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{networkholidayBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{networkholidayBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{networkholidayBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{networkholidayBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <x:dataTable value="#{networkholidayBB.lists}" var="list"
					rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="显示"
							onclick="return doAddItem('#{list.itemID}');"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="休假"
							onclick="return doEditItem('#{list.itemID}');"
							styleClass="button01"></h:commandButton>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="休假年度" />
						</c:facet>
						<h:outputText value="#{list.yearValues}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
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
							<h:outputText value="计算日期" />
						</c:facet>
						<h:outputText value="#{list.calcDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="假期天数" />
						</c:facet>
						<h:outputText value="#{list.annDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="已休天数" />
						</c:facet>
						<h:outputText value="#{list.useDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="剩余天数" />
						</c:facet>
						<h:outputText value="#{list.avaDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界日期" />
						</c:facet>
						<h:outputText value="#{list.criticalDate}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界后假期天数" />
						</c:facet>
						<h:outputText value="#{list.criticalAnnDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界后已休天数" />
						</c:facet>
						<h:outputText value="#{list.calcAnnDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="临界后剩余天数" />
						</c:facet>
						<h:outputText value="#{list.criticalAvaDay}" />
					</h:column>
				</x:dataTable> <f:verbatim></div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>

