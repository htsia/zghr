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
				//��ʼ�ͽ���ʱ��׺�����ϻ�������������ϵ�Сʱ	
				document.all("form1:totalDays").value = dateDiff(realBeginTime,
						realEndTime);
				$.ajax({
					type : "POST",
					url : "/pages/ajax/attRealDays.jsp",
					data : "beginTime=" + realBeginTime + "&endTime="
							+ realEndTime,
					success : function(msg) {
						if (msg == -1) {
							alert("��û���ϼ���λ�������");
						} else {
							document.all("form1:saveleave").disabled = "";
							var info = msg.split(',');
							document.all("form1:applydays").value = info[0];
							var userlist = "";
							for ( var i = 1; i < info.length - 1; i++) {
								userlist += "��" + i + "�����ˣ�" + info[i]
										+ "<br/>";
							}
							$("#applist").html(userlist);
						}
					}
				});
			} else {
				$("#applist").html("����ʱ��Ӧ���ڿ�ʼʱ��");
			}
		}
	}
	function checkDays() {
		//����������������¼�
		var type = document.all("form1:leaveType").value;
		var applydays = document.all("form1:applydays").value;
		var beginDate = document.all("form1:beginTime").value;
		var endDate = document.all("form1:endTime").value;
		//��ʼ�ͽ���ʱ��׺�����ϻ�������������ϵ�Сʱ
		var beginHour = document.all("beginHour").value;
		var endHour = document.all("endHour").value;
		var realBeginTime = beginDate + " " + beginHour;
		var realEndTime = endDate + " " + endHour;
		var alldays = dateDiff(realBeginTime, realEndTime);
		
  		var str = getNowDate();
  		
		if (beginDate == null || beginDate == "") {
			alert("��ѡ��ʼ����");
			return false;
		}else if(beginDate<str){
  			alert("��ʼʱ�䲻��С�ڵ���");
  			return false;
  		} else if (endDate == null || endDate == "") {
			alert("��ѡ���������");
			return false;
		} else if (realBeginTime >= realEndTime) {
			alert("��������Ҫ���ڿ�ʼ����");
			return false;
		} else if (applydays == null || applydays == "") {
			alert("����д�������");
			return false;
		} else if (applydays <= 0) {
			alert("����д��ȷ�������");
			return false;
		} else if (isNaN(applydays)) {
			alert("�������Ϊ����");
			return false;
		}
		if (type == 2) {
			if (alldays <= 15) {
				if (confirm("������н�ٵĹ����գ������۳�30%�Ĺ��ʣ���ȷ�ϡ�")) {
				} else {
					return false;
				}
			} else if (alldays <= 30) {
				if (confirm("������н�ٵĹ����գ������۳�50%�Ĺ��ʣ���ȷ�ϡ�")) {
				} else {
					return false;
				}
			} else if (alldays <= 60) {
				if (confirm("������н�ٵĹ����գ������۳�80%�Ĺ��ʣ���ȷ�ϡ�")) {
				} else {
					return false;
				}
			} else {
				if (confirm("������н�ٵĹ����գ������۳�ȫ��ʣ���ȷ�ϡ�")) {
				} else {
					return false;
				}
			}
		} else if (type == 3) {
			//ʣ��Ĵ�н������
			var day = document.all("form1:leaveday3").value;
			//��ȥ������������Ժ������
			var left = day - applydays;
			if (left < 0) {
				alert("���Ļ�ٻ��� " + (day - 0) + "�죬С�ڱ��������������ѡ��������٣����߼������������");
				return false;
			} else {
				//�����û�������еļ���
				var undoneDays = document.all("form1:leaveday33").value;
				//��ȥδ�����Ĵ�н������
				if (left - undoneDays < 0) {
					alert("����" + undoneDays + "��������������ʣ���ٻ���"
							+ (day - undoneDays - 0)
							+ "�죬 С�ڱ��������������ѡ��������٣����߼������������");
					return false;
				}
			}
		} else if (type == 4) {
			var day = document.all("form1:leaveday4").value;
			var left = day - applydays;
			if (left < 0) {
				alert("����ɥ�ٻ��� " + (day - 0) + "�죬С�ڱ��������������ѡ��������٣����߼������������");
				return false;
			} else {
				//�����û�������еļ���
				var undoneDays = document.all("form1:leaveday44").value;
				//��ȥδ�����Ĵ�н������
				if (left - undoneDays < 0) {
					alert("����" + undoneDays + "��ɥ������������ʣ��ɥ�ٻ���"
							+ (day - undoneDays - 0)
							+ "�죬 С�ڱ��������������ѡ��������٣����߼������������");
					return false;
				}
			}
		} else if (type == 5) {			
			document.all("form1:applydays").value = alldays;
			var day = document.all("form1:leaveday5").value;
			var left = day - alldays;
			if (left < 0) {
				alert("���Ĳ��ٻ��� " + (day - 0) + "�죬 С�ڱ��������������ѡ��������٣����߼������������");
				return false;
			} else {
				//�����û�������еļ���
				var undoneDays = document.all("form1:leaveday55").value;
				//��ȥδ�����Ĵ�н������
				if (left - undoneDays < 0) {
					alert("����" + undoneDays + "���������������ʣ����ٻ���"
							+ (day - undoneDays - 0)
							+ "�죬С�ڱ��������������ѡ��������٣����߼������������");
					return false;
				}
			}
		} else if (type == 6) {
			document.all("form1:applydays").value = alldays;
			var day = document.all("form1:leaveday6").value;
			var left = day - alldays;
			if (left < 0) {
				alert("�����Ѳ����ٻ��� " + (day - 0) + "�죬С�ڱ��������������ѡ��������٣����߼������������");
				return false;
			} else {
				//�����û�������еļ���
				var undoneDays = document.all("form1:leaveday66").value;
				//��ȥδ�����Ĵ�н������
				if (left - undoneDays < 0) {
					alert("����" + undoneDays + "���Ѳ���������������ʣ���Ѳ����ٻ���"
							+ (day - undoneDays - 0)
							+ "�죬 С�ڱ��������������ѡ��������٣����߼������������");
					return false;
				}
			}

		} else if (type == 7) {
			var day = document.all("form1:leaveday7").value;
			var left = day - applydays;
			if (left < 0) {
				alert("���Ĵ�н�¼ٻ��� " + (day - 0) + "�죬С�ڱ��������������ѡ��������٣����߼������������");
				return false;
			} else {
				//�����û�������еļ���
				var undoneDays = document.all("form1:leaveday77").value;
				//��ȥδ�����Ĵ�н������
				if (left - undoneDays < 0) {
					alert("����" + undoneDays + "���н�¼�����������ʣ���н�¼ٻ���"
							+ (day - undoneDays - 0)
							+ "�죬С�ڱ��������������ѡ��������٣����߼������������");
					return false;
				}
			}
		}
		if (applydays > 10) {
			var str = "�����"
					+ applydays
					+ "�������գ������٣����ڽ������뵽������Դ�����١�����֮ǰ������һֱ�������״̬���������ˣ�����ϵ������Դ��������ʦ��";

			if (!confirm(str)) {
				return false;
			}
		}
		//�ж�ԭ���Ƿ����
		var reason = document.all("form1:reason").value;
		if (reason.length > 100) {
			alert("ԭ���ܳ���100�֡�");
			return false;
		}
		//����ʼ�ͽ���ʱ�丳ֵ
		document.all("form1:totalDays").value = alldays;
		document.all("form1:beginTime").value = realBeginTime;
		document.all("form1:endTime").value = realEndTime;
		return true;
	}

	//�ַ���ת��Time(dateDiff)���跽��
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

		var allDay = (date2 - date1) / (1000 * 60 * 60 * 24); //�������
		/*�������룬��������ᣬ������+0.5  */
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
	<!-- ����н��ʣ���������װ -->
	<h:inputHidden id="leaveday2" value="#{attLeaveApplyBB.days.a236202}"></h:inputHidden>
	<h:inputHidden id="leaveday3" value="#{attLeaveApplyBB.days.a236203}"></h:inputHidden>
	<h:inputHidden id="leaveday4" value="#{attLeaveApplyBB.days.a236204}"></h:inputHidden>
	<h:inputHidden id="leaveday5" value="#{attLeaveApplyBB.days.a236205}"></h:inputHidden>
	<h:inputHidden id="leaveday6" value="#{attLeaveApplyBB.days.a236206}"></h:inputHidden>
	<h:inputHidden id="leaveday7" value="#{attLeaveApplyBB.days.a236207}"></h:inputHidden>
	<!--û��׼�Ĵ�н������  -->
	<h:inputHidden id="leaveday33" value="#{attLeaveApplyBB.undoneDays.a3}"></h:inputHidden>
	<h:inputHidden id="leaveday44" value="#{attLeaveApplyBB.undoneDays.a4}"></h:inputHidden>
	<h:inputHidden id="leaveday55" value="#{attLeaveApplyBB.undoneDays.a5}"></h:inputHidden>
	<h:inputHidden id="leaveday66" value="#{attLeaveApplyBB.undoneDays.a6}"></h:inputHidden>
	<h:inputHidden id="leaveday77" value="#{attLeaveApplyBB.undoneDays.a7}"></h:inputHidden>


	<!--�����ʵ������  -->
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�������" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="98%" align="center">
		<h:panelGrid columns="4" width="100%"
			columnClasses="td_form01,td_form02,td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="������" />
			<h:outputText value="#{attLeaveApplyBB.personName}" />
			<h:outputText value="�������" />
			<h:selectOneMenu id="leaveType" onchange="isChanjia()"
				value="#{attLeaveApplyBB.leaveBo.leaveType}">
				<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}" />
			</h:selectOneMenu>
			<h:outputText value="��ʼʱ��" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime"
					value="#{attLeaveApplyBB.leaveBo.beginTime}" readonly="true"
					alt="��ʼ����|0|d|50||"/>
				<c:verbatim>
				<input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:beginTime');getApplyDays();">
					<select id="beginHour" onchange="getApplyDays();">
						<option value="00:00">����</option>
						<option value="12:00">����</option>
					</select>
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="����ʱ��" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime"
					value="#{attLeaveApplyBB.leaveBo.endTime}" readonly="true"
					alt="��������|0|d|50||"/>
				<c:verbatim>
				<input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:endTime');getApplyDays();">
					<select id="endHour" onchange="getApplyDays();">
						<option value="23:59">����</option>
						<option value="12:00">����</option>
					</select>
				</c:verbatim>
			</h:panelGroup>
			<h:panelGroup>
				<h:outputText id="nochan" value="���ʱ��/����������" />
				<h:outputText id="chan" style="display:none" value="��  ��/�Ѳ���������" />
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
			<h:outputText value="���ԭ��" />
			<h:inputTextarea id="reason" cols="60" rows="5"
				value="#{attLeaveApplyBB.leaveBo.reason}"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01_center,td_middle" align="center"
			styleClass="table03">
			<h:outputText value="��ʾ��Ϣ" />
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
			<h:commandButton id="saveleave" disabled="true" value="�������桡"
				onclick="return checkDays();" styleClass="button01"
				action="#{attLeaveApplyBB.saveLeave}" />
		</h:panelGrid>
		<c:verbatim>
			<br />
		</c:verbatim>

		<c:verbatim>���Ĵ�н��ʣ�������<br />
		</c:verbatim>
		<h:panelGrid columns="4" width="100%"
			columnClasses="td_form01,td_form02,td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="����" />
			<h:outputText value="#{attLeaveApplyBB.days.a236202}" />
			<h:outputText value="���" />
			<h:outputText value="#{attLeaveApplyBB.days.a236203}" />
			<h:outputText value="ɥ��" />
			<h:outputText value="#{attLeaveApplyBB.days.a236204}" />
			<h:outputText value="����"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="#{attLeaveApplyBB.days.a236205}"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="�Ѳ�����"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="#{attLeaveApplyBB.days.a236206}"
				rendered="#{attLeaveApplyBB.personSex=='female' }" />
			<h:outputText value="��н�¼�" />
			<h:outputText value="#{attLeaveApplyBB.days.a236207}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	interpret(document.forms(0));
	document.all("form1:applydays").value="";
</script>
