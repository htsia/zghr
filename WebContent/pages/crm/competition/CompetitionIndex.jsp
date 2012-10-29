
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function  editComBO(comId){
    window.showModalDialog("/crm/competition/EditCompetition.jsf?compeId="+comId, null, "dialogWidth:600px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:yes;");
    document.all('form1:query').click();
     return false;
}

function  showDeatil(comId){
    window.showModalDialog("/crm/competition/CompetitionDetailMainFrame.jsf?compeId="+comId, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    return false;
}

function addComBO(){
    window.showModalDialog("/crm/competition/EditCompetition.jsf" , null, "dialogWidth:600px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:yes;");
    document.all('form1:query').click();
     return false;
}

function personManager(comId){
    window.showModalDialog("/crm/competition/CompetitionPersonMger.jsf?comId="+comId , null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
}
</script>

<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{competitionBB.pageInit}"></h:inputHidden>
	<h:commandButton id="query" style="display:none"   action="#{competitionBB.doQuery}" />
	<f:verbatim>
		<table width="98%" border="0" align="center">
			<tr>
				<td align="right"></f:verbatim> <h:panelGroup>
					<h:outputText value="记录数:#{competitionBB.pagevo.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="页数:#{competitionBB.pagevo.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="每页有#{competitionBB.pagevo.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="当前为第#{competitionBB.pagevo.currentPage}页"></h:outputText>
					<h:commandButton value="首页" action="#{competitionBB.first}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="上页" action="#{competitionBB.pre}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="下页" action="#{competitionBB.next}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="尾页" action="#{competitionBB.last}"
						styleClass="button01"></h:commandButton>
					<f:verbatim>&nbsp;</f:verbatim>
					<h:commandButton value="增加对象" onclick="return addComBO();"
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
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return showDeatil('#{list.compeId}') ;" value="查看"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return personManager('#{list.compeId}');" value="人员管理"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return editComBO('#{list.compeId}');" value="修改"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return confirm('确定要删除吗？');"
							action="#{competitionBB.deleteCompetitionBO}" value="删除">
							<x:updateActionListener value="#{list.compeId}"
								property="#{competitionBB.competitionBO.compeId}"></x:updateActionListener>
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









