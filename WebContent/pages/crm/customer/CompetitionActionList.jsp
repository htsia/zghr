<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function addCompAct(compId) {
	 window.showModalDialog("/crm/customer/CompetionActionEdit.jsf?opertion=add&compId="+document.all("form1:compId").value+'&cuId='+document.all("form1:cuId").value, null, "dialogWidth:450px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:yes;");
	 document.all('form1:query').click();
	 return false;
}

function editCompAct(actId) {
	 window.showModalDialog("/crm/customer/CompetionActionEdit.jsf?opertion=edit&actId="+actId, null, "dialogWidth:450px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:yes;");
	 document.all('form1:query').click();
      return false;
}


function actDeatil(actId) {
	 window.showModalDialog("/crm/customer/CompetionActionEdit.jsf?opertion=detail&actId="+actId, null, "dialogWidth:450px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:yes;");
      return false;
}
</script>
<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{competitionBB.compActionInit}"></h:inputHidden>
	<h:inputHidden id= "compId" value="#{competitionBB.compeId}"></h:inputHidden>
	<h:inputHidden id ="cuId"   value="#{competitionBB.cuId}"></h:inputHidden>
	 <h:commandButton id="query" style="display:none"   action="#{competitionBB.doQuery2}" />
	 
	 <h:panelGrid columns="1" styleClass="td_title" width="102%" rendered="#{competitionBB.flag == '1'}"
		align="center">
		<h:panelGroup >
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ֹ���- > �����"></h:outputText>
		</h:panelGroup>
	</h:panelGrid>
	 
	<h:panelGrid columns="1" align="center" width="100%">

		<h:panelGroup>
			<h:panelGrid columns="2" align="right" rendered="#{competitionBB.flag == '1'}" >
				<h:commandButton value="����"  styleClass="button01"  onclick="return addCompAct();"  />
				<h:commandButton value="����" styleClass="button01"  onclick="return window.close();"  />
			</h:panelGrid>
		</h:panelGroup>


		<h:panelGroup>
			<h:panelGrid columns="1" width="100%" styleClass="table02" align="center">
				<x:dataTable value="#{competitionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="�ʱ��" />
						</c:facet>
						<h:outputText value="#{list.actDate}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="���� " />
						</c:facet>
						<h:outputText value="#{list.actContent}" />
					</h:column>



					<h:column>
						<f:facet name="header">
							<h:outputText value="����" />
						</f:facet>
						<h:commandButton styleClass="button01"
							onclick="return actDeatil('#{list.actId}') ;" value="�鿴"  ></h:commandButton>
							<h:commandButton styleClass="button01"
							onclick="return editCompAct('#{list.actId}') ;" value="�޸�" rendered="#{competitionBB.flag == '1'}"></h:commandButton>
						<h:commandButton styleClass="button01"
							onclick="return confirm('ȷ��Ҫɾ����');"
							action="#{competitionBB.deleteCompetitionActionBO}" value="ɾ��" rendered="#{competitionBB.flag == '1'}">
							<x:updateActionListener value="#{list.actId}"
								property="#{competitionBB.competionActionBO.actId}"></x:updateActionListener>
						</h:commandButton>

					</h:column>

				</x:dataTable>
			</h:panelGrid>
		</h:panelGroup>
	</h:panelGrid>
</h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>



