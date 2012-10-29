<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function foradd() {
            window.showModalDialog("/attence/attExecludeRuleItemAdd.jsf?okID=100", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
        function forModify(itemID) {
            window.showModalDialog("/attence/attExecludeRuleItemAdd.jsf?itemID="+itemID, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{attexecluderuletitemBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{attexecluderuletitemBB.pageInit}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤年假不允许规则" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<h:panelGrid align="center" width="100%" columns="2">
			<h:outputText value="名称：#{attexecluderuletitemBB.ruleName}"></h:outputText>
			<h:panelGrid align="right" columns="2" cellspacing="2" width="30%">
				<h:commandButton styleClass="button01" value="新建项目"
					onclick="foradd()" />
				<h:commandButton type="button" styleClass="button01" value="返回"
					onclick="window.close();" />
			</h:panelGrid>
		</h:panelGrid>

		<x:dataTable value="#{attexecluderuletitemBB.lists}" var="list"
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
					<h:outputText value="规则描述" />
				</c:facet>
				<h:outputText value="#{list.contentDes}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="操作" />
				</c:facet>
				<h:panelGrid columns="5" align="center" cellspacing="2">
					<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
						action="#{attexecluderuletitemBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{attexecluderuletitemBB.itemId}"
							value="#{list.itemId}" />
					</h:commandButton>
					<h:commandButton value="修改"
						onclick="return forModify('#{list.itemId}')" styleClass="button01"></h:commandButton>
				</h:panelGrid>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
