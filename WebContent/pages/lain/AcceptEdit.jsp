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
    var drawDate = form1.all("form1:drawDate").value
    if(drawDate == null||drawDate == ""){
        alert("请选择日期!");
        return false;
    }
}

function doAdd(){
    window.showModalDialog("/lain/acceptItemEdit.jsf?acceptId="+document.all("form1:acceptId").value , null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function doModify(id){
    window.showModalDialog("/lain/acceptItemEdit.jsf?acceptItemId="+id, null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
    return true ;
}

</script>
</head>

<body>
<x:saveState value="#{lain_AcceptBB}" />
<h:form id="form1">
	 <h:inputHidden id="acceptInitEdit" value="#{lain_AcceptBB.acceptInitEdit}"></h:inputHidden>
	<h:inputHidden id="acceptId" value="#{lain_AcceptBB.acceptId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 劳保管理 -> 入库申请单管理" />
		</h:panelGroup>
	</h:panelGrid>

   <h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="5" columnClasses="td_form01,td_form02 ,td_form01,td_form02 "
			align="center" styleClass="table03">
			<h:outputText value="操作员"   ></h:outputText>
			<h:panelGroup>
				<h:inputText    styleClass="inputDark" id="drawPerName" code=""
					dict="yes"   readonly="true"
					value="#{lain_AcceptBB.acceptBO.acceptPersonName}"></h:inputText>
					<h:inputHidden   value="#{lain_AcceptBB.acceptBO.acceptPerson}"></h:inputHidden>
					<h:inputHidden   value="#{lain_AcceptBB.acceptBO.acceptCode}"></h:inputHidden>
			</h:panelGroup>
			 
			<h:outputText value="申请日期"></h:outputText>
			<h:panelGroup>
				<h:inputText styleClass="inputDark" id="drawDate" code=""
					dict="yes"   readonly="true"
					value="#{lain_AcceptBB.acceptBO.acceptDate}"></h:inputText>
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpCalendarDialog('form1:drawDate')" />
			</h:panelGroup>
				<h:commandButton value="保存" id="save" onclick="return forCheck(); "  rendered="#{lain_AcceptBB.isItem == '1'}" 
				action="#{lain_AcceptBB.saveOrUpdateAcceptBO}"
				styleClass="button01" >
				</h:commandButton>
		</h:panelGrid>
		<h:panelGrid  columns="3" align="right" width="98%">
		   <h:outputText value="入库申请单明细 >>"   />
		    <h:outputText value="入库时间：#{lain_AcceptBB.acceptBO.acceptDate}"   />
		   <h:panelGrid align="right">
		    <h:panelGroup >
			 <h:commandButton value="增 加" onclick="return doAdd();" rendered="#{lain_AcceptBB.isUseAdd == '1'}"  
					 styleClass="button01"></h:commandButton>
			 </h:panelGroup>
		   
		   </h:panelGrid>
		</h:panelGrid>
		
		   <h:dataTable value="#{lain_AcceptBB.acceptItemkList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center, td_middle_center, td_middle_left, td_middle_left, td_middle_left, td_middle_center"
					styleClass="table03" width="96%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="供应商" />
						</c:facet>
						<h:outputText value="#{list.supName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="入库物资" />
						</c:facet>
						<h:outputText value="#{list.stockName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="入库数量" />
						</c:facet>
						<h:outputText value="#{list.acceptSum}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="单价(￥)" />
						</c:facet>
						<h:outputText value="#{list.acceptPrice}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="总价(￥)" />
						</c:facet>
						<h:outputText value="#{list.acceptTotal}" />
					</h:column>

					<h:column  rendered="#{lain_AcceptBB.isItem == '1'}" >
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑" styleClass="button01"
							onclick="doModify('#{list.acceptItemId}')" />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{lain_AcceptBB.deleteAcceptAItemBO}" styleClass="button01">
							<x:updateActionListener
								property="#{lain_AcceptBB.acceptItemBO.acceptItemId}"
								value="#{list.acceptItemId}" />
						</h:commandButton>
					</h:column>
				</h:dataTable> 
		    
		</h:panelGrid>
   
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
</html>