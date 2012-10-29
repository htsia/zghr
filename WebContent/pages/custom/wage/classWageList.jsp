<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
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
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
	function checkSubmit() {
        var filename = document.all("form1:excelFile").value;
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
	function editWageUser(id){
		window.showModalDialog(
			"/custom/wage/classWageUserEdit.jsf?subID="+id,
			null,
			"dialogWidth:350px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function exportExcel(){
    	window.open("/pages/custom/wage/exportClassWage.jsp");
    }
</script>
<x:saveState value="#{classWageBB}" />
<h:inputHidden value="#{classWageBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="selectedUserIDs" value="#{classWageBB.selectedUserIDs}"/>
	<h:inputHidden id="personType" value="#{classWageBB.personType}"/>
	<h:inputHidden id="personTypeValue" value=""/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="�����Ա" onclick="return adduser();" action="#{classWageBB.addUser}"/>
				<h:outputText value="  "/>
				<h:outputText value="��Ż�����"/>
				<h:inputText value="#{classWageBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{classWageBB.doQuery}"/>
				<h:commandButton styleClass="button01" value="��ѯ" action="#{classWageBB.doQuery}"/>
				<h:outputText value=" "/>
				<h:outputLink value="/pages/custom/wage/importClass.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{classWageBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="����" action="#{classWageBB.uploadFile}" onclick="return checkSubmit();"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="���㳬��ʱ����" onclick="process();" action="#{classWageBB.calcClassWage}"
					rendered="#{classWageBB.inself!='1'}"/>
				<h:commandButton value=" ����Excel"  styleClass="button01"  onclick="exportExcel();" type="button" rendered="#{classWageBB.inself!='1'}"/>
		    </h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText value="��¼��:#{classWageBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="ҳ��:#{classWageBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="ÿҳ��#{classWageBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText
					value="��ǰΪ��#{classWageBB.mypage.currentPage}ҳ"></h:outputText>
	
				<h:commandButton value="��ҳ" action="#{classWageBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{classWageBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{classWageBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{classWageBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" width="100%" align="center">
		 <x:dataTable value="#{classWageBB.list}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:outputText value="#{list.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ա�����" />
				</f:facet>
				<h:outputText value="#{list.personCode}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ա���" />
				</f:facet>
				<h:outputText value="#{list.personType}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" />
				</f:facet>
				<h:outputText value="#{list.secDeptName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڲ���" />
				</f:facet>
				<h:outputText value="#{list.deptName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ְ�Ƶȼ�" />
				</f:facet>
				<h:outputText value="#{list.level}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ָ��ְ�Ƶȼ�" />
				</f:facet>
				<h:outputText value="#{list.level2}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ѧ��" />
				</f:facet>
				<h:outputText value="#{list.xueli}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" />
				</f:facet>
				<h:outputText value="#{list.classNum}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ӧ������ʱ����" />
				</f:facet>
				<h:outputText value="#{list.wage}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����˰" />
				</f:facet>
				<h:outputText value="#{list.reduce}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ʵ������ʱ����" />
				</f:facet>
				<h:outputText value="#{list.realwage}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="¼����" />
				</f:facet>
				<h:outputText value="#{list.createUserID}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:commandButton styleClass="button01" value="�޸�" onclick="return editWageUser('#{list.subID}');"/>				
				<h:commandButton styleClass="button01" value="ɾ��" onclick="return confirm('ȷ��ɾ����')" action="#{classWageBB.deleteUser}">
					<x:updateActionListener value="#{list.subID}" property="#{classWageBB.operUserID}"></x:updateActionListener>
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