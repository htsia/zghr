<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function foradd() {
        	var itemID = document.all('form1:itemID').value;
            window.showModalDialog("/attence/annualMgrListAdd.jsf?itemID="+itemID, null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
        function forModify(detailID) {
            window.showModalDialog("/attence/annualMgrListAdd.jsf?detailID="+detailID, null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{annualMgrListChildBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{annualMgrListChildBB.pageInit}" />
	<h:inputHidden id="itemID" value="#{annualMgrListChildBB.itemID}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤休假天数设置" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<h:panelGrid align="center" width="100%" columns="2">
			<h:panelGrid align="right" columns="2" cellspacing="2">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="新增"
					onclick="foradd()" />
					<h:outputText value="       " />
				<h:commandButton type="button" styleClass="button01" value="返回"
					onclick="window.close();" />
			</h:panelGroup>	
			</h:panelGrid>
		</h:panelGrid>

		<x:dataTable value="#{annualMgrListChildBB.lists}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="序号" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假开始时间" />
				</c:facet>
				<h:outputText value="#{list.holidayBegin}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假结束时间" />
				</c:facet>
				<h:outputText value="#{list.holidayEnd}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假天数" />
				</c:facet>
				<h:outputText value="#{list.daySpan}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="操作" />
				</c:facet>
				<h:panelGrid columns="5" align="center" cellspacing="2">
					<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
						action="#{annualMgrListChildBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{annualMgrListChildBB.detailID}"
							value="#{list.detailID}" />
					</h:commandButton>
					<h:commandButton value="修改"
						onclick="return forModify('#{list.detailID}')" styleClass="button01"></h:commandButton>
				</h:panelGrid>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
