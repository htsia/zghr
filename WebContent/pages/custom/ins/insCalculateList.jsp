
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
	function doAddItem() {
		window.showModalDialog("/custom/ins/insDataEdit.jsf",null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function editItem(ID) {
		window.showModalDialog("/custom/ins/insDataEdit.jsf?ID="+ID,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function viewInsPay(ID, wageDate, status) {
		window.showModalDialog("/custom/ins/insDataQuery.jsf?ID="+ID+"&wageDate="+wageDate+"&status="+status,null,"dialogWidth:1400px; dialogHeight:700px;center:center;resizable:yes;status:no;scroll:yes;");
	}
</script>
<x:saveState value="#{ins_dataBB}" />
<h:form id="form1">
	<h:inputHidden value="#{ins_dataBB.pageInit}"/>
	<f:verbatim>
    <table height=100% width=100% align="center">
        <tr><td height="1">
    </f:verbatim>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"/>
				<h:outputText value="  适用日期:"/>
				<h:inputText id="wageDate" value="#{ins_dataBB.wageDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',el:'form1:wageDate'})"/>
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
		<x:dataTable value="#{ins_dataBB.setList}" align="center"
			headerClass="td_top" rowIndexVar="index" var="item" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="序号" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="适用月份" />
				</f:facet>
				<h:outputText value="#{item.wageDate}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="创建人" />
				</f:facet>
				<h:outputText value="#{item.createUserName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="创建日期" />
				</f:facet>
				<h:outputText value="#{item.createDate}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="状态" />
				</f:facet>
				<h:outputText value="#{item.statusDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="备注" />
				</f:facet>
				<h:outputText value="#{item.remark}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" onclick="return editItem('#{item.ID}');" value="修改" rendered="#{item.status==0}"/>
				<h:commandButton styleClass="button01" type="button" onclick="return viewInsPay('#{item.ID}','#{item.wageDate}','#{item.status}');" value="查看"/>
				<h:commandButton styleClass="button01" onclick="return confirm('归档后数据不可更改,确定归档吗?');" value="归档" action="#{ins_dataBB.endCalc}" rendered="#{item.status==0}">
					<x:updateActionListener property="#{ins_dataBB.operSetID}" value="#{item.ID}" />		
				</h:commandButton>
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除" action="#{ins_dataBB.deleteSet}" rendered="#{item.status==0}">
					<x:updateActionListener property="#{ins_dataBB.operSetID}" value="#{item.ID}" />				
					<x:updateActionListener property="#{ins_dataBB.operWageDate}" value="#{item.wageDate}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			</div></td></tr></table>
		</f:verbatim>
	
	
</h:form>
<script type="text/javascript" language="javascript">
	setDataTableOver("form1:dateList");
</script>