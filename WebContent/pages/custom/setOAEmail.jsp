<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var user1 = document.all("form1:user1").value;
		if(user1==null || user1==''){
			alert("�����ÿ��ڷ�����");
			return false;
		}
		var oa1 = document.all("form1:oa1").value;
		if(oa1==null || oa1==''){
			alert("���ڷ�����OA�˻�������Ϊ��");
			return false;
		}
		var user2 = document.all("form1:user2").value;
		if(user2==null || user2==''){
			alert("��������Ա�춯������");
			return false;
		}
		var oa2 = document.all("form1:oa2").value;
		if(oa2==null || oa2==''){
			alert("��Ա�춯������OA�˻�������Ϊ��");
			return false;
		}
		var user3 = document.all("form1:user3").value;
		if(user3==null || user3==''){
			alert("��������Ա�춯������");
			return false;
		}
		var oa3 = document.all("form1:oa3").value;
		if(oa3==null || oa3==''){
			alert("��Ա�춯������OA�˻�������Ϊ��");
			return false;
		}
		var url = document.all("form1:url").value;
		if(url==null || url==''){
			alert("�ӿڵ�ַ����Ϊ��");
			return false;
		}
		var soa = document.all("form1:soa").value;
		if(soa==null || soa==''){
			alert("��������Ϊ��");
			return false;
		}
		return true;
	}
	function selperson(index){
		var id = window.showModalDialog(
						"/custom/selPerson2.jsf?",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(id!=null && id.length>0){
			document.all('form1:selectedUserid').value=index+","+id;
			return true;
		}else{
			return false;
		}
	}
</script>
<x:saveState value="#{oaemailBB}" />
<h:inputHidden value="#{oaemailBB.pageInit}"/>
<h:form id="form1">
	<h:inputHidden id="selectedUserID" value="#{oaemailBB.selectedUserID}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="OA�ʼ�����" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="98%" align="center">
		<f:verbatim><br/><br/></f:verbatim>
		<h:panelGrid columns="2" align="center" width="500" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="���ڷ�����"/>
			<h:panelGroup>
				<h:outputText value="����:"/>
				<h:inputText id="user1" value="#{oaemailBB.name1}" size="30" styleClass="input"/>
				<h:commandButton onclick="return selperson(1);" value="" styleClass="button_select" action="#{oaemailBB.selPerson}"/>
				<f:verbatim><br/></f:verbatim>			
				<h:outputText value="OA�˻���:"/>
				<h:inputText id="oa1" value="#{oaemailBB.oa1}" size="30" styleClass="input" readonly="true"/>
			</h:panelGroup>
			<h:outputText value="��Ա�춯������"/>
			<h:panelGroup>
				<h:outputText value="����:"/>
				<h:inputText id="user2" value="#{oaemailBB.name2}" size="30" styleClass="input"/>
				<h:commandButton onclick="return selperson(2);" value="" styleClass="button_select" action="#{oaemailBB.selPerson}"/>
				<f:verbatim><br/></f:verbatim>		
				<h:outputText value="OA�˻���:"/>
				<h:inputText id="oa2" value="#{oaemailBB.oa2}" size="30" styleClass="input" readonly="true"/>
			</h:panelGroup>
			<h:outputText value="��Ա�춯������"/>
			<h:panelGroup>
				<h:outputText value="����:"/>
				<h:inputText id="user3" value="#{oaemailBB.name3}" size="30" styleClass="input"/>
				<h:commandButton onclick="return selperson(3);" value="" styleClass="button_select" action="#{oaemailBB.selPerson}"/>
				<f:verbatim><br/></f:verbatim>			
				<h:outputText value="OA�˻���:"/>
				<h:inputText id="oa3" value="#{oaemailBB.oa3}" size="30" styleClass="input" readonly="true"/>
			</h:panelGroup>
			<h:outputText value="�ӿڵ�ַ"/>
			<h:inputText id="url" value="#{oaemailBB.url}" size="30" styleClass="input"/>
			<h:outputText value="����"/>
			<h:inputText id="soa" value="#{oaemailBB.soa}" size="30" styleClass="input"/>
			<h:outputText value="�Ƿ��Զ�������Ա�춯��Ϣ"/>
			<h:selectBooleanCheckbox value="#{oaemailBB.onoff}"/>
		</h:panelGrid>
		<f:verbatim><br/></f:verbatim>
		<h:panelGrid columns="1" align="center">
			<h:commandButton styleClass="button01" value="  ��  ��  " onclick="return forsave();" action="#{oaemailBB.save}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>

