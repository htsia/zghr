<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function checkin(){
		window.showModalDialog(
						"/custom/att/attEleCheckinEdit.jsf?act=init",
						null,
						"dialogWidth:400px; dialogHeight:230px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
</script>
<x:saveState value="#{att_logMrgBB}" />
<h:inputHidden value="#{att_logMrgBB.pageInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{att_logMrgBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{att_logMrgBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="ǩ��" onclick="checkin();"/>
			<h:outputText value="  "/>
			<h:outputText value=" Ա����Ż�����:"/>
			<h:inputText value="#{att_logMrgBB.nameStr}" styleClass="input" size="20"/>
			<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{att_logMrgBB.queryLog}"/>
			<h:commandButton styleClass="button01" value="��ѯ" action="#{att_logMrgBB.queryLog}"/>
			<h:outputText value="  "/>
			<h:outputText
				value="��¼��:#{att_logMrgBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{att_logMrgBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{att_logMrgBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="��ǰΪ��#{att_logMrgBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{att_logMrgBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{att_logMrgBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{att_logMrgBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{att_logMrgBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{att_logMrgBB.logList}"
				headerClass="td_top" rowIndexVar="index" var="log"
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
					<h:outputText value="#{log.personSeq}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{log.name}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ա���" />
					</f:facet>
					<h:outputText value="#{log.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��������" />
					</f:facet>
					<h:outputText value="#{log.secDeptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ڲ���" />
					</f:facet>
					<h:outputText value="#{log.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{log.date}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="ʱ��" />
					</f:facet>
					<h:outputText value="#{log.time}"></h:outputText>
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
