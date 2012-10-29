<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function confirmDel() {
    if (checkMutilSelect(form1.selected_ids)) {
            return true;
    }else{
        alert("请先选择人员！");
        return false;
    }
}
</script>
<x:saveState value="#{group_mgr_listBB}" />
<h:form id="form1">
	<h:inputHidden value="#{group_mgr_listBB.initItem}"></h:inputHidden>
	<h:inputHidden id="groupId" value="#{group_mgr_listBB.groupId}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:outputText value="记录数:#{group_mgr_listBB.mypage1.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{group_mgr_listBB.mypage1.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{group_mgr_listBB.mypage1.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="当前为第#{group_mgr_listBB.mypage1.currentPage}页"></h:outputText>

				<h:commandButton value="首页" action="#{group_mgr_listBB.first1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{group_mgr_listBB.pre1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{group_mgr_listBB.next1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{group_mgr_listBB.last1}"
					styleClass="button01"></h:commandButton>
				<h:outputText value="  "></h:outputText>
				<h:commandButton styleClass="button01" value="确认添加人员"
					action="#{group_mgr_listBB.openUser}" onclick="return confirmDel()" />
				<h:commandButton styleClass="button01" value="退出"
					onclick="window.close();" />
			</h:panelGroup>
		</h:panelGrid>

		<x:dataTable value="#{group_mgr_listBB.itemList}" headerClass="td_top"
			id="dateList" rowIndexVar="index" var="briefList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{briefList.id}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{briefList.personSeq}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{briefList.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考勤卡号" />
				</f:facet>
				<h:outputText value="#{briefList.card}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所属机构" />
				</f:facet>
				<h:outputText value="#{briefList.orgName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所在部门" />
				</f:facet>
				<h:outputText value="#{briefList.deptName}"></h:outputText>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
