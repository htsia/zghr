<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>

<x:saveState value="#{studentAudit_ListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{studentAudit_ListBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��ѵ���� -> ��ѵ������"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

  <h:panelGrid align="center" width="98%" columns="1">
  		<h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
       				<h:outputText value="����" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personName}" readonly="true"/>
					<h:outputText value="�Ա�" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personSex}" readonly="true"/>
					<h:outputText value="�����༶" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.className}" readonly="true"/>
					<h:outputText value="����ʱ��" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.signTime}" readonly="true"/>
					<h:outputText value="��������" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personDept}" readonly="true"/>
					<h:outputText value="�������"/>
		            <h:selectOneMenu id="status" value="#{studentAudit_ListBB.studentbo.status}">
		                <c:selectItem itemValue="1" itemLabel="����ͨ��"/>
		                <c:selectItem itemValue="2" itemLabel="������ͨ��"/>
		            </h:selectOneMenu>
		            <h:outputText value="����"/>
		            <h:commandButton styleClass="button01" value="����" action="#{studentAudit_ListBB.audit}"
		                             onclick="return forCheck();" />
         </h:panelGrid>
        
		</h:panelGrid>
</h:form>
