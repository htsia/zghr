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
		/*�������룬��������ᣬ������+0.5  */
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
		/*�������룬��������ᣬ������+0.5  */
		var day1=Math.round(day);
		if(day-parseInt(day)<0.5){
			day1=day1+0.5;
		}else if(day-parseInt(day)==0.5){
			day1=day1-0.5;
		}
		if (beginDate == null || beginDate == "") {
			alert("��ѡ��ʼ����");
			return false;
		} else if (endDate == null || endDate == "") {
			alert("��ѡ���������");
			return false;
		} else if (beginDate > endDate) {
			alert("��������С�ڿ�ʼ����");
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
			if (day <= 15) {
				if (confirm("����ʱ��" + day1 + "�죬��ȥ��н���٣��������۳�30%*�����յĲ��ٿۿ�,��ȷ��")) {
				} else {
					return false;
				}
			} else if (day <= 30) {
				if (confirm("����ʱ��" + day1 + "�죬��ȥ��н���٣��������۳�30%*�����յĲ��ٿۿ�,��ȷ��")) {
				} else {
					return false;
				}
			} else {
				if (confirm("����ʱ��" + day1 + "�죬��ȥ��н���٣��������۳�30%*�����յĲ��ٿۿ�,��ȷ��")) {
				} else {
					return false;
				}
			}
		} else if (type == 3) {
			var day = document.all("form1:leaveday3").value;

			var left = day - applydays;
			if (left < 0) {
				alert("���Ļ�ٻ��� " + day + "��   ���������������,��ѡ���������,���߼����������:");
				return false;
			}
		} else if (type == 4) {
			var day = document.all("form1:leaveday4").value;
			var left = day - applydays;
			if (left < 0) {
				alert("����ɥ�ٻ��� " + day + "��   ���������������,��ѡ���������,���߼����������:");
				return false;
			}
		} else if (type == 5) {
			var day = document.all("form1:leaveday5").value;
			var left = day - applydays;
			if (left < 0) {
				alert("���Ĳ��ٻ��� " + day + "��   ���������������,��ѡ���������,���߼����������:");
				return false;
			}
		} else if (type == 6) {
			var day = document.all("form1:leaveday6").value;
			var left = day - applydays;
			if (left < 0) {
				alert("�����Ѳ����ٻ��� " + day + "��   ���������������,��ѡ���������,���߼����������:");
				return false;
			}
		} else if (type == 7) {
			var day = document.all("form1:leaveday7").value;
			var left = day - applydays;
			if (left < 0) {
				alert("���Ĵ�н�¼ٻ��� " + day + "��   ���������������,��ѡ���������,���߼����������:");
				return false;
			}
		}
		if (day > 10) {
			var str = "����ʱ��" + day1
					+ "��,�ﵽ���ٱ�׼�����ڽ������뵽������Դ�����٣�����֮ǰ������һֱ�������״̬���������ˣ�����ϵ������Դ��������ʦ";

			if(!confirm(str)){
				return false;
			}
		}
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

		return (date2 - date1) / (1000 * 60 * 60 * 24); //�������
	}
</script>

<x:saveState value="#{attLeaveApplyBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attLeaveApplyBB.initEdit}"></h:inputHidden>
	<!-- ����н��ʣ���������װ -->
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
			<h:selectOneMenu id="leaveType"
				value="#{attLeaveApplyBB.leaveBo.leaveType}">
				<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}" />
			</h:selectOneMenu>
			<h:outputText value="��ʼʱ��" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime"
					value="#{attLeaveApplyBB.leaveBo.beginTime}" readonly="true"
					onchange="getApplyDays();"
					alt="��ʼ����|0|d|50||" />
				<c:verbatim>
					<img
						onclick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:beginTime'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle">
				</c:verbatim>
			</h:panelGroup>

			<h:outputText value="����ʱ��" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime"
					value="#{attLeaveApplyBB.leaveBo.endTime}" readonly="true"
					onchange="getApplyDays();"
					alt="��������|0|d|50||" />
				<c:verbatim>
					<img
						onclick="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:endTime'})"
						src="../../images/search.gif" class="button_select" width="16"
						height="22" align="absmiddle">
				</c:verbatim>
			</h:panelGroup>
			<h:outputText value="���ʱ��/��" />
			<h:inputText readonly="true" id="applydays"
				value="#{attLeaveApplyBB.leaveBo.applyDays}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="���ԭ��" />
			<h:inputTextarea cols="60" rows="5"
				value="#{attLeaveApplyBB.leaveBo.reason}"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return checkDays();"
				styleClass="button01" action="#{attLeaveApplyBB.saveLeave}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	interpret(document.forms(0));
</script>