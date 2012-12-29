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
		window.showModalDialog(
			"/custom/wage/wageEmpUserEdit.jsf",
			null,
			"dialogWidth:350px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}		
	function edit(userID){
		window.showModalDialog(
					"/custom/wage/wageEmpUserEdit.jsf?userID="+userID,
					null,
					"dialogWidth:350px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}		
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'0135700572,0135700574');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
	function checkSubmit() {
        var filename = document.all("form1:excelFile").value;
        if (filename.substr(filename.length - 3).toLowerCase() != 'xls') {
            alert("��ѡ��xls�ļ�");
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
<x:saveState value="#{wage_empBB}" />
<h:inputHidden value="#{wage_empBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="personType" value="#{wage_empBB.personType}"/>
	<h:inputHidden id="personTypeValue" value=""/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="���" onclick="return adduser();"/>
				<h:outputText value="  "/>
				<h:outputText value="�й���"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.hasWage}" onclick="submit();" valueChangeListener="#{wage_empBB.setHasWage}"/>
				<h:outputText value="�޹���"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.noWage}" onclick="submit();" valueChangeListener="#{wage_empBB.setNoWage}"/>
				<h:outputText value="���ֽ�"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.hasCash}" onclick="submit();" valueChangeListener="#{wage_empBB.setHasCash}"/>
				<h:outputText value="�����ֽ�"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.hasNoCash}" onclick="submit();" valueChangeListener="#{wage_empBB.setHasNoCash}"/>
				<h:outputText value="��Ż�����"/>
				<h:inputText value="#{wage_empBB.nameStr}" styleClass="input" size="5"/>
				<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{wage_empBB.doQuery}"/>
				<h:commandButton styleClass="button01" value="��ѯ" action="#{wage_empBB.doQuery}"/>
				<h:outputText value=" "/>
				<h:outputLink value="/pages/custom/wage/importEmp.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_empBB.excelFile}" storage="file" size="5"/>
	            <h:outputText value="�������"/>
	            <h:selectOneMenu value="#{wage_empBB.importType}" >
		        	<c:selectItem itemLabel="��ְ��ʦ" itemValue="0135700574"/>
		        	<c:selectItem itemLabel="��Ŀ��" itemValue="0135700572"/>
		        </h:selectOneMenu>
	            <h:commandButton styleClass="button01" value="����" action="#{wage_empBB.uploadFile}" onclick="return checkSubmit();"/>
	        </h:panelGroup>
		 </h:panelGrid>
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="������Ŀ��������" onclick="return confirm('ȷ������������?');" action="#{wage_empBB.addProToWageset}"/>
				<h:commandButton styleClass="button01" value="�����ְ��ʦ������" onclick="return confirm('ȷ�������ְ��ʦ������?');" action="#{wage_empBB.addTeaToWageset}"/>
				<h:outputText value="  "/>
				<h:commandButton styleClass="button01" value="�����ֽ���" onclick="return exportCash();"/>
				<h:outputText value="  "/>
				<h:outputText value="��¼��:#{wage_empBB.mypage.totalRecord}"/>
				<h:outputText value="  "/>
				<h:outputText value="ҳ��:#{wage_empBB.mypage.totalPage}"/>
				<h:outputText value="  "/>
				<h:outputText value="ÿҳ��#{wage_empBB.mypage.pageSize}"/>
				<h:outputText value="  "/>
				<h:outputText value="��ǰΪ��#{wage_empBB.mypage.currentPage}ҳ"/>
				<h:commandButton value="��ҳ" action="#{wage_empBB.first}"
					styleClass="button01"/>
				<h:commandButton value="��ҳ" action="#{wage_empBB.pre}"
					styleClass="button01"/>
				<h:commandButton value="��ҳ" action="#{wage_empBB.next}"
					styleClass="button01"/>
				<h:commandButton value="βҳ" action="#{wage_empBB.last}"
					styleClass="button01"/>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" width="100%" align="center">
		 <x:dataTable value="#{wage_empBB.list}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:outputText value="#{list.name}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ա�����" />
				</f:facet>
				<h:outputText value="#{list.personCode}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ա���" />
				</f:facet>
				<h:outputText value="#{list.personType}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" />
				</f:facet>
				<h:outputText value="#{list.secDeptName}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڲ���" />
				</f:facet>
				<h:outputText value="#{list.deptName}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���֤��" />
				</f:facet>
				<h:outputText value="#{list.cardNO}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���п���" />
				</f:facet>
				<h:outputText value="#{list.bankNO}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:outputText value="#{list.wage}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" />
				</f:facet>
				<h:outputText value="#{list.other}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�Ƿ��ֽ�" />
				</f:facet>
				<h:outputText value="#{list.hasCash}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:commandButton value="�޸�" styleClass="button01" onclick="return edit('#{list.ID}');"/>
				<h:commandButton value="ɾ��" onclick="return confirm('ȷ��ɾ����');" action="#{wage_empBB.delete}" styleClass="button01">
					<x:updateActionListener value="#{list.ID}" property="#{wage_empBB.operUserID}"/>
				</h:commandButton>
			</h:column>
		</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
