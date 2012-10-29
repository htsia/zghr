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

function addDictionary(){
	var name = document.all('form1:name').value;
	var name1 = document.all('form1:name1').value;
    window.showModalDialog("/attence/showCalendaEditSort.jsf?personID="+name+"&aDate="+name1, null, "dialogWidth:800px; dialogHeight:800px;center:center;resizable:no;status:no;scroll:no;");
    document.all('form1:refresh1').click();
}

	function doAddItem() {
		var name = document.all('form1:name').value;
		var name1 = document.all('form1:name1').value;
		window
				.showModalDialog(
						"/attence/showCalendaEdit.jsf?name=" + name + "&name1="
								+ name1,
						null,
						"dialogWidth:300px; dialogHeight:230px;center:center;resizable:yes;status:no;scroll:yes;");

		return true;
	}

	function doModifyCource(id) {
		var name1 = document.all('form1:name1').value;
		window
				.showModalDialog(
						"/attence/showCalendaEdit.jsf?itemIDS=" + id
								+ "&name1=" + name1,
						null,
						"dialogWidth:300px; dialogHeight:230px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>
<x:saveState value="#{groupCalendarEditBB}"></x:saveState>
<h:form id="form1">
	<h:commandButton id="refresh1" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden value="#{groupCalendarEditBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="name" value="#{groupCalendarEditBB.name}"></h:inputHidden>
	<h:inputHidden id="name1" value="#{groupCalendarEditBB.name1}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:commandButton value="增加事宜" styleClass="button01"
								onclick="doAddItem();"></h:commandButton>
								<h:outputText value=" " />
								<h:outputText value=" " />
							<h:commandButton styleClass="button01" type="button" value="排序"
								onclick="addDictionary();" />
						</h:panelGroup>
					</h:panelGrid>

					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{groupCalendarEditBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_left,td_middle_center,td_middle_center,td_middle_left,td_middle_left"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="时间" />
						</c:facet>
						<h:outputText value="#{list.date}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="事宜" />
						</c:facet>
						<h:outputText value="#{list.activity}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton styleClass="button01" value="修改"
							onclick="return doModifyCource('#{list.itemID}');" />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{groupCalendarEditBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{groupCalendarEditBB.itemID}"
								value="#{list.itemID}" />
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

