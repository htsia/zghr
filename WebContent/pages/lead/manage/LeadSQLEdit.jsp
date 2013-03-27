<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function forsave(){
		var sql=document.getElementById("form1:sql").value;
		if(sql==''){
			alert("������sql");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{sqlmaintenanceBackingBean}"/>
<h:form id="form1">
    <h:inputHidden id="sqlmaintenanceBackingBean" value="#{sqlmaintenanceBackingBean.pageInit}"/>
    <h:inputHidden  id="resId" value="#{sqlmaintenanceBackingBean.leadsqlbo.resId}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="������" />
            <h:selectOneMenu value="#{sqlmaintenanceBackingBean.leadsqlbo.paraName}">
                <c:selectItems value="#{sqlmaintenanceBackingBean.paraList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="����"/>
            <h:selectOneMenu value="#{sqlmaintenanceBackingBean.leadsqlbo.sqltype}">
                <c:selectItem itemValue="1" itemLabel="SQL���"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="��ʽ"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="sql"/>
            <h:inputTextarea rows="10" id="sql" value="#{sqlmaintenanceBackingBean.leadsqlbo.sqlstr}" />

            <h:outputText value="����˳��"/>
            <h:inputText  value="#{sqlmaintenanceBackingBean.leadsqlbo.paraOrder}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{sqlmaintenanceBackingBean.save}" onclick="return forsave();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

