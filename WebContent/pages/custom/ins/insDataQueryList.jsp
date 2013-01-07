<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
	function edit(subID) {
		window.showModalDialog("/custom/ins/insMonthDataEdit.jsf?subID="+subID,null,"dialogWidth:400px; dialogHeight:450px;center:center;resizable:yes;status:no;scroll:yes;");
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
<x:saveState value="#{ins_dataBB}" />
<h:inputHidden value="#{ins_dataBB.dataInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{ins_dataBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{ins_dataBB.personTypeValue}"/>
	<f:verbatim>
    <table height=100% width=100% align="center">
	<td height="1">
    </f:verbatim>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton value="计算" styleClass="button01" action="#{ins_dataBB.calc}"/>
				<h:outputText value=" 姓名/编号/简拼"/>
				<h:inputText value="#{ins_dataBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{ins_dataBB.doQuery}"/>
				<h:commandButton action="#{ins_dataBB.doQuery}" styleClass="button01" value="查询 "/>
				<h:outputText value="  "/>
				<h:outputText value="记录数:#{ins_dataBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{ins_dataBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{ins_dataBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="当前为第#{ins_dataBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{ins_dataBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{ins_dataBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{ins_dataBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{ins_dataBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
	<f:verbatim>
		</td></tr><tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
	</f:verbatim>
		<x:dataTable value="#{ins_dataBB.monthPayList}" align="center"
			headerClass="td_top" rowIndexVar="index" var="item" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="序号" />
				</f:facet>
				<h:outputText value="#{index+1}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="员工编号" />
				</f:facet>
				<h:outputText value="#{item.userCode}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="姓名" />
				</f:facet>
				<h:outputText value="#{item.userName}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位" />
				</f:facet>
				<h:outputText value="#{item.orgID}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="二级部门" />
				</f:facet>
				<h:outputText value="#{item.secDeptID}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人员类别" />
				</f:facet>
				<h:outputText value="#{item.userType}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="缴费地" />
				</f:facet>
				<h:outputText value="#{item.payAddress}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="社保编号" />
				</f:facet>
				<h:outputText value="#{item.insNO}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="缴费地" />
				</f:facet>
				<h:outputText value="#{item.payAddress}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="是否自付" />
				</f:facet>
				<h:outputText value="#{item.selfPay}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="个人养老" />
				</f:facet>
				<h:outputText value="#{item.personYlao}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="个人失业" />
				</f:facet>
				<h:outputText value="#{item.personShiye}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="个人医疗" />
				</f:facet>
				<h:outputText value="#{item.personYliao}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="大额医疗" />
				</f:facet>
				<h:outputText value="#{item.personDaejin}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="个人公积金" />
				</f:facet>
				<h:outputText value="#{item.personGongjijin}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位养老" />
				</f:facet>
				<h:outputText value="#{item.companyYlao}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位失业" />
				</f:facet>
				<h:outputText value="#{item.companyShiye}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位工伤" />
				</f:facet>
				<h:outputText value="#{item.companyGongshang}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位医疗" />
				</f:facet>
				<h:outputText value="#{item.companyYliao}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位生育" />
				</f:facet>
				<h:outputText value="#{item.companyShengyu}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="单位公积金" />
				</f:facet>
				<h:outputText value="#{item.companyGongjijin}"/>
			</h:column>
			<h:column rendered="#{ins_dataBB.operStatus==0}">
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" onclick="return edit('#{item.subID}');" value="修改" />
			</h:column>
		</x:dataTable>
		<f:verbatim>
			</div></td></tr></table>
		</f:verbatim>
	
</h:form>
<script type="text/javascript" language="javascript">
	setDataTableOver("form1:dateList");
</script>