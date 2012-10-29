<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<html>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<head>
<title></title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/check.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script type="text/javascript">
	function forsave(form) {
		document.all("form1:save").click();
	}
	function forBack(form) {
		window.close();
	}
</script>
</head>

<body>
<x:saveState value="#{lain_EditStockBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{lain_EditStockBB.initEdit}"></h:inputHidden>
	<h:inputHidden value="#{lain_EditStockBB.stockBO.createOrg}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 劳保管理 -> 物资管理" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="98%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="物资名称"></h:outputText>
			<h:inputText value="#{lain_EditStockBB.stockBO.stockName}"></h:inputText>

			<h:outputText value="物资类型"></h:outputText>
			<h:panelGroup>
				<h:inputText styleClass="inputDark" id="stockType" code=""
					dict="yes" dict_num="2225" readonly="true"
					value="#{lain_EditStockBB.stockBO.stockType}"></h:inputText>
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpCodeDlgOneControl('form1:stockType')" />
			</h:panelGroup>
			<h:outputText value="库存单位"></h:outputText>
			<h:inputText value="#{lain_EditStockBB.stockBO.stockUnit}"></h:inputText>

			<h:outputText value="库存数量"></h:outputText>
			<h:inputText value="#{lain_EditStockBB.stockBO.stockSum}"></h:inputText>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" id="save"
				action="#{lain_EditStockBB.saveOrUpdateStockBO}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>

</h:form>
</body>
</html>