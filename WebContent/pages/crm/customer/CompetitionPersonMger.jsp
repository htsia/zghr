<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
 

function  showDetail(comId){
	 window.showModalDialog("/crm/competition/CompetitionDetailMainFrame.jsf?compeId="+comId+'&cuId='+document.all("form1:cuId").value, null, "dialogWidth:650px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
}

function forPerson() {
	 window.showModalDialog("/crm/customer/SelectCompetitionPerson.jsf?cuId="+document.all("form1:cuId").value, null, "dialogWidth:400px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
	  return true;
}

function compeAction(compId) {
	 window.showModalDialog("/crm/customer/CompetitionActionList.jsf?operation=actlist&compId="+compId+'&cuId='+document.all("form1:cuId").value, null, "dialogWidth:650px; dialogHeight:650px;center:center;resizable:no;status:no;scroll:yes;");
	  return true;
}
</script>



<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{competitionBB.cusPerInit}"></h:inputHidden>
	<h:inputHidden id="cuId" value="#{competitionBB.cuId}"></h:inputHidden>
	<h:commandButton id="query" style="display:none"   action="#{competitionBB.doQuery}" />
	<f:verbatim>
		<table width="96%" border="0" align="center">
			<tr>
				<td align="right"></f:verbatim> <h:panelGroup>
					<h:commandButton value="ѡ��������"  onclick="return forPerson();"  rendered="#{competitionBB.flag == '1'}"
						styleClass="button01"></h:commandButton>
				</h:panelGroup> <f:verbatim></td>
			</tr>
			<tr>
				<td></f:verbatim> <x:dataTable value="#{competitionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="��˾����" />
						</c:facet>
						<h:outputText value="#{list.compeName}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.nation}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.city}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ַ" />
						</c:facet>
						<h:outputText value="#{list.compeAddr}" />
					</h:column>



					<h:column>
						<c:facet name="header">
							<h:outputText value="�ʱ�" />
						</c:facet>
						<h:outputText value="#{list.zip}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ַ" />
						</c:facet>
						<h:outputText value="#{list.webUrl}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="����" />
						</f:facet>
						<h:commandButton styleClass="button01"
							onclick="return compeAction('#{list.compeId}') ;" value="���ֻ"></h:commandButton>
						<h:commandButton styleClass="button01"
							onclick="return showDetail('#{list.compeId}') ;" value="�鿴"></h:commandButton>
						<h:commandButton styleClass="button01" rendered="#{competitionBB.flag == '1'}"
							onclick="return confirm('ȷ��Ҫɾ����');"
							action="#{competitionBB.deleteCompetitionBO}" value="ɾ��">
							<x:updateActionListener value="#{list.compeId}"
								property="#{competitionBB.competitionBO.compeId}"></x:updateActionListener>
							<x:updateActionListener value="#{competitionBB.cuId}"
								property="#{competitionBB.competitionBO.cuId}"></x:updateActionListener>
						</h:commandButton>

					</h:column>

				</x:dataTable> <f:verbatim></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>









