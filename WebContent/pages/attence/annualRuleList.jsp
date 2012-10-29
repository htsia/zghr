<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function foradd() {
            window.showModalDialog("/attence/annualRuleListAdd.jsf?okID=100", null, "dialogWidth:" + screen.width * 0.2 + "px; dialogHeight:" + screen.height * 0.3 + "px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
        function forModify(itemID) {
            window.showModalDialog("/attence/annualRuleListAdd.jsf?itemID="+itemID, null, "dialogWidth:" + screen.width * 0.2 + "px; dialogHeight:" + screen.height * 0.3 + "px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{annualRuleItemBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{annualRuleItemBB.pageInit}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="����������ù���" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<h:panelGrid align="right" width="100%" columns="1">
			<h:panelGrid align="right" columns="2" cellspacing="2" width="30%">
				<h:commandButton styleClass="button01" value="�½���Ŀ"
					onclick="foradd()" />
				<h:commandButton type="button" styleClass="button01" value="����"
					onclick="window.close();" />
			</h:panelGrid>
		</h:panelGrid>

		<x:dataTable value="#{annualRuleItemBB.lists}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="���" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="��ֵ(��)" />
				</c:facet>
				<h:outputText value="#{list.lowValue}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="��ֵ(��)" />
				</c:facet>
				<h:outputText value="#{list.highValue}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="�ݼ�����" />
				</c:facet>
				<h:outputText value="#{list.annDay}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="����" />
				</c:facet>
				<h:panelGrid columns="5" align="center" cellspacing="2">
					<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
						action="#{annualRuleItemBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{annualRuleItemBB.itemID}"
							value="#{list.itemID}" />
					</h:commandButton>
					<h:commandButton value="�޸�"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
				</h:panelGrid>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
