<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
         function addRecuNeed(){
             window.showModalDialog("/attence/attmachineEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:320px; dialogHeight:200px; status:0;resizable:yes");
             return true;
         }
function modify(id){
    window.showModalDialog("/attence/attmachineEdit.jsf?machineID="+id, "", "dialogWidth:320px; dialogHeight:200px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{att_machine_mgrchildBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_machine_mgrchildBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{att_machine_mgrchildBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="当前机构:"></h:outputText>
							<h:outputText value="#{att_machine_mgrchildBB.superName}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
							<h:outputText
								value="记录数:#{att_machine_mgrchildBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="页数:#{att_machine_mgrchildBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="每页有#{att_machine_mgrchildBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="当前为第#{att_machine_mgrchildBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页"
								action="#{att_machine_mgrchildBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="上页"
								action="#{att_machine_mgrchildBB.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="下页"
								action="#{att_machine_mgrchildBB.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页"
								action="#{att_machine_mgrchildBB.last}" styleClass="button01"></h:commandButton>
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
					value="#{att_machine_mgrchildBB.attmachineList}" var="list"
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
							<h:outputText value="所属机构" />
						</c:facet>
						<h:outputText value="#{list.orgID}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机名称" />
						</c:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机类型" />
						</c:facet>
						<h:outputText value="#{list.machineTypeName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="安装位置" />
						</c:facet>
						<h:outputText value="#{list.machinePlace}" />
					</h:column>
				
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机IP" />
							
						</c:facet>
						<h:outputText value="#{list.machineIP}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑"
							onclick="return modify('#{list.machineID}')"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{att_machine_mgrchildBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{att_machine_mgrchildBB.machineID}"
								value="#{list.machineID}" />
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
