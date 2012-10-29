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
        <h:outputText value ="代码:#{chartmaintenanceBackingBean.showcode}"/>
        <h:outputText value ="  "/>
        <h:outputText value ="名称:#{chartmaintenanceBackingBean.showname}"/>
    </h:panelGrid>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="行" />
            <h:inputText   value="#{chartmaintenanceBackingBean.graphResBO.x}"  />

            <h:outputText value="列" style="width:70px" />
            <h:inputText  value="#{chartmaintenanceBackingBean.graphResBO.y}" />

            <h:outputText value="行标签" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.labelTitleX}" />

            <h:outputText value="列标签" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.labelTitleY}" />

            <h:outputText value="对应参数" style="width:70px"/>
            <h:inputText value="#{chartmaintenanceBackingBean.graphResBO.graphValue}" />
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{chartmaintenanceBackingBean.save}" onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
