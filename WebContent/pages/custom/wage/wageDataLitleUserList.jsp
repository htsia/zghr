<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	<%
		Date d = new Date();
	%>
	function adduser(){
		var ids = window.showModalDialog(
			"/custom/selPerson.jsf?itemType="+document.all("form1:itemType").value,
			null,
			"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIds').value=ids;
			return true;
		}else{
			return false;
		}
	}		
	function modifyuser(userID,itemType){
		window.showModalDialog(
			"/custom/wage/wageDataLitleUserEdit.jsf?userID="+userID+"&itemType="+itemType,
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
	function batchUpdateMoney(){
		if(confirm('ȷ�������޸Ľ����?')){
			var m = document.all("form1:batchMoney").value;
			m=$.trim(m);
			if(m=='' || isNaN(m)){
				alert("���ӦΪ����");
				return false;
			}
			return true;
		}
		return false;
	}
	function seldate(){
		var month = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp?month=<%=d.getMonth()%>",null,"dialogWidth:250px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
		if(month!=null){
			document.all("form1:operYearMonth").value=month;
			return true;
		}
		return false;
	}
	function checkSubmit() {
        var filename = form1.all("form1:excelFile").value;
        if (filename.substr(filename.length - 3).toLowerCase() != 'xls') {
            alert("��ѡ��xls�ļ���");
            return false;
        } 
        process();
		return true;
    }
	function process(){
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
    }
</script>
<x:saveState value="#{wage_dataLitleBB}" />
<h:inputHidden value="#{wage_dataLitleBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="itemType" value="#{wage_dataLitleBB.itemType}"/>
	<h:inputHidden id="operYearMonth" value="#{wage_dataLitleBB.operYearMonth}"/>
	<h:inputHidden id="selectedUserIds" value="#{wage_dataLitleBB.selectedUserIds}"/>
	<h:inputHidden id="personType" value="#{wage_dataLitleBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_dataLitleBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="98%" align="center">
		<h:panelGrid columns="1" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="�����Ա" onclick="return adduser();"
				action="#{wage_dataLitleBB.adduser}"/>
			<h:commandButton styleClass="button01" onclick="return confirm('ȷ�������Ա��?');" value="�����Ա" action="#{wage_dataLitleBB.deleteAllUser}"/>
				<h:outputText value="  "/>
			<h:panelGroup>
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_dataLitleBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="�ϴ���Ա" action="#{wage_dataLitleBB.uploadFile}"
	                             onclick="return checkSubmit();"/>
	        </h:panelGroup>
			<h:outputText value="  "/>
			<h:outputText value="��������"/>
			<h:inputText value="#{wage_dataLitleBB.nameStr}" styleClass="input" size="10"/>
			<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{wage_dataLitleBB.doQuery}"/>
			<h:commandButton styleClass="button01" value="��ѯ" action="#{wage_dataLitleBB.doQuery}"/>
			<h:outputText value=" "/>
			
			<h:inputText id="batchMoney" value="#{wage_dataLitleBB.operMoney}" styleClass="input" size="5"/>
			<h:commandButton styleClass="button01" value="�����޸Ľ��" onclick="return batchUpdateMoney();"
				action="#{wage_dataLitleBB.batchUpdateMoney}"/>
			<h:outputText value="  "/>
			
			<h:commandButton styleClass="button01" onclick="return seldate();" value="���ݹ鵵" action="#{wage_dataLitleBB.updateLitleDate}"/>
		</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
		<h:panelGroup>
			<h:outputText
				value="��¼��:#{wage_dataLitleBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{wage_dataLitleBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{wage_dataLitleBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="��ǰΪ��#{wage_dataLitleBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{wage_dataLitleBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{wage_dataLitleBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{wage_dataLitleBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{wage_dataLitleBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		</h:panelGrid>	
		<x:dataTable value="#{wage_dataLitleBB.userList}"
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
				<h:outputText value="#{user.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ա�����" />
				</f:facet>
				<h:outputText value="#{user.personCode}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ա���" />
				</f:facet>
				<h:outputText value="#{user.personType}"></h:outputText>
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
				<h:outputText value="#{user.statusDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:commandButton styleClass="button01" value="�޸�" onclick="modifyuser('#{user.ID}','#{wage_dataLitleBB.itemType}')"/> 
				<h:commandButton styleClass="button01" onclick="return confirm('ȷ��ɾ����?');" value="ɾ��"  action="#{wage_dataLitleBB.deleteUser}">
					<x:updateActionListener property="#{wage_dataLitleBB.operUserID}" value="#{user.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>


