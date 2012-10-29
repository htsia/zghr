<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function addWeekOk() {
		window.open("/attence/attRearange.jsf?WeekOkID="
				+ document.all("form1:groupId").value, null,
				"width=600,height=350,resizable=yes,left=300,top=100");

	}
	function addRecuNeed() {
		if (document.all("form1:groupId").value == null
				|| document.all("form1:groupId").value == "") {
			alert("请先选择班组!");
			return false;
		}
		window.showModalDialog("/attence/groupMgrListAdd.jsf?groupId="
				+ document.all("form1:groupId").value, "",
				"dialogWidth:1000px; dialogHeight:800px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function addDictionary(groupNo,personID) {
		window.open("/pages/attence/groupCalendar.jsp?groupNo=" + groupNo+"&personID="+personID,
				null, "width=1000,height=700,resizable=yes,left=300,top=100");
	}
	function addDictionary1(groupNo,personID) {
		window.open("/pages/attence/groupCalendar1.jsp?groupNo=" + groupNo+"&personID="+personID,
				null, "width=1000,height=700,resizable=yes,left=300,top=100");
	}
</script>
<x:saveState value="#{group_mgr_listBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{group_mgr_listBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="groupId" value="#{group_mgr_listBB.groupId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left" columns="3">
						<h:panelGroup>
                            <h:outputText value="  "></h:outputText>
							<h:outputText value="记录数:#{group_mgr_listBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{group_mgr_listBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{group_mgr_listBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{group_mgr_listBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{group_mgr_listBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{group_mgr_listBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{group_mgr_listBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{group_mgr_listBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="添加人员" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
						<h:panelGroup>
							<h:outputText style='font-size:12px' value="【为周期班组设置班次 :】"
								rendered="#{group_mgr_listBB.isExist==true}"></h:outputText>
							<h:commandButton styleClass="button01" type="button" value="开始设置"
								rendered="#{group_mgr_listBB.isExist==true}"
								onclick="addWeekOk();"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
                    <h:panelGrid columns="2">
                        <h:inputText styleClass="input" value="#{group_mgr_listBB.queryValue}"/>
                        <h:commandButton value="查询" action="#{group_mgr_listBB.doQuery}" styleClass="button01"/>
                    </h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{group_mgr_listBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<f:facet name="header">
							<h:outputText value="员工编号" />
						</f:facet>
						<h:outputText value="#{list.personSeq}"></h:outputText>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.name}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤卡号" />
						</c:facet>
						<h:outputText value="#{list.card}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="所属机构" />
						</c:facet>
						<h:outputText value="#{list.orgName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="所在部门" />
						</f:facet>
						<h:outputText value="#{list.deptName}"></h:outputText>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="删除人员" onclick="return confirm('确定要删除吗?');"
							action="#{group_mgr_listBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{group_mgr_listBB.machineID}"
								value="#{list.id}" />
						</h:commandButton>
						<h:commandButton styleClass="button01" type="button"
							value="查看个人日历" onclick="addDictionary('#{list.groupNo}','#{list.id}');"
							rendered="#{group_mgr_listBB.isExist==false && group_mgr_listBB.isExist1==false}"></h:commandButton>
						<h:commandButton styleClass="button01" type="button"
							value="查看个人日历" rendered="#{group_mgr_listBB.isExist==true && group_mgr_listBB.isExist1==false }"
							onclick="addDictionary1('#{list.groupNo}','#{list.id}');"></h:commandButton>

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

