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
        <h:outputText value ="����:#{gridmaintenanceBackingBean.showcode}"/>
        <h:outputText value ="  "/>
        <h:outputText value ="����:#{gridmaintenanceBackingBean.showname}"/>
    </h:panelGrid>
    
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="˳��" />
            <h:inputText   value="#{gridmaintenanceBackingBean.gridResBO.orderNo}" style="width:40px" />

            <h:outputText value="��Ϣ1" style="width:80px" />
            <h:inputText  value="#{gridmaintenanceBackingBean.gridResBO.showInfo1}" />

            <h:outputText value="��Ϣ2" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo2}" />

            <h:outputText value="��Ϣ3" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo3}" />

            <h:outputText value="��Ϣ4" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo4}" />

            <h:outputText value="��Ϣ5" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo5}" />

            <h:outputText value="��Ϣ6" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo6}" />

            <h:outputText value="��Ϣ7" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo7}" />

            <h:outputText value="��Ϣ8" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo8}" />

            <h:outputText value="��Ϣ9" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo9}" />

            <h:outputText value="��Ϣ10" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo10}" />

            <h:outputText value="��Ϣ11" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo11}" />

            <h:outputText value="��Ϣ12" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo12}" />

            <h:outputText value="��Ϣ13" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo13}" />

            <h:outputText value="��Ϣ14" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo14}" />

            <h:outputText value="��Ϣ15" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo15}" />

            <h:outputText value="��Ϣ16" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo16}" />

            <h:outputText value="��Ϣ17" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo17}" />

            <h:outputText value="��Ϣ18" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo18}" />

            <h:outputText value="��Ϣ19" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo19}" />

             <h:outputText value="��Ϣ20" style="width:80px"/>
             <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo20}" />

            <h:outputText value="��Ϣ21" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo21}" />


            <h:outputText value="��Ϣ22" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo22}" />

           <h:outputText value="��Ϣ23" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo23}" />


            <h:outputText value="��Ϣ24" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo24}" />

           <h:outputText value="��Ϣ25" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo25}" />


            <h:outputText value="��Ϣ26" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo26}" />

           <h:outputText value="��Ϣ27" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo27}" />

            <h:outputText value="��Ϣ28" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo28}" />

           <h:outputText value="��Ϣ29" style="width:80px"/>
           <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo29}" />

            <h:outputText value="��Ϣ30" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo30}" />

            <h:outputText value="��Ϣ31" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo31}" />

            <h:outputText value="��Ϣ32" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo32}" />

            <h:outputText value="��Ϣ33" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo33}" />

            <h:outputText value="��Ϣ34" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo34}" />

            <h:outputText value="��Ϣ35" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo35}" />

            <h:outputText value="��Ϣ36" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo36}" />

            <h:outputText value="��Ϣ37" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo37}" />

            <h:outputText value="��Ϣ38" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo38}" />

            <h:outputText value="��Ϣ39" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo39}" />

            <h:outputText value="��Ϣ40" style="width:80px"/>
            <h:inputText value="#{gridmaintenanceBackingBean.gridResBO.showInfo40}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{gridmaintenanceBackingBean.save}" onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
