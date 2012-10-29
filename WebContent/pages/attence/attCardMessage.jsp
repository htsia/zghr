<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{att_card_messageBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_card_messageBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							
                          
      <h:outputText value="查询考勤卡方式："></h:outputText>
      <h:selectOneMenu value="#{att_card_messageBB.status}" onchange="submit();" valueChangeListener="#{att_card_messageBB.changeStatus}">
  <c:selectItem itemLabel="全部" itemValue="0"></c:selectItem>
 <c:selectItem itemLabel="发卡" itemValue="1"></c:selectItem>
 <c:selectItem itemLabel="换卡" itemValue="2"></c:selectItem>
 <c:selectItem itemLabel="退卡" itemValue="3"></c:selectItem>
</h:selectOneMenu>

                              
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
							<h:outputText
								value="记录数:#{att_card_messageBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{att_card_messageBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{att_card_messageBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="当前为第#{att_card_messageBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{att_card_messageBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{att_card_messageBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{att_card_messageBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{att_card_messageBB.last}"
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
					value="#{att_card_messageBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
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
							<h:outputText value="操作员" />
						</c:facet>
						<h:outputText value="#{list.manageName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作时间" />
						</c:facet>
						<h:outputText value="#{list.openTime}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="人员" />
						</c:facet>
						<h:outputText value="#{list.cardName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="发卡类型" />
						</c:facet>
						<h:outputText value="#{list.operTypeName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="原值" />
						</c:facet>
						<h:outputText value="#{list.oldValue}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="新值" />
						</c:facet>
						<h:outputText value="#{list.newValue}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{att_card_messageBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{att_card_messageBB.logID}"
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
