<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script language="javascript" src="/js/jquery.js"></script>
<script type="text/javascript">
	function doAddItem() {
		// 		var gangwei=document.all('form1:gangwei');
		// 		var flag=false;
		// 		for(var i=0;i<gangwei.length;i++){
		// 			if(gangwei[i].checked==true){
		// 				flag=true;
		// 				break;
		// 			}
		// 		}
		// 		if(!flag){
		// 			alert("请选择关联岗位！");
		// 			return false;
		// 		}
		if ($(":checkbox:checked").length == 0) {
			alert("请选择关联岗位");
			return false;
		}
		var attname = document.all('form1:attname').value;
		if (attname == null || attname == "") {
			alert("请先填入节日名称！");
			return false;
		}
		var beginDate = document.all("form1:beginDate").value;
		var endDate = document.all("form1:endDate").value;

		if (beginDate == null || beginDate == "") {
			alert("请选择开始日期");
			return false;
		} else if (endDate == null || endDate == "") {
			alert("请选择结束日期");
			return false;
		} else if (beginDate > endDate) {
			alert("结束日期大于开始日期");
			return false;
		}

		return true;
	}
	function doAddItem1() {
		var attname = document.all('form1:attname').value;

		if (attname == null || attname == "") {
			alert("请先填入节日名称！");
			return false;
		}

		if (createdatevalue == null || createdatevalue == "") {
			alert("请先填入节日时间！");
			return false;
		}
		var beginDate = document.all("form1:beginDate").value;
		var endDate = document.all("form1:endDate").value;

		if (beginDate == null || beginDate == "") {
			alert("请选择开始日期");
			return false;
		} else if (endDate == null || endDate == "") {
			alert("请选择结束日期");
			return false;
		} else if (beginDate > endDate) {
			alert("结束日期大于开始日期");
			return false;
		}
		return true;
	}
	function repeart(createdatevalue) {
		if (createdatevalue == '0') {
			document.all('form1:attname').value = '';
			document.all('form1:place').value = '';
		}
		document.all('form1:A00001').value = '';
	}
	function repeart1(createdatevalue) {
		if (createdatevalue == '0') {
			document.all('form1:attname').value = '';
			document.all('form1:place').value = '';
		}
		document.all('form1:A0000100001').value = '';
	}
	function add() {
		var timename = document.all('form1:A00001').value;
		PopUpCalendarDialog('form1:timeObjectID');
		var ymd = document.all('form1:timeObjectID').value;
		var y = ymd.substring(0, 4);
		var md = ymd.substring(5, 10);
		if (timename != null && timename != "") {
			document.all('form1:A00001').value = timename + "," + md;
		} else {
			document.all('form1:A00001').value = md;
		}
	}
	function add1() {
		var timename = document.all('form1:A0000100001').value;
		PopUpCalendarDialog('form1:timeObjectID');
		if (timename != null && timename != "") {
			document.all('form1:A0000100001').value = timename + ","
					+ document.all('form1:timeObjectID').value;
		} else {
			document.all('form1:A0000100001').value = document
					.all('form1:timeObjectID').value;
		}
	}
	function setselectdate() {
		document.all("form1:beginDate").value = "";
		document.all("form1:endDate").value = "";
		var type = document.all("form1:yeartype").value;
		document.all("selectbegindate1").style.display = "none";
		document.all("selectbegindate2").style.display = "none";
		document.all("selectenddate1").style.display = "none";
		document.all("selectenddate2").style.display = "none";
		if (type == -1) {
			ddocument.all("selectbegindate2").style.display = "block";
			document.all("selectenddate2").style.display = "block";
		} else if(type==0) {
			document.all("selectbegindate2").style.display = "block";
			document.all("selectenddate2").style.display = "block";
		}
	}

	var feastID = document.all('form1:feastID').value;
	if (feastID == null || feastID == '') {
		var gangwei1 = document.all('form1:gangwei');
		for ( var i = 0; i < gangwei1.length; i++) {
			gangwei1[i].checked = true;
		}
	}
</script>
<x:saveState value="#{att_feast_mgrchildBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_feast_mgrchildBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{att_feast_mgrchildBB.superId}"></h:inputHidden>
	<h:inputHidden id="feastID" value="#{att_feast_mgrchildBB.bo.feastID}"></h:inputHidden>
	<h:inputHidden id="timeObjectID"
		value="#{att_feast_mgrchildBB.timeObject}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 节假日管理" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="center">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="节假日名称"></h:outputText>
			<h:inputText id="attname" size="32" styleClass="input"
				value="#{att_feast_mgrchildBB.bo.feastName}"></h:inputText>

			<h:outputText value="关联岗位类型"></h:outputText>
			<h:selectManyCheckbox id="gangwei"
				value="#{att_feast_mgrchildBB.postLeiXing}">
				<f:selectItems value="#{att_feast_mgrchildBB.postLeiXingList}" />
			</h:selectManyCheckbox>

			<h:outputText value="年份范围：" rendered="1==0" />
				<h:selectOneMenu id="yeartype"
					value="#{att_feast_mgrchildBB.bo.yearType}"
					onchange="setselectdate();" rendered="1==0">
					<c:selectItem itemValue="0" itemLabel="指定年" />
					<c:selectItem itemValue="-1" itemLabel="所有年" />
				</h:selectOneMenu>
				
			<h:outputText value="开始时间" />
			<h:panelGroup >
				<h:inputText styleClass="input" size="12" id="beginDate"
					value="#{att_feast_mgrchildBB.bo.beginDate}" readonly="true"
					alt="开始日期|0|d|50||" />
				<c:verbatim>
					 <img id="selectbegindate1" style="display: none;"
						onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'MM-dd',alwaysUseStartDate:true,el:'form1:beginDate'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle" style="float: left;" /> <img
						id="selectbegindate2" 
						onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,el:'form1:beginDate'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle" style="float: left;" />
					
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="结束时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" size="12" id="endDate"
					value="#{att_feast_mgrchildBB.bo.endDate}" readonly="true"
					alt="结束日期|0|d|50||" />
				<c:verbatim>
					<img id="selectenddate1" style="display: none;"
						onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'MM-dd',alwaysUseStartDate:true,el:'form1:endDate'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle" style="float: left;" /> <img
						id="selectenddate2" 
						onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,el:'form1:endDate'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle" style="float: left;" />
					
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="描述"></h:outputText>
			<h:inputTextarea id="place"
				value="#{att_feast_mgrchildBB.bo.description}" cols="35" rows="5"></h:inputTextarea>
			<h:outputText value="应用范围"></h:outputText>

			<h:selectOneMenu value="#{att_feast_mgrchildBB.atttype}"
				valueChangeListener="#{att_feast_mgrchildBB.changeStatus}">
				<c:selectItem itemLabel="#{att_feast_mgrchildBB.superName}"
					itemValue="#{att_feast_mgrchildBB.superId}"></c:selectItem>
				<c:selectItem itemLabel="全集团" itemValue="-1"></c:selectItem>
			</h:selectOneMenu>
		</h:panelGrid>
		<h:panelGrid columns="3" align="right">
			<h:commandButton value="保存" action="#{att_feast_mgrchildBB.save}"
				styleClass="button01" onclick="return doAddItem();"
				rendered="#{att_feast_mgrchildBB.nowyearvalue!='0'}" />
			<h:commandButton value="保存" action="#{att_feast_mgrchildBB.save}"
				styleClass="button01" onclick="return doAddItem1();"
				rendered="#{att_feast_mgrchildBB.nowyearvalue=='0'}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


