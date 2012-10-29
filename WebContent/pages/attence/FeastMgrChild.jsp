<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
         function addRecuNeed(){
             window.showModalDialog("/attence/FeastEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:" + screen.width * 0.35 + "px; dialogHeight:" + screen.height * 0.6 + "px; status:0;resizable:yes");
             return true;
         }
function modify(id,id1){
    window.showModalDialog("/attence/FeastEdit.jsf?feastID="+id+"&oid="+id1, "", "dialogWidth:" + screen.width * 0.35 + "px; dialogHeight:" + screen.height * 0.6 + "px; status:0;resizable:yes");
    return true;
}
function workDate(id,id1){
    window.showModalDialog("/attence/FeastWorkDate.jsf?feastID="+id+"&oid="+id1, "", "dialogWidth:" + screen.width * 0.35 + "px; dialogHeight:" + screen.height * 0.6 + "px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{att_feast_mgrchildBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_feast_mgrchildBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{att_feast_mgrchildBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="当前机构:"></h:outputText>
							<h:outputText value="#{att_feast_mgrchildBB.superName}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
							<h:outputText
								value="记录数:#{att_feast_mgrchildBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{att_feast_mgrchildBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{att_feast_mgrchildBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="当前为第#{att_feast_mgrchildBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页"
								action="#{att_feast_mgrchildBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{att_feast_mgrchildBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{att_feast_mgrchildBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{att_feast_mgrchildBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="增加" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{att_feast_mgrchildBB.attmachineList}" var="list"
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
							<h:outputText value="应用范围" />
						</c:facet>
						<h:outputText value="#{list.orgIDName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="节假日名称" />
						</c:facet>
						<h:outputText value="#{list.feastName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="日期范围" />
						</c:facet>
						<h:outputText value="#{list.feastDate}" />
					</h:column>

                    <h:column>
						<c:facet name="header">
							<h:outputText value="创建日期" />
						</c:facet>
						<h:outputText value="#{list.regTime}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="描述" />
						</c:facet>
						<h:outputText value="#{list.description}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑"
							onclick="return modify('#{list.feastID}','#{att_feast_mgrchildBB.superId}')"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{att_feast_mgrchildBB.delete}" styleClass="button01">
							<x:updateActionListener
								property="#{att_feast_mgrchildBB.feastID}"
								value="#{list.feastID}" />
						</h:commandButton>
						<h:commandButton value="调休安排"
							onclick="return workDate('#{list.feastID}','#{list.orgID}')"
							styleClass="button01"></h:commandButton>
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
