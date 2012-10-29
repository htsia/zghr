
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function  updatePerson(perId){
    window.showModalDialog("/crm/competition/EditCompePerson.jsf?perId="+perId, null, "dialogWidth:600px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:yes;");
    document.all('form1:query').click();
     return false;
}

function  showDetail(perId){
    window.showModalDialog("/crm/competition/CompetitionPersonDetail.jsf?perId="+perId, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
}

function addCompPerson(){
    window.showModalDialog("/crm/competition/EditCompePerson.jsf?comId="+document.all("form1:compId").value , null, "dialogWidth:600px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:yes;");
    document.all('form1:query').click();
     return false;
}
</script>



<x:saveState value="#{compPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{compPersonBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="compId" value="#{compPersonBB.compeId}"></h:inputHidden>
	<h:commandButton id="query" style="display:none"   action="#{compPersonBB.doQuery}" />
	<f:verbatim>
	
	    <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="竞争对手 - > 人员管理 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
		      <tr>
				<td align="right"></f:verbatim> <h:panelGroup>
					<h:commandButton value="增加" onclick="return addCompPerson();"  rendered="#{compPersonBB.flag == 1}"
						styleClass="button01"></h:commandButton>
				</h:panelGroup> <f:verbatim></td>
			</tr>
	    </table>
	   
	
		<table width="100%" border="1" align="center" class="table02" >
			<tr>
				<td></f:verbatim> <x:dataTable value="#{compPersonBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="办公电话" />
						</c:facet>
						<h:outputText value="#{list.officeTel}" />
					</h:column>


 

					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.qq}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="eMail" />
						</c:facet>
						<h:outputText value="#{list.email}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="MSN" />
						</c:facet>
						<h:outputText value="#{list.msn}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="职位" />
						</c:facet>
						<h:outputText value="#{list.duty}" />
					</h:column>

					<h:column  rendered="#{compPersonBB.flag == 1}">
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return showDetail('#{list.personId}') ;" value="查看"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return updatePerson('#{list.personId}');" value="修改"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01"
							onclick="return confirm('确定要删除吗？');"
							action="#{compPersonBB.deleteCompPersonBO}" value="删除">
							<x:updateActionListener value="#{list.personId}"
								property="#{compPersonBB.compPersonBO.personId}"></x:updateActionListener>
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









