<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
function check_test() {
	var beginTime = document.all('form1:beginTime').value;
	var begintimevalue = document.all('form1:begintimevalue').value;
	if(beginTime != null && beginTime != "" && begintimevalue != null && begintimevalue != ""){
        return true;
	}else{
		alert("���������ڻ�ʱ��Ϊ��");
		return false;
	}
}

function doAddItem() {
	var timevalue=window
			.showModalDialog(
					"/attence/personLeaveMessageTime.jsf",
					null,
					"dialogWidth:"+screen.width*0.3+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:yes;");
    if(timevalue!=null && timevalue!=""){
    	document.all('form1:begintimevalue').value=timevalue; 
    }else{
    	document.all('form1:begintimevalue').value="";
    }
	return true;
}
function selectNewPerson(){
	window.showModalDialog("/attence/RollbookRegistrationList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
return true;
}
function deleteNewPerson(){
  var field = form1.all('selected_ids');
  if (checkMutilSelect(field)) {
      pageCodeExchange(document.forms(0));
  } else{
      alert("��ѡ����Ա��");
      return false;
  }
}
var flag=0 ;
function showHide(obj){
	if(flag==0){
		obj.style.display="none";
		flag=1;
	}else{
		obj.style.display="";
		flag = 0;
	}
}
function confirmSave(form1){
        if (confirm('ȷ��Ҫ��������')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}
</script>
<h:form id="form1">
	<h:inputHidden id="str" value="#{querycardlogBB.initEdit}" />
	<h:panelGrid width="100%" border="0" styleClass="td_title"
		cellspacing="6" cellpadding="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڲ���"></h:outputText>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid border="0" align="center" columns="2" width="800">
		<h:panelGrid border="0" cellspacing="0" align="left" columns="1">
			<c:verbatim escape="false">
				<a href="javascript:showHide(ryTable);"><b> ��Ա��Ϣ</b></a>
			</c:verbatim>
		</h:panelGrid>
		<h:panelGrid border="0" cellspacing="0" align="right" columns="3">
			<h:commandButton styleClass="button01" value="ѡ����Ա"
				onclick="return selectNewPerson();" />
			<h:commandButton styleClass="button01" value="ȥ��"
				action="#{querycardlogBB.remove}"
				onclick="javascript:return deleteNewPerson();" />
		</h:panelGrid>
	</h:panelGrid>

	<c:verbatim>
		<br />
		<table id="ryTable" width="800" border="0" align="center">
			<tr>
				<td></c:verbatim> <x:dataTable value="#{querycardlogBB.lists}" var="list"
					id="dateList" rowIndexVar="index" headerClass="td_top"
					rowClasses="td_middle" styleClass="table03" width="800" border="1">
					<h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)" />
							</c:verbatim>
						</c:facet>
						<c:verbatim escape="false">
							<input type="checkbox" name="selected_ids"
								value="</c:verbatim>
                   <h:outputText value="#{list.id}"/>
                   <c:verbatim>">
						</c:verbatim>
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��Ա���" />
						</c:facet>
						<h:outputText value="#{list.personSeq}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.name}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="���ڿ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.card}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڻ���" />
						</c:facet>
						<h:outputText value="#{list.orgName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڲ���" />
						</c:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>

				</x:dataTable> <c:verbatim></td>
			</tr>
		</table>
		<br />
	</c:verbatim>
	<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0"
		styleClass="table03" align="center" columns="4"
		columnClasses="td_form01,td_form02,td_form01,td_form02">
		<h:outputText value="��������" />
		<h:panelGroup>
			<h:inputText styleClass="input" id="beginTime" size="12"
				alt="��ʼ����|0|d" value="#{querycardlogBB.begindatevalue}"
				readonly="true" />
			<h:commandButton type="button" styleClass="button_select"
				onclick="PopUpCalendarDialog('form1:beginTime');" />
		</h:panelGroup>

		<h:outputText value="����ʱ��" />
		<h:panelGroup>
			<h:inputText id="begintimevalue"
				value="#{querycardlogBB.begintimevalue}" size="12"></h:inputText>
			<h:commandButton onclick="return doAddItem();" type="button"
				styleClass="button_select"></h:commandButton>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid border="0" cellspacing="2" cellpadding="5" align="right"
		columns="2">
		<h:commandButton styleClass="button01" value="����"
			action="#{querycardlogBB.save_add}" onclick="return check_test();" />
		<h:commandButton styleClass="button01" value="����"
			onclick="window.close();" />
	</h:panelGrid>
</h:form>

<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>
