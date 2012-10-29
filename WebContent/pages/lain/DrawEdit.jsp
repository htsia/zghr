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
    var drawPerName = form1.all("form1:drawPerName").value
    if(drawPerName == null||drawPerName == ""){
        alert("请选择申请人!");
        return false;
    }
    var drawDate = form1.all("form1:drawDate").value
    if(drawDate == null||drawDate == ""){
        alert("请选择申领日期!");
        return false;
    }
     
}
function doAdd(){
    window.showModalDialog("/lain/DrawItemEdit.jsf?drawId="+document.all("form1:drawId").value , null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function doModify(id){
    window.showModalDialog("/lain/DrawItemEdit.jsf?drawItemId="+id, null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
    return true ;
}

	function forPerson() {

		showx = event.screenX - event.offsetX - 150;
		// + deltaX;
		showy = event.screenY - event.offsetY + 18;
		//windowOpen("/pages/ccp/PartyTreeSelPerson.jsp?obj1=form1:personId&obj2=form1:personName", "aa", "","600","600","no","100","100","yes");
		var retval = window.showModalDialog("/pages/ccp/OrgTreeSelPerson.jsp",
				"", "dialogWidth:900px; dialogHeight:500px; dialogLeft:"
						+ showx + "px; dialogTop:" + showy
						+ "px; status:0;resizable:yes");
		if (retval != null) {
			rs = retval.split(",");
			document.all("form1:drawPerson").value = rs[0];
			document.all("form1:drawPerName").value = rs[1];
		}
	}
</script>
</head>

<body>
<x:saveState value="#{lain_DrawBB}" />
<h:form id="form1">
	<h:inputHidden id="drawInitEdit" value="#{lain_DrawBB.drawInitEdit}"></h:inputHidden>
	<h:inputHidden id="drawPerson" value="#{lain_DrawBB.drawBO.drawPerson}"></h:inputHidden>
	<h:inputHidden id="drawId"  value="#{lain_DrawBB.drawId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 劳保管理 -> 编辑领用申请单" />
		</h:panelGroup>
	</h:panelGrid>

   <h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="6" columnClasses="td_form01,td_form02 ,td_form01,td_form02 "
			align="center" styleClass="table03">
			 <h:outputText value="申请人"   ></h:outputText>
			<h:panelGroup>
				<h:inputText   styleClass="inputDark" id="drawPerName" code=""
					dict="yes"   readonly="true"
					value="#{lain_DrawBB.drawBO.drawPerName}"></h:inputText>
				<h:commandButton   type="button" styleClass="button_select"
					onclick="forPerson()" />
			</h:panelGroup>
			<h:outputText value="申请日期"></h:outputText>
			<h:panelGroup>
				<h:inputText styleClass="inputDark" id="drawDate" code=""
					dict="yes"   readonly="true"
					value="#{lain_DrawBB.drawBO.drawDate}"></h:inputText>
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpCalendarDialog('form1:drawDate')" />
			</h:panelGroup>
			 <h:inputHidden   value="#{lain_DrawBB.drawBO.drawCode}"></h:inputHidden>
			<h:commandButton value="保 存" id="save"  rendered="#{lain_DrawBB.isUseSave == '1'}"
				action="#{lain_DrawBB.saveOrUpdateDrawBO}"
				onclick="return forCheck();"
				styleClass="button01" >
				</h:commandButton>
		</h:panelGrid>
		<h:panelGrid  columns="3" align="right" width="98%">
		   <h:outputText value="领用申请单明细 >>"   />
		    <h:outputText value="领取时间：#{lain_DrawBB.drawBO.drawDate}"   />
		   <h:panelGrid align="right">
		    <h:panelGroup >
			 <h:commandButton value="增 加" onclick="return doAdd();"   rendered="#{lain_DrawBB.isUserAdd == '1'}"
					 styleClass="button01"></h:commandButton>
			 </h:panelGroup>
		   
		   </h:panelGrid>
		</h:panelGrid>
		
		  <h:dataTable value="#{lain_DrawBB.drawItemkList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center, td_middle_center, td_middle_center"
					styleClass="table03" width="98%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="领用物资" />
						</c:facet>
						<h:outputText value="#{list.stockName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="领用数量" />
						</c:facet>
						<h:outputText value="#{list.drawSum}" />
					</h:column>

					<h:column  rendered="#{lain_DrawBB.drawBO.drawStatus == '0'}">
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑" styleClass="button01"
							onclick="doModify('#{list.drawItemId}')" />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{lain_DrawBB.deleteDrawItemBO}" styleClass="button01">
							<x:updateActionListener
								property="#{lain_DrawBB.drawItemBO.drawItemId}"
								value="#{list.drawItemId}" />
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