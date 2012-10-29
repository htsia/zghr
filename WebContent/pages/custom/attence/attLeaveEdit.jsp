<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
function getApplyDays(){
	var beginDate = document.all("form1:beginTime").value;
	var endDate = document.all("form1:endTime").value;	
	if(beginDate!=""&&endDate!=""){
		var day=dateDiff(beginDate, endDate);
		/*四舍五入，如果是四舍，则天数+0.5  */
		var day1=Math.round(day);
		if(day-parseInt(day)<0.5){
			day1=day1+0.5;
		}else if(day-parseInt(day)==0.5){
			day1=day1-0.5;
		}
		document.all("form1:applydays").value=day1;
	}
}
	function checkDays() {
		//alert("into checkDays()");
		var type = document.all("form1:leaveType").value;
		var applydays = document.all("form1:applydays").value;
		var beginDate = document.all("form1:beginTime").value;
		var endDate = document.all("form1:endTime").value;
		var day = dateDiff(beginDate, endDate);
		/*四舍五入，如果是四舍，则天数+0.5  */
		var day1=Math.round(day);
		if(day-parseInt(day)<0.5){
			day1=day1+0.5;
		}else if(day-parseInt(day)==0.5){
			day1=day1-0.5;
		}
		if (beginDate == null || beginDate == "") {
			alert("请选择开始日期");
			return false;
		} else if (endDate == null || endDate == "") {
			alert("请选择结束日期");
			return false;
		} else if (beginDate > endDate) {
			alert("结束日期小于开始日期");
			return false;
		} else if (applydays == null || applydays == "") {
			alert("请填写请假天数");
			return false;
		} else if (applydays <= 0) {
			alert("请填写正确请假天数");
			return false;
		} else if (isNaN(applydays)) {
			alert("请假天数为数字");
			return false;
		}
		if (type == 2) {
			if (day <= 15) {
				if (confirm("病假时长" + day1 + "天，除去带薪病假，您将被扣除30%*工作日的病假扣款,请确认")) {
				} else {
					return false;
				}
			} else if (day <= 30) {
				if (confirm("病假时长" + day1 + "天，除去带薪病假，您将被扣除30%*工作日的病假扣款,请确认")) {
				} else {
					return false;
				}
			} else {
				if (confirm("病假时长" + day1 + "天，除去带薪病假，您将被扣除30%*工作日的病假扣款,请确认")) {
				} else {
					return false;
				}
			}
		} else if (type == 3) {
			var day = document.all("form1:leaveday3").value;

			var left = day - applydays;
			if (left < 0) {
				alert("您的婚假还有 " + day + "天   不够本次请假天数,请选择正常请假,或者减少请假天数:");
				return false;
			}
		} else if (type == 4) {
			var day = document.all("form1:leaveday4").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的丧假还有 " + day + "天   不够本次请假天数,请选择正常请假,或者减少请假天数:");
				return false;
			}
		} else if (type == 5) {
			var day = document.all("form1:leaveday5").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的产假还有 " + day + "天   不够本次请假天数,请选择正常请假,或者减少请假天数:");
				return false;
			}
		} else if (type == 6) {
			var day = document.all("form1:leaveday6").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的难产产假还有 " + day + "天   不够本次请假天数,请选择正常请假,或者减少请假天数:");
				return false;
			}
		} else if (type == 7) {
			var day = document.all("form1:leaveday7").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的带薪事假还有 " + day + "天   不够本次请假天数,请选择正常请假,或者减少请假天数:");
				return false;
			}
		}
		if (day > 10) {
			var str = "假期时长" + day1
					+ "天,达到销假标准，假期结束必须到人力资源处销假，销假之前，您将一直处于请假状态，具体事宜，请联系人力资源处负责老师";

			if(!confirm(str)){
				return false;
			}
		}
        return true;
	}

	//字符串转成Time(dateDiff)所需方法
	function stringToTime(string) {
		var f = string.split(' ', 2);
		var d = (f[0] ? f[0] : '').split('-', 3);
		var t = (f[1] ? f[1] : '').split(':', 3);
		return (new Date(parseInt(d[0], 10) || null,
				(parseInt(d[1], 10) || 1) - 1, parseInt(d[2], 10) || null,
				parseInt(t[0], 10) || null, parseInt(t[1], 10) || null,
				parseInt(t[2], 10) || null)).getTime();
	}

	function dateDiff(date1, date2) {
		var type1 = typeof date1, type2 = typeof date2;
		if (type1 == 'string')
			date1 = stringToTime(date1);
		else if (date1.getTime)
			date1 = date1.getTime();
		if (type2 == 'string')
			date2 = stringToTime(date2);
		else if (date2.getTime)
			date2 = date2.getTime();

		return (date2 - date1) / (1000 * 60 * 60 * 24); //结果是秒
	}
</script>

<x:saveState value="#{attLeaveApplyBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attLeaveApplyBB.initEdit}"></h:inputHidden>
	<!-- 将带薪假剩余的天数封装 -->
	<h:inputHidden id="leaveday7" value="#{attLeaveApplyBB.days.daixinjia}"></h:inputHidden>
	<h:inputHidden id="leaveday2" value="#{attLeaveApplyBB.days.bingjia}"></h:inputHidden>
	<h:inputHidden id="leaveday3" value="#{attLeaveApplyBB.days.sangjia}"></h:inputHidden>
	<h:inputHidden id="leaveday4" value="#{attLeaveApplyBB.days.hunjia}"></h:inputHidden>
	<h:inputHidden id="leaveday5" value="#{attLeaveApplyBB.days.chanjia}"></h:inputHidden>
	<h:inputHidden id="leaveday6"
		value="#{attLeaveApplyBB.days.nanchanjia}"></h:inputHidden>

	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 考勤管理 ->请假申请" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="98%" align="center">
		<h:panelGrid columns="4" width="100%"
			columnClasses="td_form01,td_form02,td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="申请人" />
			<h:outputText value="#{attLeaveApplyBB.personName}" />
			<h:outputText value="请假类型" />
			<h:selectOneMenu id="leaveType"
				value="#{attLeaveApplyBB.leaveBo.leaveType}">
				<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}" />
			</h:selectOneMenu>
			<h:outputText value="开始时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime"
					value="#{attLeaveApplyBB.leaveBo.beginTime}" readonly="true"
					onchange="getApplyDays();"
					alt="开始日期|0|d|50||" />
				<c:verbatim>
					<img
						onclick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:beginTime'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle">
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="结束时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime"
					value="#{attLeaveApplyBB.leaveBo.endTime}" readonly="true"
					onchange="getApplyDays();"
					alt="结束日期|0|d|50||" />
				<c:verbatim>
					<img
						onclick="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:endTime'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle">
				</c:verbatim>
			</h:panelGroup>
			<h:outputText value="请假时间/天" />
			<h:inputText readonly="true" id="applydays"
				value="#{attLeaveApplyBB.leaveBo.applyDays}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="请假原因" />
			<h:inputTextarea cols="60" rows="5"
				value="#{attLeaveApplyBB.leaveBo.reason}"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return checkDays();"
				styleClass="button01" action="#{attLeaveApplyBB.saveLeave}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	interpret(document.forms(0));
</script>