<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{resmaintenanceBackingBean}"/>
<h:form id="form1">
    <h:inputHidden id="resmaintenanceBackingBean" value="#{resmaintenanceBackingBean.beginEdit}"/>
    <h:inputHidden  id="resId" value="#{resmaintenanceBackingBean.leadResBO.resId}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="代码" />
            <h:inputText id="rank" value="#{resmaintenanceBackingBean.leadResBO.showCode}" alt="代码|0" size="20" maxlength="20"/>

            <h:outputText value="描述"/>
            <h:inputText id="desc" value="#{resmaintenanceBackingBean.leadResBO.showName}" alt="描述|0"/>

            <h:outputText value="顺序码" />
            <h:inputText id="taxbegin" value="#{resmaintenanceBackingBean.leadResBO.orderNo}" alt="顺序码|0" size="20" maxlength="20"/>

            <h:outputText value="素材类型" />
            <h:selectOneMenu  value="#{resmaintenanceBackingBean.leadResBO.storeTable}"    style="width:80px">
                <f:selectItems value="#{resmaintenanceBackingBean.showtypes}"/>
            </h:selectOneMenu>

            <h:outputText value="产生频率" />
            <h:selectOneMenu  value="#{resmaintenanceBackingBean.leadResBO.updateFrequency}"    style="width:80px">
                <f:selectItems value="#{resmaintenanceBackingBean.levelselects}"/>
            </h:selectOneMenu>

            <h:outputText value="是否启用" />
            <h:selectOneMenu  value="#{resmaintenanceBackingBean.leadResBO.isuse}"    style="width:80px">
                <f:selectItem itemLabel="启用" itemValue="1"/>
                <f:selectItem itemLabel="禁用" itemValue="0"/>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{resmaintenanceBackingBean.save}" onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" type="button" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
