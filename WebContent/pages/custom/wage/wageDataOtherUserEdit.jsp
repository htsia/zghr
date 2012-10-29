<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
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
	function modifyuser(id,setID){
		window.showModalDialog(
			"/custom/wage/wageDataOtherUserModify.jsf?id="+id+"&setID="+setID,
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
<x:saveState value="#{wage_dataOtherBB}" />
<h:inputHidden value="#{wage_dataOtherBB.userInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="itemType" value="#{wage_dataOtherBB.itemType}"/>
	<h:inputHidden id="selectedUserIds" value="#{wage_dataOtherBB.selectedUserIds}"/>
	<h:inputHidden id="personType" value="#{wage_dataOtherBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_dataOtherBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="添加人员" onclick="return adduser();"
				action="#{wage_dataOtherBB.adduser}" rendered="#{wage_dataOtherBB.isView!='1'}"/>
			<h:panelGroup>
				<h:outputLink value="/pages/custom/wage/importWagePerson.xls" target="_new">
					<h:outputText value="下载模板  " />
				</h:outputLink>
				<h:outputText value="  上传文件"/>
	            <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_dataOtherBB.excelFile}" storage="file" size="10"/>
	            <h:commandButton styleClass="button01" value="上传人员" action="#{wage_dataOtherBB.uploadFile}"
	                             onclick="return checkSubmit();"/>
	        </h:panelGroup>
			<h:outputText value=" 员工编号或姓名"/>
			<h:inputText value="#{wage_dataOtherBB.nameStr}" styleClass="input" size="10"/>
			<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{wage_dataOtherBB.queryUser}"/>
			<h:commandButton styleClass="button01" value="查询" action="#{wage_dataOtherBB.queryUser}"/>
			<h:outputText value=" "/>
			
			<h:inputText id="batchMoney" value="#{wage_dataOtherBB.batchMoney}" styleClass="input" size="5" rendered="#{wage_dataOtherBB.isView!='1'}"/>
			<h:commandButton styleClass="button01" value="批量修改金额" onclick="return batchUpdateMoney();"
				action="#{wage_dataOtherBB.batchUpdateMoney}" rendered="#{wage_dataOtherBB.isView!='1'}"/>
		</h:panelGroup>
		<h:panelGrid align="right">
			<h:panelGroup>
				<h:outputText
					value="记录数:#{wage_dataOtherBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{wage_dataOtherBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{wage_dataOtherBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{wage_dataOtherBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{wage_dataOtherBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{wage_dataOtherBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{wage_dataOtherBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{wage_dataOtherBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
			
		<x:dataTable value="#{wage_dataOtherBB.userList}"
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
					<h:outputText value="二级部门" />
				</f:facet>
				<h:outputText value="#{user.secDeptName}"></h:outputText>
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
			<h:column rendered="#{wage_dataOtherBB.isView!='1'}">
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" value="修改" onclick="modifyuser('#{user.ID}','#{user.setID}')"/> 
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除"  action="#{wage_dataOtherBB.deleteUser}">
					<x:updateActionListener property="#{wage_dataOtherBB.operUserID}" value="#{user.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
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
