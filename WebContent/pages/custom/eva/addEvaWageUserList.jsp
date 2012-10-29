<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var item = document.getElementsByName("selectItem");
        var selIDs="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selIDs+=item[i].value+",";    
                }
            }
        }
        if(selIDs==""){
        	alert("请选择人员");
        	return false;
        }
        window.returnValue=selIDs;
		this.close();
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
<x:saveState value="#{evaWageBB}" />
<h:inputHidden value="#{evaWageBB.addUserInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{evaWageBB.personType}"/>
	<h:inputHidden id="personTypeValue" value=""/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:outputText value="编号或姓名"/>
				<h:inputText value="#{evaWageBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{evaWageBB.doQueryUser}"/>
				<h:commandButton styleClass="button01" value="查询" action="#{evaWageBB.doQueryUser}"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="确定" onclick="return forsave();"/>
		    </h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText value="记录数:#{evaWageBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="页数:#{evaWageBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText value="每页有#{evaWageBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "/>
				<h:outputText
					value="当前为第#{evaWageBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{evaWageBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{evaWageBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{evaWageBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{evaWageBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" width="100%" align="center">
		 <x:dataTable value="#{evaWageBB.userList}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
		        <f:facet name="header">
		            <f:verbatim escape="false">
		                <input type="checkbox" name="all"
		                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
		            </f:verbatim>
		        </f:facet>
		        <f:verbatim escape="false">
		            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.userID}"/><f:verbatim escape="false">"/></div></f:verbatim>
		    </h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{list.name}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{list.personSeq}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人员类别" />
				</f:facet>
				<h:outputText value="#{list.personType}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="二级部门" />
				</f:facet>
				<h:outputText value="#{list.secondDeptName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所在部门" />
				</f:facet>
				<h:outputText value="#{list.deptName}"></h:outputText>
			</h:column>
		</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>