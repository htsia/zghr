<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
</script>
<x:saveState value="#{wage_dataOtherBB}" />
<h:inputHidden value="#{wage_dataOtherBB.dataInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{wage_dataOtherBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_dataOtherBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid>
			<h:panelGroup>
				<h:commandButton value="ȫ������" onclick="return confirm('ȷ��������');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataPass}"/>
				<h:commandButton value="ȫ���˻�" onclick="return confirm('ȷ���˻���');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataRollback}"/>
				<h:outputText value=" "/>
				<h:outputText value="��������"/>
				<h:inputText value="#{wage_dataOtherBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{wage_dataOtherBB.queryDataUser}"/>
				<h:commandButton styleClass="button01" value="��ѯ" action="#{wage_dataOtherBB.queryDataUser}"/>
				<h:outputText value="  "/>
				<h:outputText
					value="��¼��:#{wage_dataOtherBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{wage_dataOtherBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{wage_dataOtherBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{wage_dataOtherBB.mypage.currentPage}ҳ"></h:outputText>
	
				<h:commandButton value="��ҳ" action="#{wage_dataOtherBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataOtherBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataOtherBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{wage_dataOtherBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<x:dataTable value="#{wage_dataOtherBB.dataList}"
				headerClass="td_top" rowIndexVar="index" var="data" id="dataList"
				styleClass="table03" border="1" width="850"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ŀ����" />
					</f:facet>
					<h:outputText value="#{data.setName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{data.userName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="Ա�����" />
					</f:facet>
					<h:outputText value="#{data.userCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ա���" />
					</f:facet>
					<h:outputText value="#{data.userType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ڲ���" />
					</f:facet>
					<h:outputText value="#{data.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{data.money}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="״̬" />
					</f:facet>
					<h:outputText value="#{data.statusDesc}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��ע" />
					</f:facet>
					<h:outputText value="#{data.remark}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:commandButton value="����" onclick="return confirm('ȷ��������');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataPass}"
						rendered="#{data.status=='0'}">
						<x:updateActionListener value="#{data.userID}" property="#{wage_dataOtherBB.operUserID}"/>
						<x:updateActionListener value="#{data.setID}" property="#{wage_dataOtherBB.operSetID}"/>
					</h:commandButton>
					<h:commandButton value="�˻�" onclick="return confirm('ȷ���˻���');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataRollback}"
						rendered="#{data.status=='0'}">
						<x:updateActionListener value="#{data.userID}" property="#{wage_dataOtherBB.operUserID}"/>
						<x:updateActionListener value="#{data.setID}" property="#{wage_dataOtherBB.operSetID}"/>
					</h:commandButton>
				</h:column>
			</x:dataTable>
		</h:panelGrid>

	</h:panelGrid>
</h:form>


