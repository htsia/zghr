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
		var excludeDate;
		if(itemType==1 || itemType==2){
			endDate = document.all("form1:endDate").value;
			excludeDate = document.all("form1:excludeDate").value;
		}
		if($.trim(document.all("form1:name").value).length==0){
			alert("����д��Ŀ����");
			return false;
		}else if((beginDate==null || beginDate=="") && (itemType==1 || itemType==2)){
			alert("��ѡ��ʼ����");
			return false;
		}else if((endDate==null || endDate=="") && (itemType==1 || itemType==2)){
			alert("��ѡ���������");
			return false;
		}else if((beginDate > endDate) && (itemType==1 || itemType==2)){
			alert("��������С�ڿ�ʼ����");
			return false;
		}else if((beginDate==null || beginDate=="") && itemType!=1 && itemType!=2){
			alert("��ѡ����������");
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
			<h:outputText value="н�����-> #{wage_dataOtherBB.itemName}" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			
			<h:outputText value="��Ŀ����"></h:outputText>
			<h:inputText id="name" value="#{wage_dataOtherBB.item.name}" styleClass="input" size="45"></h:inputText>
			<h:outputText value="��������"/>
			<h:panelGroup>
				<h:outputText value="��ʼ����:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputText id="beginDate" value="#{wage_dataOtherBB.item.beginDate}" styleClass="input Wdate" readonly="true" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:beginDate'})"/>
				<c:verbatim><br/></c:verbatim>
				<h:outputText value="��������:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputText id="endDate" value="#{wage_dataOtherBB.item.endDate}" styleClass="input Wdate" readonly="true" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}" 
					onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:endDate'})"/>
				<c:verbatim><br/></c:verbatim>
				<h:outputText value="�ų�����:" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:inputTextarea id="excludeDate" readonly="true" value="#{wage_dataOtherBB.item.excludeDate}" cols="30" rows="2" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
				<h:commandButton onclick="return setData();" styleClass="button_select" value="" rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}"/>
			</h:panelGroup>
			
			<h:outputText value="��ע"/>
            <h:inputTextarea id="desc" value="#{wage_dataOtherBB.item.desc}" cols="50" rows="3"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();" action="#{wage_dataOtherBB.saveSet}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>