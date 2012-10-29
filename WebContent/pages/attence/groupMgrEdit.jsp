<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function doCheck() {
		if (document.all('form1:A001706').value == "") {
			alert("��¼���������!");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{group_mgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{group_mgrBB.initset}" />
	<h:panelGrid align="center" width="90%">
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">

			<h:outputText value="��������" />
			<h:inputText value="#{group_mgrBB.superName}" readonly="true"
				size="30" />

			<h:outputText value="��������" />
			<h:inputText value="#{group_mgrBB.groupbo.groupName}" id="A001706"
				size="30" />

			<h:outputText value="�������"></h:outputText>
			<h:selectOneMenu value="#{group_mgrBB.status}" onchange="submit();"
				valueChangeListener="#{group_mgrBB.changeStatus}">
				<c:selectItem itemLabel="������" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="���ڰ�" itemValue="2"></c:selectItem>
				<c:selectItem itemLabel="�⿼�ڰ�" itemValue="3"></c:selectItem>
				<c:selectItem itemLabel="�ֹ��Ű�" itemValue="4"></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="��ѡ���"
				rendered="#{group_mgrBB.isExist==true && group_mgrBB.isExist1==true}"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{group_mgrBB.className}"
					rendered="#{group_mgrBB.isExist==true && group_mgrBB.isExist1==true}" />
				<h:inputHidden id="groupid" value="#{group_mgrBB.groupbo.linkClass}" />
				<h:commandButton type="button" styleClass="button_select"
					rendered="#{group_mgrBB.isExist==true && group_mgrBB.isExist1==true}"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>

			<h:outputText value="" rendered="#{group_mgrBB.isExist==false}" />
			<h:outputText value="���ڰ�������"
				rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}" />
			<h:inputText value="#{group_mgrBB.groupbo.groupPeriod}"
				rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}" size="30" />
			<h:outputText value="�����������"
				rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}" />
			<h:panelGroup>
				<h:inputText id="attname1" value="#{group_mgrBB.groupbo.beginDate}"
					rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}"
					readonly="true" size="30">
				</h:inputText>
				<h:commandButton type="button" styleClass="button_select"
					rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}"
					size="30" onclick="PopUpCalendarDialog('form1:attname1');" />
			</h:panelGroup>
		</h:panelGrid>

		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="����"
				rendered="#{group_mgrBB.isExist==true && group_mgrBB.isExist1==true}"
				action="#{group_mgrBB.SaveSet}" onclick="return doCheck();" />
			<h:commandButton styleClass="button01" value="�������ڰ�"
				rendered="#{group_mgrBB.isExist==false && group_mgrBB.isExist1==true}"
				action="#{group_mgrBB.SaveSet1}" onclick="return doCheck();" />
			<h:commandButton styleClass="button01" value="����"
				rendered="#{group_mgrBB.isExist1==false}"
				action="#{group_mgrBB.SaveSet2}" onclick="return doCheck();" />
			<h:commandButton styleClass="button01" value="ȡ������"
				onclick="window.close();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
