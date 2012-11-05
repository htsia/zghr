<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function adduser(){
		var ids = window.showModalDialog(
						"/custom/selPerson.jsf",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIDs').value=ids;
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
</script>
<x:saveState value="#{att_class_set_childBB}" />
<h:inputHidden value="#{att_class_set_childBB.addPersonInit}"/>
<h:form id="form1">
	<h:inputHidden id="selectedUserIDs" value="#{att_class_set_childBB.selectedUserIDs}"/>
	<h:inputHidden id="personType" value="#{att_class_set_childBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{att_class_set_childBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="添加人员" onclick="return adduser();"
				action="#{att_class_set_childBB.saveSelectedPerson}"/>
			<h:outputText value=" "/>
			<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{wage_dataSigleBB.queryUser}"/>
			<h:outputText value=" 员工编号或姓名:"/>
			<h:inputText value="#{wage_dataSigleBB.nameStr}" styleClass="input" size="20"/>
			<h:commandButton styleClass="button01" value="查询" action="#{att_class_set_childBB.queryUser"/>
			<h:outputText value="  "/>
			<h:outputText
				value="记录数:#{att_class_set_childBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{att_class_set_childBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{att_class_set_childBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="当前为第#{att_class_set_childBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{att_class_set_childBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{att_class_set_childBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{att_class_set_childBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{att_class_set_childBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
			
		<x:dataTable value="#{att_class_set_childBB.personList}"
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
				<h:outputText value="#{user.bianhao}"></h:outputText>
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
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除"  action="#{att_class_set_childBB.deletePerson}">
					<x:updateActionListener property="#{att_class_set_childBB.operClassUserID}" value="#{user.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
		<h:panelGrid align="right">
	<h:commandButton styleClass="button01" value="确定" action="#{att_class_set_childBB.colse1 }">			
				</h:commandButton>
	</h:panelGrid>
	</h:panelGrid>
	
</h:form>


