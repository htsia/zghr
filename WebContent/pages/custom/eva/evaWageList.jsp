<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function adduser(){
		var ids= window.showModalDialog(
			"/custom/eva/addEvaWageUserIndex.jsf",
			null,
			"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all("form1:selectedUserIDs").value=ids;
			return true;
		}
		return false;
	}
	function setXishu(){
		window.showModalDialog(
			"/custom/eva/setEvaWageXishu.jsf",
			null,
			"dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
	}		
	function setKoushui(){
		window.showModalDialog(
			"/custom/eva/setEvaWageKoushui.jsf",
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
        var filename = document.all("form1:excelFile").value;
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
	function editEvaUser(id){
		window.showModalDialog(
			"/custom/eva/evaWageEdit.jsf?subID="+id,
			null,
			"dialogWidth:350px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function exportExcel(){
    	window.open("/pages/custom/eva/exportEvaWage.jsp");
    }
</script>
<x:saveState value="#{evaWageBB}" />
<h:inputHidden value="#{evaWageBB.pageInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="selectedUserIDs" value="#{evaWageBB.selectedUserIDs}"/>
	<h:inputHidden id="personType" value="#{evaWageBB.personType}"/>
	<h:inputHidden id="personTypeValue" value=""/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="添加未考核人员" onclick="return adduser();" action="#{evaWageBB.addEvaUser}"/>
				<h:outputText value="  "/>
				<h:outputText value="编号或姓名"/>
				<h:inputText value="#{evaWageBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{evaWageBB.doQuery}"/>
				<h:commandButton styleClass="button01" value="查询" action="#{evaWageBB.doQuery}"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="扣税办法" onclick="return setKoushui();"/>
				<h:commandButton styleClass="button01" value="设定系数" onclick="return setXishu();"/>
				<h:outputText value=" "/>
				<h:outputLink value="/pages/custom/eva/import.xls" target="_new">
					<h:outputText value="下载模板  " />
				</h:outputLink>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{evaWageBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="导入出勤率" action="#{evaWageBB.uploadFile}" onclick="return checkSubmit();"/>
				<h:commandButton styleClass="button01" value="同步出勤率" action="#{evaWageBB.updateChuqinlv}"/>
				<h:outputText value=" "/>
				<h:commandButton styleClass="button01" value="核算绩效工资" onclick="process();" action="#{evaWageBB.updateEvaWage}"/>
				<h:commandButton value=" 导出Excel"  styleClass="button01"  onclick="exportExcel();" type="button"/>
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
		 <x:dataTable value="#{evaWageBB.list}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
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
				<h:outputText value="#{list.personCode}"></h:outputText>
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
				<h:outputText value="#{list.secDeptDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="所在部门" />
				</f:facet>
				<h:outputText value="#{list.deptDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考核名称" />
				</f:facet>
				<h:outputText value="#{list.evaName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考核类别" />
				</f:facet>
				<h:outputText value="#{list.evaType}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考核结果" />
				</f:facet>
				<h:outputText value="#{list.result}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考核结果等级" />
				</f:facet>
				<h:outputText value="#{list.resultLevel}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="数据来源" />
				</f:facet>
				<h:outputText value="#{list.comeDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="出勤率" />
				</f:facet>
				<h:outputText value="#{list.chuqinlv}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="考核系数" />
				</f:facet>
				<h:outputText value="#{list.xishu}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="应发绩效工资" />
				</f:facet>
				<h:outputText value="#{list.evaWage}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="绩效工资扣税" />
				</f:facet>
				<h:outputText value="#{list.evaReduceWage}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="实发绩效工资" />
				</f:facet>
				<h:outputText value="#{list.evaRealWage}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" value="修改" onclick="return editEvaUser('#{list.subID}');"/>				
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


