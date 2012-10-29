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
	        alert("请选择xls文件！");
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
				<h:commandButton styleClass="button01" value="添加人员"
				onclick="return adduser();" action="#{wage_dataOthersBB.adduser}"
				rendered="#{wage_dataOthersBB.isView!='1'}" />
				<h:outputText value=" " />
				<h:outputText value="姓名或编号:" />
				<h:inputText value="#{wage_dataOthersBB.nameStr}" styleClass="input"
					size="5" />
				<h:commandButton styleClass="button01" value="人员类别"
					onclick="return forSel();" action="#{wage_dataOthersBB.queryUser}" />
				<h:commandButton styleClass="button01" value="查询"
					action="#{wage_dataOthersBB.queryUser" />
				<h:outputText value="  " />
				<h:inputText value="#{wage_dataOthersBB.averageMoney}"
					styleClass="input" size="10" />
				<h:commandButton  styleClass="button01" value="批量修改金额"
					action="#{wage_dataOthersBB.averageMoney}"
					rendered="#{wage_dataOthersBB.isView!='1'}" />
	
				<h:outputText value="  " />
				<h:outputLink value="/pages/custom/wage/import.xls" target="_new">
					<h:outputText value="下载模板  " />
				</h:outputLink>
				<x:inputFileUpload id="excelFile" styleClass="input"
					value="#{wage_dataOthersBB.excelFile}" storage="file" size="10" />
				<h:commandButton styleClass="button01" value="上传"
					action="#{wage_dataOthersBB.uploadFile}" onclick="return checkSubmit();" />
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText value="记录数:#{wage_dataOthersBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{wage_dataOthersBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{wage_dataOthersBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="当前为第#{wage_dataOthersBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{wage_dataOthersBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{wage_dataOthersBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{wage_dataOthersBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{wage_dataOthersBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
		<x:dataTable value="#{wage_dataOthersBB.userList}"
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
				<h:outputText value="#{user.userName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{user.userCode}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人员类别" />
				</f:facet>
				<h:outputText value="#{user.userType}"></h:outputText>
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
					<h:outputText value="备注" />
				</f:facet>
				<h:outputText value="#{user.remark}"></h:outputText>
			</h:column>
			<h:column rendered="#{wage_dataOthersBB.isView!='1'}">
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" value="修改"
					onclick="modifyuser('#{user.ID}','#{user.setID}')" />
				<h:commandButton styleClass="button01"
					onclick="return confirm('确定删除吗?');" value="删除"
					action="#{wage_dataOthersBB.deleteUser}">
					<x:updateActionListener property="#{wage_dataOthersBB.operUserID}"
						value="#{user.ID}" />
				</h:commandButton>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>


