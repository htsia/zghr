<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}
	function forAddDate() {
		window
				.showModalDialog(
						"/attence/catering/setStandardAdd.jsf?ok=10000",
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function forFinanceDate(id, id1) {
		window
				.showModalDialog(
						"/attence/catering/setStandardAdd.jsf?subId=" + id
								+ "&orgId=" + id1,
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function doDetailPopup(id) {
		window
				.showModalDialog(
						"/attence/catering/setStandardList.jsf?orgId=" + id,
						null,
						"dialogWidth:800px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{setstandardBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{setstandardBB.pageInit}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 考勤管理 ->设定标准" />
		</h:panelGroup>
	</h:panelGrid>
    <h:panelGrid columns="1" width="100%">
    <h:panelGrid  cellspacing="2" width="89%" align="right">
          <h:panelGroup>
			<h:outputText value="记录数:#{setstandardBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{setstandardBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{setstandardBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="当前为第#{setstandardBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{setstandardBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{setstandardBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{setstandardBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{setstandardBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="新增" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
    </h:panelGrid>

	<h:dataTable value="#{setstandardBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="应用范围" />
			</c:facet>
			<h:outputText value="#{list.orguidName}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="标准劳效" />
			</c:facet>
			<h:outputText value="#{list.standWork}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="定编人数" />
			</c:facet>
			<h:outputText value="#{list.personNumber}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="标准确定时间" />
			</c:facet>
			<h:outputText value="#{list.attenceDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="操作" />
			</c:facet>
			<h:commandButton value="设置" styleClass="button01" type="button"
				onclick="return forFinanceDate('#{list.subID}','#{list.orguid}');" />
			<h:commandButton value="查看历史" styleClass="button01" type="button"
				onclick="return doDetailPopup('#{list.orguid}');" />
		</h:column>
	</h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
