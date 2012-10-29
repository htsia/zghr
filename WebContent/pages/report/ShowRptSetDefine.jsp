<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function addDictionarys(rptSetId){
	    if(rptSetId == ""){
            alert("请选择表套 ！");
            return false ;
		}
	    
		PopUpRptList('form1:text5code','form1:text5','1','0');
		document.all('form1:refresh1').click();
}
</script>
<x:saveState value="#{RptSetBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{RptSetBB.pageInit}"></h:inputHidden>
	<h:commandButton id="query" style="display:none"
		action="#{RptSetBB.getPageInit}" />
	<h:commandButton id="refresh1" value="保存" style="display:none;"
		action="#{RptSetBB.saveOrUpdateRptSetItem}"></h:commandButton>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8 align="right"></c:verbatim> <h:inputHidden id="text5"
					value="#{RptSetBB.resultvalues}" /> <h:inputHidden id="text5code"
					value="#{RptSetBB.resultvaluess}" /> <h:commandButton
					styleClass="button01" type="button" value="新增"
					onclick="addDictionarys('#{RptSetBB.rptSetId}');"></h:commandButton>
					<c:verbatim>&nbsp;&nbsp;&nbsp;</c:verbatim>
				<h:commandButton styleClass="button01" value="删除 "
					action="#{RptSetBB.deleteRptSetItems}"
					onclick="return checkBatchDelete('selected_ids');" /> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{RptSetBB.rptSetItemList}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_left"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll, document.form1.selected_ids)";
/>
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
							<h:outputText value="报表编号" />
						</f:facet>
						<h:outputText value="#{list.rptCode}"></h:outputText>
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="报表名称" />
						</f:facet>
						<h:outputText value="#{list.rptCodeName}"></h:outputText>
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

