<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{lain_SupplyBB}"/>
<h:form id="form1">
    <h:inputHidden id="supplyStockItemInit" value="#{lain_SupplyBB.supplyStockItemInit}"/>
	<h:inputHidden id="supplyStockItemInit" value="#{lain_SupplyBB.supplyId}"/>
    <h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 供应商管理 ->  供货明细"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"  align="center" >
        <h:outputText value="供应商：#{lain_SupplyBB.supplyBO.supName}"/>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="90%" rendered="#{lain_SupplyBB.queryByDateSatus == '1'}">
        <h:panelGrid columns="5" cellspacing="2">
            <h:outputText value="开始时间"/>
            <h:panelGroup>
                <h:inputText value="#{lain_SupplyBB.startDate}" id="startDate" alt="开始时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
            </h:panelGroup>
            <h:outputText value="结束时间"/>
            <h:panelGroup>
                <h:inputText value="#{lain_SupplyBB.endDate}" id="endDate" alt="结束时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"  />
            </h:panelGroup>
            <h:commandButton value="查询" action="#{lain_SupplyBB.querySupplyStockItem}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{lain_SupplyBB.supplyList}" var="list" align="center"    id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center, td_middle_center,td_middle_left,td_middle_left,td_middle_left"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="供货时间"/></c:facet>
            <h:outputText value="#{list.supplyDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="货物名称"/></c:facet>
            <h:outputText value="#{list.stockName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="数量"/></c:facet>
            <h:outputText value="#{list.acceptSum}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="单价(￥)"/></c:facet>
            <h:outputText value="#{list.acceptPrice}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="总价(￥)"/></c:facet>
            <h:outputText value="#{list.acceptTotal}"/>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>