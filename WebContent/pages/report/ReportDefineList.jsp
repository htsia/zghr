<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function rptDesigners(){
	var id=document.all('form1:groupId').value;
	if (id == null || id == "") {
		alert("请选择目录！");
		return false;
	}
    window.showModalDialog("/pages/report/rptDesigner.jsp?arg="+id, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function rptDesigner(id){
    window.showModalDialog("/pages/report/rptDesigner.jsp?arg="+id, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
}
function receiveRpt(){
	window.showModalDialog("/report/ReceiveRptFile.jsf", null, "dialogWidth:450px;  dialogHeight:130px;center:center;resizable:yes;status:no;scroll:yes;");
}

function batchDelte(){
	 if(checkBatchDelete('selected_ids')){
	     return true ;
	 }
	//document.all('form1:refesh').click();
	return false ;
}
</script>
<x:saveState value="#{Rpt_DefineListBB}"></x:saveState>
<h:form id="form1">                             
	<h:inputHidden id="pageInit"  value="#{Rpt_DefineListBB.pageInit}"></h:inputHidden>
    <h:commandButton id="refesh" value="刷新" style="display:none" action="#{Rpt_DefineListBB.refesh}"></h:commandButton>
	<h:inputHidden id="groupId"  value="#{Rpt_DefineListBB.groupId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGrid align="left" columns="4">
						<h:panelGroup>
							<h:outputText value="记录数:#{Rpt_DefineListBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{Rpt_DefineListBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{Rpt_DefineListBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{Rpt_DefineListBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{Rpt_DefineListBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{Rpt_DefineListBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{Rpt_DefineListBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{Rpt_DefineListBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton styleClass="button01" type="button" value="新增" rendered="false" onclick="return rptDesigners();"></h:commandButton>
			<h:commandButton styleClass="button01" value="删除 "
				action="#{Rpt_DefineListBB.deleteBatch}"
				onclick="return batchDelte();" />
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{Rpt_DefineListBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);"/>
							</c:verbatim>
						</c:facet>
						<c:verbatim escape="false">
							<input type="checkbox" name="selected_ids"
								value="</c:verbatim>
                  <h:outputText value="#{list.rptcode}"/>
                  <c:verbatim>">
						</c:verbatim>
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="编号" />
						</f:facet>
						<h:outputText value="#{list.rptcode}"></h:outputText>
					</h:column>
					
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="表名" />
						</f:facet>
						<h:outputText value="#{list.rptDesc}"></h:outputText>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
	<h:commandButton styleClass="button01" value="修改"
					onclick="rptDesigner('#{list.rptcode}');" />
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

