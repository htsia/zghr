<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}
	function addDictionary(orgId) {
		window
				.showModalDialog(
						"/attence/attRearangeEdit.jsf?rearrangeNo=" + orgId,
						null,
						"dialogWidth:+screen.width*0.35+px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
		document.all('form1:refresh').click();
	}
</script>
<x:saveState value="#{att_rearrangeBB}"></x:saveState>
<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{att_rearrangeBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="groupId" value="#{att_rearrangeBB.groupNo}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left" columns="2">
						<h:panelGroup>
							<h:outputText value="记录数:#{att_rearrangeBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{att_rearrangeBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{att_rearrangeBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{att_rearrangeBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{att_rearrangeBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{att_rearrangeBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{att_rearrangeBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{att_rearrangeBB.last}"
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
					value="#{att_rearrangeBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="班组" />
						</c:facet>
						<h:outputText value="#{att_rearrangeBB.groupNoName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="班组类别" />
						</c:facet>
						<h:outputText value="#{att_rearrangeBB.groupNoTypeName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="时间序列" />
						</c:facet>
						<h:outputText value="#{list.daySeq}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="所上班次" />
						</c:facet>
						<h:outputText value="#{list.linkClassName}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton styleClass="button01" type="button" value="班次设置"
							onclick="addDictionary('#{list.rearrangeNo}');"></h:commandButton>
						<h:commandButton value="重置"
							action="#{att_rearrangeBB.repeart}" styleClass="button01">
							<x:updateActionListener
								property="#{att_rearrangeBB.rearrangeNo1}"
								value="#{list.rearrangeNo}" />
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

