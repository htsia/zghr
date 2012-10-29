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
    var stockId = form1.all("form1:stockId").value
    if(stockId == null||stockId == ""){
        alert("请选择申领物资!");
        return false;
    }
    var patrn = /^-?[0-9]*(\.\d*)?$|^-?d^(\.\d*)?$/;
    var drawSum = form1.all("form1:drawSum").value
    if(drawSum == null||drawSum == "" || !patrn.test(drawSum) ){
        alert(" 输入不能为空且必须为整数!");
        return false;
    }
}
</script>
</head>

<body>
<x:saveState value="#{lain_DrawBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{lain_DrawBB.drawItemInitEdit}"></h:inputHidden>
	<h:inputHidden   value="#{lain_DrawBB.drawItemBO.drawId}"></h:inputHidden>
	<h:inputHidden   value="#{lain_DrawBB.drawItemId}"></h:inputHidden>
	
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 劳保管理 -> 编辑领用申请单" />
		</h:panelGroup>
	</h:panelGrid>

   <h:panelGrid columns="1" width="98%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			
			 <h:outputText value="领用物资" ></h:outputText>
			<h:panelGroup>
			 
				<h:inputText    id="stockName"   readonly="true"  value="#{lain_DrawBB.drawItemBO.stockName}"></h:inputText>
			     <h:inputHidden id="stockId"   value="#{lain_DrawBB.drawItemBO.stockId}" />
				<h:commandButton   type="button" styleClass="button_select"
					 onclick="PopUpLainStockTwoControl(document.all('form1:stockId'),document.all('form1:stockName'))" />
			</h:panelGroup>
			 
			<h:outputText value="物资数量"></h:outputText>
			<h:inputText id="drawSum"  value="#{lain_DrawBB.drawItemBO.drawSum}"></h:inputText>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" id="save"
				action="#{lain_DrawBB.saveOrUpdateDrawItemBO}"
				onclick="return forCheck() ;"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
   
</h:form>
</body>
</html>