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
	function modify(id) {
        window.showModalDialog("/custom/attence/attCalcResultEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
	function dimission(id) {
        window.showModalDialog("/custom/attence/attCalcDimissionEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.editInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attCalcMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attCalcMgrBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton value="�ύ" onclick="return confirm('ȷ���ύ��');" styleClass="button01"
					action="#{attCalcMgrBB.submit}"/>
			<h:outputText value="  "/>
			<h:outputText value=" Ա����Ż�����:"/>
			<h:inputText value="#{attCalcMgrBB.nameStr}" styleClass="input" size="20"/>
			<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attCalcMgrBB.doEditQuery}"/>
			<h:commandButton styleClass="button01" value="��ѯ" action="#{attCalcMgrBB.doEditQuery}"/>
			<h:outputText value="  "/>
			<h:outputText
				value="��¼��:#{attCalcMgrBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{attCalcMgrBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{attCalcMgrBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="��ǰΪ��#{attCalcMgrBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{attCalcMgrBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{attCalcMgrBB.editList}"
				headerClass="td_top" rowIndexVar="index" var="editList"
				styleClass="table03" border="1" width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="Ա�����" />
					</f:facet>
					<h:outputText value="#{editList.personCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{editList.personName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ա���" />
					</f:facet>
					<h:outputText value="#{editList.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��������" />
					</f:facet>
					<h:outputText value="#{editList.secDeptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ڲ���" />
					</f:facet>
					<h:outputText value="#{editList.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�ٵ�" />
					</f:facet>
					<h:outputText value="#{editList.lateTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{editList.awayTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�¼�" />
					</f:facet>
					<h:outputText value="#{editList.leaveReasons}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{editList.leaveSick}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{editList.leaveMaternity}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{editList.leaveWedding}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="̽�׼�" />
					</f:facet>
					<h:outputText value="#{editList.leaveHome}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���˼�" />
					</f:facet>
					<h:outputText value="#{editList.leaveIndustrialInjury}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="ɥ��" />
					</f:facet>
					<h:outputText value="#{editList.leaveArrangingFuneral}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{editList.outWorkValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�Ӱ�" />
					</f:facet>
					<h:outputText value="#{editList.workAddValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��ְ" />
					</f:facet>
					<h:outputText value="#{editList.dimissionDesc}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��ְʱ��" />
					</f:facet>
					<h:outputText value="#{editList.dimissionDate}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:commandButton value="�޸�" onclick="modify('#{editList.subID}');" styleClass="button01" />
				</h:column>
				<h:column>
					<h:commandButton value="��ְ����" onclick="dimission('#{editList.subID}');" styleClass="button01" />
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
