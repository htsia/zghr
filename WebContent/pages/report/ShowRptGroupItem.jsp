<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	String rptGroupId = request.getParameter("superId");
	%>
<script type="text/javascript">
function rptItemAdd(rptGroupDir){
	 window.showModalDialog("/report/RptGroupItemEdit.jsf?rptGroupId="+rptGroupDir, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
	 document.all('form1:query').click();
     return false;
}
function rptItemEdit(rptGroupDir){
	 window.showModalDialog("/report/RptGroupItemEdit.jsf?itemId="+rptGroupDir, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
	 document.all('form1:query').click();
    return false;
}
</script>

<x:saveState value="#{GroupDirBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{GroupDirBB.groupItemInit}"></h:inputHidden>
    <h:commandButton id="query" style="display:none"   action="#{GroupDirBB.getGroupItemInit}" />
    <h:commandButton id="refresh1" value="保存" style="display:none;"
		 action="#{RptSetBB.saveOrUpdateRptSetItem}"></h:commandButton>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8  align="right"></c:verbatim> <br />
				<h:panelGrid width="100%" columns="1" align="right">
					<h:panelGrid align="right" columns="5">
						<h:commandButton styleClass="button01" type="button" value="新增"  onclick="rptItemAdd('#{GroupDirBB.groupDirId}');">
						</h:commandButton>
			            <h:commandButton styleClass="button01" value="删除 " 
			                action = "#{GroupDirBB.deleteGroupDirItem}"
			                onclick="return checkBatchDelete('selected_ids');"  ></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{GroupDirBB.groupItemList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
columnClasses="td_middle_center,td_middle_center,td_middle_left"
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
                  <h:outputText value="#{list.itemId}"/>
                  <c:verbatim>">
						</c:verbatim>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="机构" />
						</f:facet>
						<h:outputText value="#{list.orgName}"></h:outputText>
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="顺序" />
						</f:facet>
						<h:outputText value="#{list.seq}"></h:outputText>
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton styleClass="button01" type="button" value="修改"  onclick="rptItemEdit('#{list.itemId}');"></h:commandButton>
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

   