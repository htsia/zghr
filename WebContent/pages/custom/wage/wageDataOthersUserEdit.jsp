<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js"
	type="text/javascript"></script>
<%
	String itemID = request.getParameter("itemID");
%>
<script type="text/javascript">
	function adduser(){
		var ids = window.showModalDialog(
						"/custom/selPerson.jsf",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIds').value=ids;
			return true;
		}else{
			return false;
		}
	}
	function importData(itemID){
			window.showModalDialog("/custom/wage/wageDataOthersImportdata.jsf?itemID="+itemID,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		}
	function modifyuser(id,setID){
		window.showModalDialog(
						"/custom/wage/wageDataOthersUserModify.jsf?id="+id+"&setID="+setID,
						null,
						"dialogWidth:350px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
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
<x:saveState value="#{wage_dataOthersBB}" />
<h:inputHidden value="#{wage_dataOthersBB.userInit}" />
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="selectedUserIds"
		value="#{wage_dataOthersBB.selectedUserIds}" />
	<h:inputHidden id="personType" value="#{wage_dataOthersBB.personType}" />
	<h:inputHidden id="personTypeValue"
		value="#{wage_dataOthersBB.personTypeValue}" />
	<h:inputHidden id="itemID" value="#{wage_dataOthersBB.itemID}" />
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="�����Ա"
				onclick="return adduser();" action="#{wage_dataOthersBB.adduser}"
				rendered="#{wage_dataOthersBB.isView!='1'}" />
				<h:outputText value=" " />
				<h:outputText value="��������:" />
				<h:inputText value="#{wage_dataOthersBB.nameStr}" styleClass="input"
					size="5" />
				<h:commandButton styleClass="button01" value="��Ա���"
					onclick="return forSel();" action="#{wage_dataOthersBB.queryUser}" />
				<h:commandButton styleClass="button01" value="��ѯ"
					action="#{wage_dataOthersBB.queryUser" />
				<h:outputText value="  " />
				<h:inputText value="#{wage_dataOthersBB.averageMoney}"
					styleClass="input" size="10" />
				<h:commandButton  styleClass="button01" value="�����޸Ľ��"
					action="#{wage_dataOthersBB.averageMoney}"
					rendered="#{wage_dataOthersBB.isView!='1'}" />
	
				<h:outputText value="  " />
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
				<x:inputFileUpload id="excelFile" styleClass="input"
					value="#{wage_dataOthersBB.excelFile}" storage="file" size="10" />
				<h:commandButton styleClass="button01" value="�ϴ�"
					action="#{wage_dataOthersBB.uploadFile}" onclick="return checkSubmit();" />
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText value="��¼��:#{wage_dataOthersBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{wage_dataOthersBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{wage_dataOthersBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="��ǰΪ��#{wage_dataOthersBB.mypage.currentPage}ҳ"></h:outputText>
	
				<h:commandButton value="��ҳ" action="#{wage_dataOthersBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataOthersBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_dataOthersBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{wage_dataOthersBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
		<x:dataTable value="#{wage_dataOthersBB.userList}"
			headerClass="td_top" rowIndexVar="index" var="user" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
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
					<h:outputText value="��ע" />
				</f:facet>
				<h:outputText value="#{user.remark}"></h:outputText>
			</h:column>
			<h:column rendered="#{wage_dataOthersBB.isView!='1'}">
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:commandButton styleClass="button01" value="�޸�"
					onclick="modifyuser('#{user.ID}','#{user.setID}')" />
				<h:commandButton styleClass="button01"
					onclick="return confirm('ȷ��ɾ����?');" value="ɾ��"
					action="#{wage_dataOthersBB.deleteUser}">
					<x:updateActionListener property="#{wage_dataOthersBB.operUserID}"
						value="#{user.ID}" />
				</h:commandButton>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>


