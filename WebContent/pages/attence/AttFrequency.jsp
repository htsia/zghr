<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%=request.getContextPath()%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		function hidden() {
			$("#week").hide();
			$("#dayDIV").hide();
			$("#quanQinTishi").hide();
			$("#applyDays").hide();
		}

		$(":radio").click(function() {
			hidden();
			var index = $(this).val();
			if (index == 0) {
				$("#week").show();
				$("#day1").show();
				$("#applyDays").show();
			} else if (index == 1) {				
				$("#dayDIV").show();
				$("#day1").hide();
				$("#applyDays").hide();
			} else if (index == 2) {
				$("#quanQinTishi").show();
				$("#day1").show();
				$("#applyDays").show();
			}
		});

		var type = document.all('form1:frequencyType').value;
		var fretxt = document.all('form1:frequencyTxt').value;//ѡ����ʱ��Ĵ�����,ѡ����ʱ���ܵ�ֵ

		if (type == 0) {//��
			$(":radio[value=0]").click();
			$(":checkbox").each(function() {//ѡ����
				if (fretxt.indexOf($(this).attr("value")) != -1) {
					$(this).attr("checked", 1);
				}
			});
		} else if (type == 1) {
			$(":radio[value=1]").click();
			$("textArea").val(fretxt);
		} else if (type == 2) {
			$(":radio[value=2]").click();
		}
		$("#begintime").val(document.all('form1:applybegintime').value);
		$("#endtime").val(document.all('form1:applyendtime').value);
	});

	function add() {
		var timename = document.all('A00001').value;
		PopUpCalendarDialog('form1:datestr');
		var ymd = document.all('form1:datestr').value;
		if (timename != null && timename != "") {
			document.all('A00001').value = timename + "," + ymd;
		} else {
			document.all('A00001').value = ymd;
		}
	}
	function forsave() {
		var index = $(":radio:checked").attr("value");
		if (index == 0||index==2) {
			if ($("#begintime").val() == "" || $("#endtime").val() == "") {
				alert("ʱ��α�������");
				return false;
			} else {
				document.all('form1:applybegintime').value = $("#begintime")
						.val();
				document.all('form1:applyendtime').value = $("#endtime").val();
				var t = "";
				$(":checkbox:checked").each(function() {
					t += $(this).attr("value") + ",";
				});
				document.all('form1:frequencyTxt').value = t;
			}
		} else {
			document.all('form1:frequencyTxt').value = $("textArea").val();
		}
		document.all('form1:frequencyType').value = index;
	}
	function resetday() {
		var index = $(":radio:checked").attr("value");
		if (index == 1) {
			$("#A00001").val("");
		}
	}
	function setapplytime(applyobj) {
		var time = document.all(applyobj).value;
		PopUpCalendarDialog('form1:applytime');
		var ymd = document.all('form1:applytime').value;
		if (ymd == null) {
			document.all(applyobj).value = "";
		} else {
			document.all(applyobj).value = ymd.substring(5);
		}
	}
</script>
<x:saveState value="#{att_class_set_childBB}" />
<h:inputHidden value="#{att_class_set_childBB.initFrequency}" />
<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		bgcolor="#FFFFFF">
		<tr>
			<td height=20 class="td_title"><img src="/images/tips.gif">Ƶ������
				-> </c:verbatim> <h:outputText
					value="#{att_class_set_childBB.attClassBO.className}" /> <c:verbatim></td>
		</tr>
	</table>
</c:verbatim>
<h:form id="form1">
	<h:inputHidden id="frequencyType"
		value="#{att_class_set_childBB.frequencyType}" />
	<h:inputHidden id="frequencyTxt"
		value="#{att_class_set_childBB.frequencyTxt}" />
	<h:inputHidden id="applybegintime"
		value="#{att_class_set_childBB.applyBeginDate}" />
	<h:inputHidden id="applyendtime"
		value="#{att_class_set_childBB.applyEndDate}" />
	<h:inputHidden id="datestr" value=""></h:inputHidden>
	<h:inputHidden id="applytime" value=""></h:inputHidden>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">

			<h:outputText value="�������" />
			<c:verbatim>
				<input name="fretype" value="1" type="radio" />��ʱ��
				<input name="fretype" value="2" type="radio" />ȫ���ճ���
				<input name="fretype" value="0" type="radio" />��ȫ���ճ���
				
			</c:verbatim>
			<c:verbatim>
			<input id="day1" value="����ʱ��"  disabled="disabled"  readonly="readonly" style="width: 60"/>
			</c:verbatim>
			<f:verbatim>
				<div id="applyDays">
					<table border="0">
						<tr>
							<td><input type="text" value="��ʼʱ��:"  disabled="disabled" readonly="readonly" style="width: 80"/></td>
							<td><input type="text" id="begintime"
								contenteditable="false" value="" /></td>
							<td><input type="button" class="button_select"
								onclick="setapplytime('begintime');"></td>
						</tr>
						<tr>
							<td><input type="text" value="����ʱ��:" disabled="disabled" readonly="readonly"  style="width: 80"/></td>
							<td><input id="endtime" contenteditable="false" value="" /></td>
							<td><input type="button" class="button_select"
								onclick="setapplytime('endtime');"></td>
						</tr>
					</table>
				</div>
			</f:verbatim>

			<h:outputText id="day1" value="����" />
			<c:verbatim>
				<div id="quanQinTishi" style="width: 270px;">
					"ȫ�ڱ�ʾʵ���ϰ��ʱ�䣬����Ҫ��,���������Ǽ��գ�����Ҫ�򿨣����ڵ�������Ҫ�ϰ࣬��ô�������ҲҪ��"</div>
				<div id="week" style="width: 270px;">
					<input type="checkbox" name="week" value="1" />��һ <input
						type="checkbox" name="week" value="2" />�ܶ� <input type="checkbox"
						name="week" value="3" />���� <input type="checkbox" name="week"
						value="4" />����<br /> <input type="checkbox" name="week"
						value="5" />���� <input type="checkbox" name="week" value="6" />����
					<input type="checkbox" name="week" value="7" />����
				</div>
				<div id="dayDIV" style="width: 270px;">
					<textArea id="A00001" cols="35" rows="5" readonly="readonly"></textArea>
					<input id="A00002" type="button" onclick="add();"
						class="button_select" value="" />
					<div id="intro" style="margin: 5px 0;">˵��������ѡ��������</div>
				</div>
			</c:verbatim>
		</h:panelGrid>
		<h:panelGrid columns="2" align="right">
			<c:verbatim>
				<input id="reset" type="button" onclick="resetday();"
					class="button01" value="�������" />
			</c:verbatim>
			<h:commandButton value="����"
				action="#{att_class_set_childBB.saveFrequency}"
				styleClass="button01" onclick="return forsave();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


