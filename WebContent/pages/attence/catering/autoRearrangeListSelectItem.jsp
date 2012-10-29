<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/selectItem.js"></script>
<script type="text/javascript">
	function Add(ori) {
		var itemId = "id";
		var itemName = "";
		var count = ori.options.length;
		for (i = 0; i < count; i++) {
			if (ori.options[i].selected == true) {
				itemId += "," + ori.options[i].value;
				itemName += ori.options[i].text;
			}
		}
		if (itemName == null || itemName == "") {
			alert("请选择要操作的项目！");
			return false;
		}
		document.all('form1:itemId').value = itemId;
		return true;
	}
	var flag = 0;
	function showHide(obj) {
		if (flag == 0) {
			obj.style.display = "none";
			flag = 1;
		} else {
			obj.style.display = "";
			flag = 0;
		}
	}
	function doShowPerson(id){
			window
			.showModalDialog(
					"/pages/attence/groupCalendarEdit1.jsp?name="+id,
					null,
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:" + screen.height * 0.8 + "px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
	}
	//window.onload=function()//用window的onload事件，窗体加载完毕的时候
	//{
	   //do something
	   //ryTable.style.display = "none";
	   //flag = 1;
	//}
</script>

<x:saveState value="#{autorearrangelistselectitemBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"
		value="#{autorearrangelistselectitemBB.pageInit}" />
	<h:inputHidden id="itemId"
		value="#{autorearrangelistselectitemBB.itemId}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤自动排班人员调整" />
		</h:panelGroup>
				<h:panelGroup>>
						<h:graphicImage value="/images/attence/clock.gif" />
			<h:outputText value="#{autorearrangelistselectitemBB.createDay}" />
		</h:panelGroup>
	</h:panelGrid>
	<c:verbatim>
		<br>
	</c:verbatim>
	<c:verbatim>
		<br />
		<table id="ryTable" width="800" border="0" align="center">
			<tr>
				<td></c:verbatim> <x:dataTable
					value="#{autorearrangelistselectitemBB.personArrangeList}"
					var="list" id="dateList" rowIndexVar="index" headerClass="td_top"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" styleClass="table03" width="800" border="1">
					<h:column>
						<c:facet name="header">
							<h:outputText value="所属班组" />
						</c:facet>
						<h:outputText value="#{list.groupName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="班组类型" />
						</c:facet>
						<h:outputText value="#{list.groupType}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="所属班次" />
						</c:facet>
						                <h:commandLink id="bnt1" value="#{list.linkClassName}" onclick="doShowPerson('#{list.linkClass}')">
                </h:commandLink>
					</h:column>

				</x:dataTable> <c:verbatim></td>
			</tr>
		</table>
		<br />
	</c:verbatim>
	<h:panelGrid width="95%" columns="1" align="center"
		styleClass="table03" columnClasses="td_form01">
	</h:panelGrid>
	<c:verbatim escape="false">
		<br>
	</c:verbatim>
	<h:panelGrid width="95%" columns="1" align="center"
		styleClass="table03" columnClasses="td_form01,td_form01,td_form01">
	</h:panelGrid>

	<h:panelGrid columns="4" align="center" width="95%"
		styleClass="table03"
		columnClasses="td_middle,td_middle,td_middle,td_middle">
		<h:panelGroup>
			<h:outputText value="工作人员列表" />
		</h:panelGroup>
		<h:outputText value=" " />

		<h:panelGroup>
			<h:outputText value="休息人员列表" />
		</h:panelGroup>
		<h:outputText value=" " />

		<h:selectManyListbox size="15" style="width:250px" id="preTreat">
			<c:selectItems value="#{autorearrangelistselectitemBB.workList}" />
		</h:selectManyListbox>

		<h:panelGroup>
			<h:commandButton styleClass="button01"
				onclick="Add(form1.all('form1:preTreat'))" value=">>"
				action="#{autorearrangelistselectitemBB.add}"
				rendered="#{autorearrangelistselectitemBB.isExist==true}" />
			<f:verbatim>
				<br>
			</f:verbatim>
			<h:commandButton styleClass="button01"
				onclick="Add(form1.all('form1:rsItem'))" value="<<" action="
				#{autorearrangelistselectitemBB.delete}" rendered="#{autorearrangelistselectitemBB.isExist==true}" />
		</h:panelGroup>

		<h:selectManyListbox size="15" style="width:250px" id="rsItem">
			<c:selectItems value="#{autorearrangelistselectitemBB.restList}" />
		</h:selectManyListbox>
		
	</h:panelGrid>

</h:form>
