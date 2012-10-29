<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{lain_StockBB}"/>
<h:form id="form1">
    <h:inputHidden id="stockDrawItemInit" value="#{lain_StockBB.stockDrawItemInit}"/>
    <h:inputHidden id="stockDrawItemInit" value="#{lain_StockBB.stockId}"/>
    <h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="  物资管理->  物资领用明细"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"  align="center" >
        <h:outputText value="物资名称：#{lain_StockBB.stockBO.stockName}"/>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="90%" >
        <h:panelGrid columns="5" cellspacing="2" rendered="#{lain_StockBB.queryByDateStatus == '1'}">
            <h:outputText value="开始时间"/>
            <h:panelGroup>
                <h:inputText value="#{lain_StockBB.startDate}" id="startDate" alt="开始时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
            </h:panelGroup>
            <h:outputText value="结束时间"/>
            <h:panelGroup>
                <h:inputText value="#{lain_StockBB.endDate}" id="endDate" alt="结束时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"/>
            </h:panelGroup>
            <h:commandButton value="查询" action="#{lain_StockBB.queryStockStockItem}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{lain_StockBB.stockList}" var="list" align="center"    id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center, td_middle_center,td_middle_left"
                 styleClass="table03" width="90%" >
         <h:column>
            <c:facet name="header"><h:outputText value="申领人"/></c:facet>
            <h:outputText value="#{list.drawPerson}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="领用时间"/></c:facet>
            <h:outputText value="#{list.drawItemDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="数量"/></c:facet>
            <h:outputText value="#{list.drawSum}"/>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>