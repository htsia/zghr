<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function refreshload() {
	setTimeout('myrefresh()', 1000);
}
function addDictionarys(){
    var id=document.all('form1:userID').value;
    var id1=document.all('form1:operID').value;
	if (id == null || id == "") {
		alert("请选择用户！");
		return false;
	}
	if (id1 == null || id1 == "") {
		alert("请选择要设置的权限！");
		return false;
	}
    var id2=document.all('form1:text5').value;
    var id3=document.all('form1:text5code').value;
	if (id2 != null || id2 != "") {
		document.all('form1:text5').value="";   
	}
	if (id3 != null || id3 != "") {
		document.all('form1:text5code').value="";   
	}
	PopUpRptList('form1:text5code','form1:text5','1','');
	document.all('form1:refresh').click();

   }
    function addDictionary(){
        var id=document.all('form1:userID').value;
        var id1=document.all('form1:operID').value;
    	if (id == null || id == "") {
    		alert("请选择用户！");
    		return false;
    	}
    	if (id1 == null || id1 == "") {
    		alert("请选择要设置的权限！");
    		return false;
    	}
        window.showModalDialog("/report/ReportPowerMgrAddChildSort.jsf?userID="+id+"&operID="+id1, null, "dialogWidth:800px; dialogHeight:800px;center:center;resizable:no;status:no;scroll:no;");
        document.all('form1:refresh1').click();
   }
    </script>
<x:saveState value="#{Rpt_PowerMgrBB}" />
<h:form id="form1">
	<h:commandButton id="refresh1" value="刷新" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:commandButton id="refresh" value="保存 " style="display:none;"
		action="#{Rpt_PowerMgrBB.save}"></h:commandButton>
	<h:inputHidden id="superID" value="#{Rpt_PowerMgrBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="userID" value="#{Rpt_PowerMgrBB.userID}"></h:inputHidden>
	<h:inputHidden id="operID" value="#{Rpt_PowerMgrBB.operID}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="9" align="left">
			<h:outputText escape="false" value="<strong>选择用户:</strong>"></h:outputText>
			<h:panelGroup>
				<h:selectOneMenu onchange="disPlayProcessBar();submit();"
					value="#{Rpt_PowerMgrBB.userID}"
					valueChangeListener="#{Rpt_PowerMgrBB.changeDetailValue}">
					<c:selectItems value="#{Rpt_PowerMgrBB.userList}"></c:selectItems>
				</h:selectOneMenu>
			</h:panelGroup>
			<h:outputText escape="false" value="<strong>设置权限:</strong>"></h:outputText>
			<h:panelGroup>
				<h:selectOneMenu onchange="disPlayProcessBar();submit();"
					value="#{Rpt_PowerMgrBB.operID}"
					valueChangeListener="#{Rpt_PowerMgrBB.changeDetailValue1}">
					<c:selectItems value="#{Rpt_PowerMgrBB.detailList}"></c:selectItems>
				</h:selectOneMenu>
			</h:panelGroup>
			<h:commandButton styleClass="button01" type="button" value="排序" onclick="addDictionary();"/>
			<h:inputHidden id="text5" value="#{Rpt_PowerMgrBB.resultvalues}" />
			<h:inputHidden id="text5code" value="#{Rpt_PowerMgrBB.resultvaluess}" />
			<h:commandButton styleClass="button01" type="button" value="添加" onclick="addDictionarys();" />
			<h:commandButton styleClass="button01" value="删除 "
				action="#{Rpt_PowerMgrBB.deleteBatch}"
				onclick="return checkBatchDelete('selected_ids');" />
		</h:panelGrid>
		<x:dataTable value="#{Rpt_PowerMgrBB.itemList}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_left">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll,document.form1.selected_ids);"/>
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{list.contEntid}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="报表编号" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.rptCode}" />
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="表名" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.rptCodeName}" />
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
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





