<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	<%
		Date d = new Date();
	%>
	function adduser(){
		window.showModalDialog(
			"/custom/wage/wageEmpUserEdit.jsf",
			null,
			"dialogWidth:350px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
	}		
	function edituser(){
		var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selId+=item[i].value+",";    
                }
            }
        }
        if(selId==""){
        	alert("��ѡ����Ա");
        	return false;
        }else{
        	selId = selId.substr(0, selId.length - 1);
	        if(selId.indexOf(",")==-1){
				window.showModalDialog(
					"/custom/wage/wageEmpUserEdit.jsf?userID="+selId,
					null,
					"dialogWidth:350px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
	        }else{
	        	alert("ֻ��ѡ��һ��");
	        	return false;
	        }
        }
	}		
	function editWage(){
		if(selPerson){
			window.showModalDialog(
				"/custom/wage/wageEmpWageEdit.jsf?ids="+document.all("form1:selectedUserIDs").value,
				null,
				"dialogWidth:350px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		}
		return false;
	}
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'0135700572,0135700573,0135700574');
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
		return true;
    }
	function selPerson(){
	    var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selId+=item[i].value+",";    
                }
            }
        }
        if(selId==""){
        	alert("��ѡ����Ա");
        	return false;
        }
        document.all("form1:selectedUserIds").value=selId;
        return true;
	}
	function submitWage(){
		if(selPerson()){
			return true;
		}
		return false;
	}
	function passWage(){
		if(selPerson()){
			var month = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp?month=<%=d.getMonth()%>",null,"dialogWidth:250px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
			if(month!=null){
				document.all("form1:operYearMonth").value=month;
				return true;
			}
			return false;
		}
		return false;
	}
</script>
<x:saveState value="#{wage_empBB}" />
<h:inputHidden value="#{wage_empBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="operYearMonth" value="#{wage_empBB.operYearMonth}"/>
	<h:inputHidden id="selectedUserIds" value="#{wage_empBB.selectedUserIds}"/>
	<h:inputHidden id="personType" value="#{wage_empBB.personType}"/>
	<h:inputHidden id="personTypeValue" value=""/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="���" onclick="return adduser();"/>
				<h:commandButton styleClass="button01" value="�޸�" onclick="return edituser();"/>
				<h:outputText value="  "/>
				<h:outputText value="�й���"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.hasWage}" onclick="submit();" valueChangeListener="#{wage_empBB.setHasWage}"/>
				<h:outputText value="�޹���"/>
                <h:selectBooleanCheckbox value="#{wage_empBB.noWage}" onclick="submit();" valueChangeListener="#{wage_empBB.setNoWage}"/>
				<h:outputText value="��Ż�����"/>
				<h:inputText value="#{wage_empBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{wage_empBB.doQuery}"/>
				<h:commandButton styleClass="button01" value="��ѯ" action="#{wage_empBB.doQuery}"/>
				<h:outputText value=" "/>
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="����ģ��  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_empBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="���빤��" action="#{wage_empBB.uploadFile}" onclick="return checkSubmit();"/>
				<h:inputText value="#{wage_empBB.wage}" styleClass="input" size="5"/>
				<h:commandButton styleClass="button01" value="�趨����" onclick="return selPerson();" action="#{wage_empBB.setWage}"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="����Ϊexcel" action="#{wage_empBB.exportExcel}"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="�ύ" onclick="return submitWage();" rendered="#{wage_empBB.inself==1}" action="#{wage_empBB.submitWage}"/>
				<h:commandButton styleClass="button01" value="���" onclick="return passWage();" rendered="#{wage_empBB.inself!=1}" action="#{wage_empBB.passWage}"/>
				<h:commandButton styleClass="button01" value="��������" rendered="#{wage_empBB.inself!=1}" action="#{wage_empBB.addToWageset}"/>
		    </h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText value="��¼��:#{wage_empBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="ҳ��:#{wage_empBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="ÿҳ��#{wage_empBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText
					value="��ǰΪ��#{wage_empBB.mypage.currentPage}ҳ"></h:outputText>
	
				<h:commandButton value="��ҳ" action="#{wage_empBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_empBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{wage_empBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{wage_empBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" width="100%" align="center">
		 <x:dataTable value="#{wage_empBB.list}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
		        <f:facet name="header">
		            <f:verbatim escape="false">
		                <input type="checkbox" name="all"
		                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
		            </f:verbatim>
		        </f:facet>
		        <f:verbatim escape="false">
		            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.ID}"/><f:verbatim escape="false">"/></div></f:verbatim>
		    </h:column>
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
					<h:outputText value="���֤��" />
				</f:facet>
				<h:outputText value="#{list.cardNO}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���п���" />
				</f:facet>
				<h:outputText value="#{list.bankNO}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ѧ��" />
				</f:facet>
				<h:outputText value="#{list.xueliDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ѧλ" />
				</f:facet>
				<h:outputText value="#{list.xueweiDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ְ��" />
				</f:facet>
				<h:outputText value="#{list.zhichengDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ְ�Ƶȼ�" />
				</f:facet>
				<h:outputText value="#{list.zhichengLevelDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ְ������" />
				</f:facet>                  
				<h:outputText value="#{list.zhichengXulieDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:outputText value="#{list.wage}"></h:outputText>
			</h:column>
			<h:column rendered="#{wage_empBB.inself!=1}">
				<f:facet name="header">
					<h:outputText value="�����·�" />
				</f:facet>
				<h:outputText value="#{list.yearMonth}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="״̬" />
				</f:facet>
				<h:outputText value="#{list.status}"></h:outputText>
			</h:column>
		</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>