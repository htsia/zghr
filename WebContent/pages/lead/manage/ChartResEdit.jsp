<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{chartmaintenanceBackingBean}"/>
<h:form id="form1">
    <h:inputHidden id="chartmaintenanceBackingBean" value="#{chartmaintenanceBackingBean.pageInit}"/>
    <h:panelGrid columns="3">
        <h:outputText value ="����:#{chartmaintenanceBackingBean.showcode}"/>
        <h:outputText value ="  "/>
        <h:outputText value ="����:#{chartmaintenanceBackingBean.showname}"/>
    </h:panelGrid>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="��" />
            <h:inputText   value="#{chartmaintenanceBackingBean.graphResBO.x}"  />

            <h:outputText value="��" style="width:70px" />
            <h:inputText  value="#{chartmaintenanceBackingBean.graphResBO.y}" />

            <h:outputText value="�б�ǩ" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.labelTitleX}" />

            <h:outputText value="�б�ǩ" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.labelTitleY}" />

            <h:outputText value="��Ӧ����" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.graphValue}" />
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{chartmaintenanceBackingBean.save}" onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
