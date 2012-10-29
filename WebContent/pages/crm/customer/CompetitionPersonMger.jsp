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
					<h:commandButton value="选择竞争对手"  onclick="return forPerson();"  rendered="#{competitionBB.flag == '1'}"
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
							<h:outputText value="公司名称" />
						</c:facet>
						<h:outputText value="#{list.compeName}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="国家" />
						</c:facet>
						<h:outputText value="#{list.nation}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="城市" />
						</c:facet>
						<h:outputText value="#{list.city}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="地址" />
						</c:facet>
						<h:outputText value="#{list.compeAddr}" />
					</h:column>



					<h:column>
						<c:facet name="header">
							<h:outputText value="邮编" />
						</c:facet>
						<h:outputText value="#{list.zip}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="网址" />
						</c:facet>
						<h:outputText value="#{list.webUrl}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton styleClass="button01"
							onclick="return compeAction('#{list.compeId}') ;" value="对手活动"></h:commandButton>
						<h:commandButton styleClass="button01"
							onclick="return showDetail('#{list.compeId}') ;" value="查看"></h:commandButton>
						<h:commandButton styleClass="button01" rendered="#{competitionBB.flag == '1'}"
							onclick="return confirm('确定要删除吗？');"
							action="#{competitionBB.deleteCompetitionBO}" value="删除">
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









