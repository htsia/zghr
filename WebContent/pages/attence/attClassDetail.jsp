<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function doAddItem() {
		var classID = document.all('form1:classID').value;
		window
				.showModalDialog(
						"/attence/attClassDetailEdit.jsf?classID=" + classID,
						null,
						"dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doModifyCource(id) {
		window
				.showModalDialog(
						"/attence/attClassDetailEdit.jsf?itemID=" + id,
						null,
						"dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>
<x:saveState value="#{att_class_detailBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_class_detailBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="classID" value="#{att_class_detailBB.classID}"></h:inputHidden>
	<h:inputHidden id="createOrg" value="#{att_class_detailBB.createOrg}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="设置时段 -> #{att_class_detailBB.className}" />
		</h:panelGroup>
	</h:panelGrid>
	<c:verbatim>
		<table height=80% width=98% align="center">
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim>
					<x:dataTable value="#{att_class_detailBB.attmachineList}" var="list" 
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
							<h:outputText value="时刻名称" />
						</c:facet>
						<h:outputText value="#{list.itemName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="时间"  />
						</c:facet>
						<h:outputText  value="#{list.itemTime}"  />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton title="0" value="设置"  rendered="#{att_class_detailBB.createOrg==att_class_detailBB.superID}"
							onclick="return doModifyCource('#{list.itemID}');"
							styleClass="button01">
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
