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
						"/attence/catering/autoClassManagerRuleAdd.jsf?superId="
								+ document.all("form1:superId").value, "",
						"dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.43 + "px; status:0;resizable:yes");
		document.all('form1:refresh').click();
		return true;
	}
	function forModify(id) {
		window
				.showModalDialog(
						"/attence/catering/autoClassManagerRuleAdd.jsf?amaId="
								+ id,
						null,
						"dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.43 + "px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{autoclassmanagerruleBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{autoclassmanagerruleBB.pageInit}" />
	<h:inputHidden id="superId" value="#{autoclassmanagerruleBB.superId}"></h:inputHidden>
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 考勤管理 ->自动排班计算规则" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="3" cellspacing="2" width="89%" align="center">
		<h:panelGroup>
			<h:outputText value="记录数:#{autoclassmanagerruleBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{autoclassmanagerruleBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{autoclassmanagerruleBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="当前为第#{autoclassmanagerruleBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{autoclassmanagerruleBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{autoclassmanagerruleBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{autoclassmanagerruleBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{autoclassmanagerruleBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="新增" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{autoclassmanagerruleBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="所属部门" />
			</c:facet>
			<h:outputText value="#{list.orgIdName}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="套用公式" />
			</c:facet>
			<h:outputText value="#{list.formula}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="当月休息天数" />
			</c:facet>
			<h:outputText value="#{list.restDay}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="每小组人数" />
			</c:facet>
			<h:outputText value="#{list.squadPerson}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="每午餐比例(%)" />
			</c:facet>
			<h:outputText value="#{list.lunchRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="晚餐比例(%)" />
			</c:facet>
			<h:outputText value="#{list.superRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="服务员待客量" />
			</c:facet>
			<h:outputText value="#{list.waiter}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="出品比(%)" />
			</c:facet>
			<h:outputText value="#{list.produceRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="人均每餐出品道" />
			</c:facet>
			<h:outputText value="#{list.produceRoad}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="人均清洗量" />
			</c:facet>
			<h:outputText value="#{list.cleanNumber}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="大餐具用量比" />
			</c:facet>
			<h:outputText value="#{list.bigTableWare}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="小餐具用量比" />
			</c:facet>
			<h:outputText value="#{list.smallTableWare}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="骨碟用量比" />
			</c:facet>
			<h:outputText value="#{list.bonePlate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
			    <h:outputText value="操作" />
			</c:facet>
			<h:panelGrid columns="5" align="center" cellspacing="2">
			    <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
						action="#{autoclassmanagerruleBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{autoclassmanagerruleBB.amaId}"
							value="#{list.amaId}" />
					</h:commandButton>
					<h:commandButton value="修改"
						onclick="return forModify('#{list.amaId}')" styleClass="button01"></h:commandButton>
			</h:panelGrid>
		</h:column>
	</h:dataTable>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
