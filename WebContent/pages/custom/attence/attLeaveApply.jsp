<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
 <script type="text/javascript" src="../../js/getnowdate.js"></script>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function getApplyDays() {
		document.all("form1:saveleave").disabled = "disabled";
		document.all("form1:applydays").value = "";
		$("#applist").html("");
		var beginDate = document.all("form1:beginTime").value;
		var endDate = document.all("form1:endTime").value;
		if (beginDate != "" && endDate != "") {
			var beginHour = document.all("beginHour").value;
			var endHour = document.all("endHour").value;
			var realBeginTime = beginDate + " " + beginHour;
			var realEndTime = endDate + " " + endHour;
			if (dateDiff(realBeginTime, realEndTime) > 0) {
				//开始和结束时间缀上早上或者中午或者晚上的小时	
				document.all("form1:totalDays").value = dateDiff(realBeginTime,
						realEndTime);
				$.ajax({
					type : "POST",
					url : "/pages/ajax/attRealDays.jsp",
					data : "beginTime=" + realBeginTime + "&endTime="
							+ realEndTime,
					success : function(msg) {
						if (msg == -1) {
							alert("您没有上级岗位不能请假");
						} else {
							document.all("form1:saveleave").disabled = "";
							var info = msg.split(',');
							document.all("form1:applydays").value = info[0];
							var userlist = "";
							for ( var i = 1; i < info.length - 1; i++) {
								userlist += "第" + i + "审批人：" + info[i]
										+ "<br/>";
							}
							$("#applist").html(userlist);
						}
					}
				});
			} else {
				$("#applist").html("结束时间应大于开始时间");
			}
		}
	}
	function checkDays() {
		//保存请假条出发的事件
		var type = document.all("form1:leaveType").value;
		var applydays = document.all("form1:applydays").value;
		var beginDate = document.all("form1:beginTime").value;
		var endDate = document.all("form1:endTime").value;
		//开始和结束时间缀上早上或者中午或者晚上的小时
		var beginHour = document.all("beginHour").value;
		var endHour = document.all("endHour").value;
		var realBeginTime = beginDate + " " + beginHour;
		var realEndTime = endDate + " " + endHour;
		var alldays = dateDiff(realBeginTime, realEndTime);
		
  		var str = getNowDate();
  		
		if (beginDate == null || beginDate == "") {
			alert("请选择开始日期");
			return false;
		}else if(beginDate<str){
  			alert("开始时间不能小于当天");
  			return false;
  		} else if (endDate == null || endDate == "") {
			alert("请选择结束日期");
			return false;
		} else if (realBeginTime >= realEndTime) {
			alert("结束日期要大于开始日期");
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
			if (alldays <= 15) {
				if (confirm("超出带薪假的工作日，将被扣除30%的工资，请确认。")) {
				} else {
					return false;
				}
			} else if (alldays <= 30) {
				if (confirm("超出带薪假的工作日，将被扣除50%的工资，请确认。")) {
				} else {
					return false;
				}
			} else if (alldays <= 60) {
				if (confirm("超出带薪假的工作日，将被扣除80%的工资，请确认。")) {
				} else {
					return false;
				}
			} else {
				if (confirm("超出带薪假的工作日，将被扣除全额工资，请确认。")) {
				} else {
					return false;
				}
			}
		} else if (type == 3) {
			//剩余的带薪假天数
			var day = document.all("form1:leaveday3").value;
			//除去本次请假天数以后的天数
			var left = day - applydays;
			if (left < 0) {
				alert("您的婚假还有 " + (day - 0) + "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
				return false;
			} else {
				//检测有没有申请中的假条
				var undoneDays = document.all("form1:leaveday33").value;
				//除去未审批的带薪假天数
				if (left - undoneDays < 0) {
					alert("您有" + undoneDays + "天婚假正在审批，剩余婚假还有"
							+ (day - undoneDays - 0)
							+ "天， 小于本次请假天数，请选择正常请假，或者减少请假天数。");
					return false;
				}
			}
		} else if (type == 4) {
			var day = document.all("form1:leaveday4").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的丧假还有 " + (day - 0) + "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
				return false;
			} else {
				//检测有没有申请中的假条
				var undoneDays = document.all("form1:leaveday44").value;
				//除去未审批的带薪假天数
				if (left - undoneDays < 0) {
					alert("您有" + undoneDays + "天丧假正在审批，剩余丧假还有"
							+ (day - undoneDays - 0)
							+ "天， 小于本次请假天数，请选择正常请假，或者减少请假天数。");
					return false;
				}
			}
		} else if (type == 5) {			
			document.all("form1:applydays").value = alldays;
			var day = document.all("form1:leaveday5").value;
			var left = day - alldays;
			if (left < 0) {
				alert("您的产假还有 " + (day - 0) + "天， 小于本次请假天数，请选择正常请假，或者减少请假天数。");
				return false;
			} else {
				//检测有没有申请中的假条
				var undoneDays = document.all("form1:leaveday55").value;
				//除去未审批的带薪假天数
				if (left - undoneDays < 0) {
					alert("您有" + undoneDays + "天产假正在审批，剩余产假还有"
							+ (day - undoneDays - 0)
							+ "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
					return false;
				}
			}
		} else if (type == 6) {
			document.all("form1:applydays").value = alldays;
			var day = document.all("form1:leaveday6").value;
			var left = day - alldays;
			if (left < 0) {
				alert("您的难产产假还有 " + (day - 0) + "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
				return false;
			} else {
				//检测有没有申请中的假条
				var undoneDays = document.all("form1:leaveday66").value;
				//除去未审批的带薪假天数
				if (left - undoneDays < 0) {
					alert("您有" + undoneDays + "天难产产假正在审批，剩余难产产假还有"
							+ (day - undoneDays - 0)
							+ "天， 小于本次请假天数，请选择正常请假，或者减少请假天数。");
					return false;
				}
			}

		} else if (type == 7) {
			var day = document.all("form1:leaveday7").value;
			var left = day - applydays;
			if (left < 0) {
				alert("您的带薪事假还有 " + (day - 0) + "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
				return false;
			} else {
				//检测有没有申请中的假条
				var undoneDays = document.all("form1:leaveday77").value;
				//除去未审批的带薪假天数
				if (left - undoneDays < 0) {
					alert("您有" + undoneDays + "天带薪事假正在审批，剩余带薪事假还有"
							+ (day - undoneDays - 0)
							+ "天，小于本次请假天数，请选择正常请假，或者减少请假天数。");
					return false;
				}
			}
		}
		if (applydays > 10) {
			var str = "您请假"
					+ applydays
					+ "个工作日，需销假，假期结束必须到人力资源处销假。销假之前，您将一直处于请假状态。具体事宜，请联系人力资源处负责老师。";

			if (!confirm(str)) {
				return false;
			}
		}
		//判断原因是否过长
		var reason = document.all("form1:reason").value;
		if (reason.length > 100) {
			alert("原因不能超过100字。");
			return false;
		}
		//给开始和结束时间赋值
		document.all("form1:totalDays").value = alldays;
		document.all("form1:beginTime").value = realBeginTime;
		document.all("form1:endTime").value = realEndTime;
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

		var allDay = (date2 - date1) / (1000 * 60 * 60 * 24); //结果是秒
		/*四舍五入，如果是四舍，则天数+0.5  */
		var day1 = Math.round(allDay);
		if (allDay - parseInt(allDay) < 0.5) {
			day1 = day1 + 0.5;
		} else if (allDay - parseInt(allDay) == 0.5) {
			day1 = day1 - 0.5;
		}
		return day1;
	}

	function isChanjia() {
		var type = document.all("form1:leaveType").value;
		if (type == 5 || type == 6) {
			document.all("form1:chan").style.display = "block";
			document.all("form1:totalDays").style.display = "block";
			document.all("form1:nochan").style.display = "none";
			document.all("form1:applydays").style.display = "none";
		} else if(type==1|| type == 2|| type == 3|| type == 4|| type == 7) {
			document.all("form1:chan").style.display = "none";
			document.all("form1:totalDays").style.display = "none";
			document.all("form1:nochan").style.display = "block";
			document.all("form1:applydays").style.display = "block";
			
		}
	}
</script>

<x:saveState value="#{attLeaveApplyBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attLeaveApplyBB.initEdit}"></h:inputHidden>
	<!-- 将带薪假剩余的天数封装 -->
	<h:inputHidden id="leaveday2" value="#{attLeaveApplyBB.days.a236202}"></h:inputHidden>
	<h:inputHidden id="leaveday3" value="#{attLeaveApplyBB.days.a236203}"></h:inputHidden>
	<h:inputHidden id="leaveday4" value="#{attLeaveApplyBB.days.a236204}"></h:inputHidden>
	<h:inputHidden id="leaveday5" value="#{attLeaveApplyBB.days.a236205}"></h:inputHidden>
	<h:inputHidden id="leaveday6" value="#{attLeaveApplyBB.days.a236206}"></h:inputHidden>
	<h:inputHidden id="leaveday7" value="#{attLeaveApplyBB.days.a236207}"></h:inputHidden>
	<!--没批准的带薪假天数  -->
	<h:inputHidden id="leaveday33" value="#{attLeaveApplyBB.undoneDays.a3}"></h:inputHidden>
	<h:inputHidden id="leaveday44" value="#{attLeaveApplyBB.undoneDays.a4}"></h:inputHidden>
	<h:inputHidden id="leaveday55" value="#{attLeaveApplyBB.undoneDays.a5}"></h:inputHidden>
	<h:inputHidden id="leaveday66" value="#{attLeaveApplyBB.undoneDays.a6}"></h:inputHidden>
	<h:inputHidden id="leaveday77" value="#{attLeaveApplyBB.undoneDays.a7}"></h:inputHidden>


	<!--请假条实际天数  -->
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
			<h:selectOneMenu id="leaveType" onchange="isChanjia()"
				value="#{attLeaveApplyBB.leaveBo.leaveType}">
				<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}" />
			</h:selectOneMenu>
			<h:outputText value="开始时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime"
					value="#{attLeaveApplyBB.leaveBo.beginTime}" readonly="true"
					alt="开始日期|0|d|50||"/>
				<c:verbatim>
				<input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:beginTime');getApplyDays();">
					<select id="beginHour" onchange="getApplyDays();">
						<option value="00:00">早上</option>
						<option value="12:00">中午</option>
					</select>
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="结束时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime"
					value="#{attLeaveApplyBB.leaveBo.endTime}" readonly="true"
					alt="结束日期|0|d|50||"/>
				<c:verbatim>
				<input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:endTime');getApplyDays();">
					<select id="endHour" onchange="getApplyDays();">
						<option value="23:59">晚上</option>
						<option value="12:00">中午</option>
					</select>
				</c:verbatim>
			</h:panelGroup>
			<h:panelGroup>
				<h:outputText id="nochan" value="请假时间/工作日天数" />
				<h:outputText id="chan" style="display:none" value="产  假/难产产假天数" />
			</h:panelGroup>
			<h:panelGroup>
				<h:inputText style="display:block" styleClass="input1"
					readonly="true" id="applydays"
					value="#{attLeaveApplyBB.leaveBo.applyDays}"></h:inputText>
				<h:inputText style="display:none" styleClass="input1"
					readonly="true" id="totalDays"
					value="#{attLeaveApplyBB.leaveBo.totalDays}"></h:inputText>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="请假原因" />
			<h:inputTextarea id="reason" cols="60" rows="5"
				value="#{attLeaveApplyBB.leaveBo.reason}"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01_center,td_middle" align="center"
			styleClass="table03">
			<h:outputText value="提示信息" />
			<f:verbatim>
				<div style="width: 350px; color: red;">
					<div id="applist"></div>
				</div>
			</f:verbatim>
		</h:panelGrid>
		<c:verbatim>
			<br />
		</c:verbatim>
		<h:panelGrid align="center">
			<h:commandButton id="saveleave" disabled="true" value="　保　存　"
				onclick="return checkDays();" styleClass="button01"
				action="#{attLeaveApplyBB.saveLeave}" />
		</h:panelGrid>
		<c:verbatim>
			<br />
		</c:verbatim>

		<c:verbatim>您的带薪假剩余情况：<br />
		</c:verbatim>
		<h:panelGrid columns="4" width="100%"
			columnClasses="td_form01,td_form02,td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="病假" />
			<h:outputText value="#{attLeaveApplyBB.days.a236202}" />
			<h:outputText value="婚假" />
			<h:outputText value="#{attLeaveApplyBB.days.a236203}" />
			<h:outputText value="丧假" />
			<h:outputText value="#{attLeaveApplyBB.days.a236204}" />
			<h:outputText value="产假"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="#{attLeaveApplyBB.days.a236205}"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="难产产假"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="#{attLeaveApplyBB.days.a236206}"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="带薪事假" />
			<h:outputText value="#{attLeaveApplyBB.days.a236207}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	interpret(document.forms(0));
	document.all("form1:applydays").value="";
</script>
