<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>

<script type="text/javascript">
	function forsave(){
		var itemType = document.all("form1:itemType").value;
		var beginDate = document.all("form1:beginDate").value;
		var endDate;
		var totalmoney = document.all("form1:totalmoney").value;
		totalmoney=$.trim(totalmoney);
		document.all("form1:totalmoney").value=totalmoney;
		var excludeDate;
		if(itemType==1 || itemType==2){
			endDate = document.all("form1:endDate").value;
			excludeDate = document.all("form1:excludeDate").value;
		}
		if($.trim(document.all("form1:name").value).length==0){
			alert("请填写项目名称");
			return false;
		}else if(totalmoney==null || totalmoney.length==0 || isNaN(totalmoney)){
			alert("总金额为数字");
			return false;
		}else if((beginDate==null || beginDate=="") && (itemType==1 || itemType==2)){
			alert("请选择开始日期");
			return false;
		}else if((endDate==null || endDate=="") && (itemType==1 || itemType==2)){
			alert("请选择结束日期");
			return false;
		}else if((beginDate > endDate) && (itemType==1 || itemType==2)){
			alert("结束日期小于开始日期");
			return false;
		}else if((beginDate==null || beginDate=="") && itemType!=1 && itemType!=2){
			alert("请选择适用日期");
			return false;
		}
		return true;
	}

	function setData(){
		var excludeDate = document.all('form1:excludeDate').value;
		PopUpCalendarDialog('form1:datestr');
		var ymd = document.all('form1:datestr').value.substring(0,7);
		if (excludeDate != null && excludeDate != "") {
			document.all('form1:excludeDate').value = excludeDate + "," + ymd;
		} else {
			document.all('form1:excludeDate').value = ymd;
		}
		return false;
	}
	var itemType1 = document.all("form1:itemType").value;
	if(itemType1!=1 && itemType1!=2 && itemType1!=4){
		document.all('selend').style.display="none";
	}
</script>
<x:saveState value="#{wage_dataOtherBB}" />
<h:inputHidden value="#{wage_dataOtherBB.editInit}"/>
<h:form id="form1">
	<h:inputHidden id="itemType" value="#{wage_dataOtherBB.itemType}"/>	
	<h:inputHidden id="datestr" value=""/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="薪酬管理-> #{wage_dataOtherBB.itemName}" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			
			<h:outputText value="项目名称"></h:outputText>
			<h:inputText id="name" value="#{wage_dataOtherBB.item.name}" styleClass="input" size="30"></h:inputText>
			
			<h:outputText value="总金额"></h:outputText>
			<h:panelGroup>
				<h:inputText id="totalmoney" size="30" styleClass="input" value="#{wage_dataOtherBB.item.totalmoney}"></h:inputText>
			</h:panelGroup>
			
			<h:outputText value="适用日期"/>
			<h:panelGroup>
				<h:outputText value="开始日期:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputText id="beginDate" value="#{wage_dataOtherBB.item.beginDate}" styleClass="input" readonly="true"/>
				<c:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:beginDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
				<c:verbatim><br/></c:verbatim>
				<h:outputText value="结束日期:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputText id="endDate" value="#{wage_dataOtherBB.item.endDate}" styleClass="input" readonly="true" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<c:verbatim>
				    <img id="selend" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:endDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
				<c:verbatim><br/></c:verbatim>
				<h:outputText value="排除日期:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputTextarea id="excludeDate" readonly="true" value="#{wage_dataOtherBB.item.excludeDate}" cols="30" rows="2" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:commandButton onclick="return setData();" styleClass="button_select" value="" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
			</h:panelGroup>
			
			<h:outputText value="备注"/>
            <h:inputTextarea id="desc" value="#{wage_dataOtherBB.item.desc}" cols="50" rows="3"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{wage_dataOtherBB.saveSet}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>