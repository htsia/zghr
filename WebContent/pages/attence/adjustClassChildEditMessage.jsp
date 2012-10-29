<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{adjustClassChildBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{adjustClassChildBB.initEdit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
                              
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
						</h:panelGroup>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{adjustClassChildBB.attmachineList}" var="list"
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
							<h:outputText value="换班时间" />
						</c:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="原班次" />
						</c:facet>
						<h:outputText value="#{list.oldClassName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="新班次" />
						</c:facet>
						<h:outputText value="#{list.newClassName}" />
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
