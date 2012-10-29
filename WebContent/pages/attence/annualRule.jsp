<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
         function addRecuNeed(){
             window.showModalDialog("/attence/annualRuleAdd.jsf?okID=100", "", "dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.4 + "px; status:0;resizable:yes");
             return true;
         }
function modify(id,id1){
    window.showModalDialog("/attence/annualRuleAdd.jsf?ruleID="+id+"&oid="+id1, "", "dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.4 + "px; status:0;resizable:yes");
    return true;
}
function modify1(id,id1){
    window.showModalDialog("/attence/annualRuleList.jsf?ruleID="+id+"&oid="+id1, "", "dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:" + screen.height * 0.5 + "px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{annualRuleBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{annualRuleBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> ��ٹ���</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8>
				<table width="98%" align="center">
					<tr>
						<td align="center" width="12%" class=activeTab><a
							href="annualRule.jsf">�ݼ���������</a></td>
						<td align="center" width="12%" class=tab><a
							href="attExecludeRule.jsf">�������ݼٹ���</a></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
					</tr>
				</table>

				</td>
			</tr>
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGrid align="right" columns="1">
						<h:commandButton value="�½�����" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{annualRuleBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.ruleName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="Ӧ�÷�Χ" />
						</c:facet>
						<h:outputText value="#{list.createOrgName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.createOrgName1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.createDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.description}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{annualRuleBB.delete}" styleClass="button01"
							rendered="#{list.status1=='1'}">
							<x:updateActionListener property="#{annualRuleBB.ruleID}"
								value="#{list.ruleID}" />
						</h:commandButton>
						<h:commandButton value="�޸�"
							onclick="return modify('#{list.ruleID}','#{list.createOrg}')"
							styleClass="button01" rendered="#{list.status1=='1'}"></h:commandButton>
						<h:commandButton value="���������Ŀ"
							onclick="return modify1('#{list.ruleID}','#{list.ruleName}')"
							styleClass="button01" rendered="#{list.status1=='1'}"></h:commandButton>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
