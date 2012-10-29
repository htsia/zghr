<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script language="javascript">
function deleteNewPerson(){
  check_test();
  var field = form1.all('selected_ids');
  if (checkMutilSelect(field)) {
      pageCodeExchange(document.forms(0));
  } else{
      alert("��ѡ����Ա��");
      return false;
  }
}
function forSel() {
    if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
       document.forms(0).all('form1:queryPerson').click();
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

</script>
<x:saveState value="#{querycardlogBB}" />
<h:form id="form1">
	<h:inputHidden id="superID" value="#{querycardlogBB.pageInits}"></h:inputHidden>
	<h:inputHidden id="personType" value="#{querycardlogBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{querycardlogBB.personTypeValue}"/>
	<h:panelGrid width="98%" columns="1" align="center">
	    <h:panelGrid columns="5" align="left">
	    <f:verbatim>
	        <input name="simple1" type="button" id=15 next=20 class="button01" value="ѡ����Ա���" onclick="forSel()">
	    </f:verbatim>
	        <h:outputText value="#{querycardlogBB.personTypeDesc}"></h:outputText>
	    </h:panelGrid>
		<h:panelGrid columns="10" align="left">
			<h:outputText value="������Ա����ţ�"></h:outputText>
			<h:inputText id="classnamevalue"
				value="#{querycardlogBB.findSeeValue}"></h:inputText>
			<h:commandButton id="queryPerson" value="��ѯ" styleClass="button01"
				action="#{querycardlogBB.findSee}"></h:commandButton>
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
				 <h:commandButton styleClass="button01" value="����" action="#{querycardlogBB.confirmMethod}" onclick="javascript:return deleteNewPerson();"/>

		</h:panelGrid>
        <h:panelGrid align="right">
        <h:panelGroup>
							<h:outputText value="��¼��:#{querycardlogBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{querycardlogBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{querycardlogBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="��ǰΪ��#{querycardlogBB.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{querycardlogBB.first1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{querycardlogBB.pre1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{querycardlogBB.next1}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{querycardlogBB.last1}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
        </h:panelGrid>
		<x:dataTable value="#{querycardlogBB.itemList}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);"/>
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
					<h:outputText value="��Ա���" />
				</c:facet>
				<h:outputText value="#{list.personSeq}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
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
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>



