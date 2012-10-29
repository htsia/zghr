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
function forCheck() {
    var supId = form1.all("form1:supId").value
    if(supId == null||supId == ""){
        alert("请选择供应商!");
        return false;
    }
    var stockId = form1.all("form1:stockId").value
    if(stockId == null||stockId == ""){
        alert("请选择入库物资!");
        return false;
    }
    var patrn = /^-?[0-9]*(\.\d*)?$|^-?d^(\.\d*)?$/;
    var acceptSum = form1.all("form1:acceptSum").value
    if(acceptSum == null||acceptSum == "" || !patrn.test(acceptSum) ){
        alert(" 数量输入不能为空且必须为整数!");
        return false;
    }

    var acceptPrice = form1.all("form1:acceptPrice").value
    if(acceptPrice == null||acceptPrice == "" || !patrn.test(acceptSum) ){
        alert(" 单价输入不能为空且必须为整数!");
        return false;
    }
}

function onChange(){
	var acceptSum = form1.all("form1:acceptSum").value ;
	var acceptPrice = form1.all("form1:acceptPrice").value ;
	if(acceptPrice != null && acceptSum != null ){
	     form1.all("form1:acceptTotal").value = acceptSum * acceptPrice;
		}
}
</script>
</head>

<body>
<x:saveState value="#{lain_AcceptBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{lain_AcceptBB.acceptItemInitEdit}"></h:inputHidden>
	<h:inputHidden   value="#{lain_AcceptBB.acceptItemBO.acceptId}"></h:inputHidden>
	<h:inputHidden   value="#{lain_AcceptBB.acceptItemId}"></h:inputHidden>
	
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 劳保管理 -> 编辑入库申请单" />
		</h:panelGroup>
	</h:panelGrid>

   <h:panelGrid columns="1" width="98%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			
			 <h:outputText value="供应商" ></h:outputText>
			<h:panelGroup>
			 
				<h:inputText    id="supName"   readonly="true"  value="#{lain_AcceptBB.acceptItemBO.supName}"></h:inputText>
			     <h:inputHidden id="supId"   value="#{lain_AcceptBB.acceptItemBO.supId}" />
				<h:commandButton   type="button" styleClass="button_select"
					 onclick="PopUpLainSupplyTwoControl(document.all('form1:supId'),document.all('form1:supName'))" />
			</h:panelGroup>
			
			 <h:outputText value="入库物资" ></h:outputText>
			<h:panelGroup>
			 
				<h:inputText    id="stockName"   readonly="true"  value="#{lain_AcceptBB.acceptItemBO.stockName}"></h:inputText>
			     <h:inputHidden id="stockId"   value="#{lain_AcceptBB.acceptItemBO.stockId}" />
				<h:commandButton   type="button" styleClass="button_select"
					 onclick="PopUpLainStockTwoControl(document.all('form1:stockId'),document.all('form1:stockName'))" />
			</h:panelGroup>
			 
			<h:outputText value="入库数量"></h:outputText>
			<h:inputText id="acceptSum" value="#{lain_AcceptBB.acceptItemBO.acceptSum}"></h:inputText>
			<h:outputText value="单价"></h:outputText>
			<h:inputText id="acceptPrice" value="#{lain_AcceptBB.acceptItemBO.acceptPrice}" onclick="return onChange(); "></h:inputText>
			<h:outputText value="总价"></h:outputText>
			<h:inputText id="acceptTotal" value="#{lain_AcceptBB.acceptItemBO.acceptTotal}" ></h:inputText>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" id="save" onclick="return forCheck();"
				action="#{lain_AcceptBB.saveOrUpdateAcceptItemBO}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
   
</h:form>
</body>
</html>