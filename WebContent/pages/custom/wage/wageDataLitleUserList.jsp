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
		if(confirm('确定批量修改金额吗?')){
			var m = document.all("form1:batchMoney").value;
			m=$.trim(m);
			if(m=='' || isNaN(m)){
				alert("金额应为数字");
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
            alert("请选择xls文件！");
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
			<h:commandButton styleClass="button01" value="添加人员" onclick="return adduser();"
				action="#{wage_dataLitleBB.adduser}"/>
			<h:commandButton styleClass="button01" onclick="return confirm('确定清空人员吗?');" value="清空人员" action="#{wage_dataLitleBB.deleteAllUser}"/>
				<h:outputText value="  "/>
			<h:panelGroup>
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="下载模板  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_dataLitleBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="上传人员" action="#{wage_dataLitleBB.uploadFile}"
	                             onclick="return checkSubmit();"/>
	        </h:panelGroup>
			<h:outputText value="  "/>
			<h:outputText value="姓名或编号"/>
			<h:inputText value="#{wage_dataLitleBB.nameStr}" styleClass="input" size="10"/>
			<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{wage_dataLitleBB.doQuery}"/>
			<h:commandButton styleClass="button01" value="查询" action="#{wage_dataLitleBB.doQuery}"/>
			<h:outputText value=" "/>
			
			<h:inputText id="batchMoney" value="#{wage_dataLitleBB.operMoney}" styleClass="input" size="5"/>
			<h:commandButton styleClass="button01" value="批量修改金额" onclick="return batchUpdateMoney();"
				action="#{wage_dataLitleBB.batchUpdateMoney}"/>
			<h:outputText value="  "/>
			
			<h:commandButton styleClass="button01" onclick="return seldate();" value="数据归档" action="#{wage_dataLitleBB.updateLitleDate}"/>
		</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
		<h:panelGroup>
			<h:outputText
				value="记录数:#{wage_dataLitleBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{wage_dataLitleBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{wage_dataLitleBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="当前为第#{wage_dataLitleBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{wage_dataLitleBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{wage_dataLitleBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{wage_dataLitleBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{wage_dataLitleBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		</h:panelGrid>	
		<x:dataTable value="#{wage_dataLitleBB.userList}"
			headerClass="td_top" rowIndexVar="index" var="user" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="序号" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{user.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{user.personCode}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人员类别" />
				</f:facet>
				<h:outputText value="#{user.personType}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所在部门" />
				</f:facet>
				<h:outputText value="#{user.deptName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="金额" />
				</f:facet>
				<h:outputText value="#{user.money}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="状态" />
				</f:facet>
				<h:outputText value="#{user.statusDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" value="修改" onclick="modifyuser('#{user.ID}','#{wage_dataLitleBB.itemType}')"/> 
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除"  action="#{wage_dataLitleBB.deleteUser}">
					<x:updateActionListener property="#{wage_dataLitleBB.operUserID}" value="#{user.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>


