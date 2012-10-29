<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script language="javascript">
function deleteNewPerson(){
  var field = form1.all('selected_ids');
  if (checkMutilSelect(field)) {
      pageCodeExchange(document.forms(0));
  } else{
      alert("��ѡ����Ա��");
      return false;
  }
}
function forSel() {
    if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
       document.forms(0).all('form1:queryPerson').click();
    }
}
</script>
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
	<h:inputHidden id="superID" value="#{personevectionBB.pageInits}"></h:inputHidden>
	<h:inputHidden id="personType" value="#{personevectionBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{personevectionBB.personTypeValue}"/>
	<h:panelGrid width="98%" columns="1" align="center">
	    <h:panelGrid columns="5" align="left">
	    <f:verbatim>
	        <input name="simple1" type="button" id=15 next=20 class="button01" value="ѡ����Ա���" onclick="forSel()">
	    </f:verbatim>
	        <h:outputText value="#{personevectionBB.personTypeDesc}"></h:outputText>
	    </h:panelGrid>
		<h:panelGrid columns="5" align="left">
			<h:outputText value="������Ա����ţ�"></h:outputText>
			<h:inputText id="classnamevalue"
				value="#{personevectionBB.findSeeValue}"></h:inputText>
			<h:commandButton id="queryPerson" value="��ѯ" styleClass="button01"
				action="#{personevectionBB.findSee}"></h:commandButton>
				 <h:commandButton styleClass="button01" value="ȷ��" action="#{personevectionBB.confirmMethod}" onclick="javascript:return deleteNewPerson();"/>
								<h:panelGroup>
							<h:outputText value="��¼��:#{personevectionBB.mypage1.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{personevectionBB.mypage1.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{personevectionBB.mypage1.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="��ǰΪ��#{personevectionBB.mypage1.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{personevectionBB.first1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{personevectionBB.pre1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{personevectionBB.next1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{personevectionBB.last1}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
		</h:panelGrid>

		<x:dataTable value="#{personevectionBB.itemList}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);"/>
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                   <h:outputText value="#{list.id}"/>
                   <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<c:facet name="header">
					<h:outputText value="��Ա���" />
				</c:facet>
				<h:outputText value="#{list.personSeq}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.name}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڿ���" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.card}" />
			</h:column>
			<h:column>
				<c:facet name="header">
					<h:outputText value="���ڻ���" />
				</c:facet>
				<h:outputText value="#{list.orgName}" />
			</h:column>
			<h:column>
				<c:facet name="header">
					<h:outputText value="���ڲ���" />
				</c:facet>
				<h:outputText value="#{list.deptName}" />
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>



