<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	
	function modifyuser(userID,money){
		window.showModalDialog(
						"/custom/wage/wageDataSigleUserModify.jsf?userID="+userID+"&itemType="+document.all("form1:itemType").value+"&orgID="+document.all("form1:orgID").value+"&money="+money,
						null,
						"dialogWidth:300px; dialogHeight:120px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function verifydata(itemType){
		window.showModalDialog("/custom/wage/wageDataSigleDetail.jsf?isVerify=1&itemType="+document.all("form1:itemType").value,null,"dialogWidth:1100px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");				
	}
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
	function checkSubmit() {
        var filename = form1.all("form1:excelFile").value;
        if (filename.substr(filename.length - 3).toLowerCase() != 'xls') {
            alert("��ѡ��xls�ļ���");
            return false;
        }
		return true;
    }
</script>
<x:saveState value="#{wage_dataSigleBB}" />
<h:inputHidden value="#{wage_dataSigleBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="itemType" value="#{wage_dataSigleBB.itemType}"/>
	<h:inputHidden id="orgID" value="#{wage_dataSigleBB.orgID}"/>
	<h:inputHidden id="personType" value="#{wage_dataSigleBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_dataSigleBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
<%-- 			<h:commandButton value="�������" styleClass="button01" rendered="#{wage_dataSigleBB.inself!='1'}" onclick="verifydata('#{wage_dataSigleBB.itemType}');"/> --%>
			<h:commandButton value="ȫ������" onclick="return confirm('ȷ��������');" styleClass="button01"
					action="#{wage_dataSigleBB.updateWageDataSigle}" rendered="#{wage_dataSigleBB.inself==0}"/>
			<h:commandButton value="ȫ���˻�" onclick="return confirm('ȷ���˻���');" styleClass="button01"
					action="#{wage_dataSigleBB.deleteWageDataSigle}" rendered="#{wage_dataSigleBB.inself==0}"/>
			<h:outputText value=" "/>
			<h:outputText value="  "/>
			<h:selectBooleanCheckbox value="#{wage_dataSigleBB.verifyFlag}" onclick="submit();" valueChangeListener="#{wage_dataSigleBB.chengeVerifyFlag}">
				<h:outputText value=" δ���"/>
			</h:selectBooleanCheckbox>
			<h:outputText value=" Ա����Ż�����:"/>
			<h:inputText value="#{wage_dataSigleBB.nameStr}" styleClass="input" size="10"/>
			<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{wage_dataSigleBB.queryUser}"/>
			<h:commandButton styleClass="button01" value="��ѯ" action="#{wage_dataSigleBB.queryUser}"/>
			<h:outputText value="  "/>
			<h:panelGroup rendered="#{wage_dataSigleBB.isVerify!='1'}">
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
				<h:outputText value="  �ϴ��ļ�"/>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_dataSigleBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="�ϴ�" action="#{wage_dataSigleBB.uploadFile}"
	                             onclick="return checkSubmit();"/>
	        </h:panelGroup>
		</h:panelGroup>
        <h:panelGrid align="right">
        	<h:panelGroup>
				<h:outputText
					value="��¼��:#{wage_dataSigleBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{wage_dataSigleBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{wage_dataSigleBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{wage_dataSigleBB.mypage.currentPage}ҳ"></h:outputText>
	
				<h:commandButton value="��ҳ" action="#{wage_dataSigleBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataSigleBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataSigleBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{wage_dataSigleBB.last}"
					styleClass="button01"></h:commandButton>
        	</h:panelGroup>
        </h:panelGrid>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{wage_dataSigleBB.userList}"
				headerClass="td_top" rowIndexVar="index" var="user" id="dateList"
				styleClass="table03" border="1" width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{user.userName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="Ա�����" />
					</f:facet>
					<h:outputText value="#{user.userCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ա���" />
					</f:facet>
					<h:outputText value="#{user.userType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ڲ���" />
					</f:facet>
					<h:outputText value="#{user.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{user.money}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="״̬" />
					</f:facet>
					<h:outputText value="#{user.status}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:commandButton styleClass="button01" value="�޸Ľ��" onclick="modifyuser('#{user.userID}','#{user.money}')" rendered="#{wage_dataSigleBB.inself==1}"/>
					<h:commandButton rendered="#{wage_dataSigleBB.inself==0}" value="����" onclick="return confirm('ȷ��������');" styleClass="button01" action="#{wage_dataSigleBB.updateWageDataSigle}">
						<x:updateActionListener value="#{user.userID}" property="#{wage_dataSigleBB.operUserID}"/>
					</h:commandButton>
					<h:commandButton rendered="#{wage_dataSigleBB.inself==0}" value="�˻�" onclick="return confirm('ȷ���˻���');" styleClass="button01" action="#{wage_dataSigleBB.deleteWageDataSigle}">
						<x:updateActionListener value="#{user.userID}" property="#{wage_dataSigleBB.operUserID}"/>
					</h:commandButton>
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
