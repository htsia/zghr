<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function confirmDel() {
    if (checkMutilSelect(form1.selected_ids)) {
            return true;
    }else{
        alert("����ѡ����Ա��");
        return false;
    }
}
</script>
<x:saveState value="#{group_mgr_listBB}" />
<h:form id="form1">
	<h:inputHidden value="#{group_mgr_listBB.initItem}"></h:inputHidden>
	<h:inputHidden id="groupId" value="#{group_mgr_listBB.groupId}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:outputText value="��¼��:#{group_mgr_listBB.mypage1.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{group_mgr_listBB.mypage1.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{group_mgr_listBB.mypage1.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="��ǰΪ��#{group_mgr_listBB.mypage1.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{group_mgr_listBB.first1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{group_mgr_listBB.pre1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{group_mgr_listBB.next1}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{group_mgr_listBB.last1}"
					styleClass="button01"></h:commandButton>
				<h:outputText value="  "></h:outputText>
				<h:commandButton styleClass="button01" value="ȷ�������Ա"
					action="#{group_mgr_listBB.openUser}" onclick="return confirmDel()" />
				<h:commandButton styleClass="button01" value="�˳�"
					onclick="window.close();" />
			</h:panelGroup>
		</h:panelGrid>

		<x:dataTable value="#{group_mgr_listBB.itemList}" headerClass="td_top"
			id="dateList" rowIndexVar="index" var="briefList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{briefList.id}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ա�����" />
				</f:facet>
				<h:outputText value="#{briefList.personSeq}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:outputText value="#{briefList.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڿ���" />
				</f:facet>
				<h:outputText value="#{briefList.card}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" />
				</f:facet>
				<h:outputText value="#{briefList.orgName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڲ���" />
				</f:facet>
				<h:outputText value="#{briefList.deptName}"></h:outputText>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
