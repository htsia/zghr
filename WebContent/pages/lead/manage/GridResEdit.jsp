<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{gridmaintenanceBackingBean}"/>
<h:form id="form1">
    <h:inputHidden id="gridmaintenanceBackingBean" value="#{gridmaintenanceBackingBean.pageInit}"/>
    <h:inputHidden  id="resId" value="#{gridmaintenanceBackingBean.gridResBO.resId}"/>
    <h:panelGrid columns="3">
        <h:outputText value ="代码:#{gridmaintenanceBackingBean.showcode}"/>
        <h:outputText value ="  "/>
        <h:outputText value ="名称:#{gridmaintenanceBackingBean.showname}"/>
    </h:panelGrid>
    
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="顺序" />
            <h:inputText   value="#{gridmaintenanceBackingBean.gridResBO.orderNo}" style="width:40px" />

            <h:outputText value="信息1" style="width:80px" />
            <h:inputText  value="#{gridmaintenanceBackingBean.gridResBO.showInfo1}" />

            <h:outputText value="信息2" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo2}" />

            <h:outputText value="信息3" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo3}" />

            <h:outputText value="信息4" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo4}" />

            <h:outputText value="信息5" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo5}" />

            <h:outputText value="信息6" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo6}" />

            <h:outputText value="信息7" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo7}" />

            <h:outputText value="信息8" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo8}" />

            <h:outputText value="信息9" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo9}" />

            <h:outputText value="信息10" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo10}" />

            <h:outputText value="信息11" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo11}" />

            <h:outputText value="信息12" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo12}" />

            <h:outputText value="信息13" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo13}" />

            <h:outputText value="信息14" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo14}" />

            <h:outputText value="信息15" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo15}" />

            <h:outputText value="信息16" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo16}" />

            <h:outputText value="信息17" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo17}" />

            <h:outputText value="信息18" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo18}" />

            <h:outputText value="信息19" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo19}" />

             <h:outputText value="信息20" style="width:80px"/>
             <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo20}" />

            <h:outputText value="信息21" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo21}" />


            <h:outputText value="信息22" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo22}" />

           <h:outputText value="信息23" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo23}" />


            <h:outputText value="信息24" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo24}" />

           <h:outputText value="信息25" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo25}" />


            <h:outputText value="信息26" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo26}" />

           <h:outputText value="信息27" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo27}" />

            <h:outputText value="信息28" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo28}" />

           <h:outputText value="信息29" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo29}" />

            <h:outputText value="信息30" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo30}" />

            <h:outputText value="信息31" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo31}" />

            <h:outputText value="信息32" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo32}" />

            <h:outputText value="信息33" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo33}" />

            <h:outputText value="信息34" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo34}" />

            <h:outputText value="信息35" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo35}" />

            <h:outputText value="信息36" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo36}" />

            <h:outputText value="信息37" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo37}" />

            <h:outputText value="信息38" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo38}" />

            <h:outputText value="信息39" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo39}" />

            <h:outputText value="信息40" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo40}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{gridmaintenanceBackingBean.save}" onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
