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
            <h:outputText value="  ���ʹ���->  ����������ϸ"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"  align="center" >
        <h:outputText value="�������ƣ�#{lain_StockBB.stockBO.stockName}"/>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="90%" >
        <h:panelGrid columns="5" cellspacing="2" rendered="#{lain_StockBB.queryByDateStatus == '1'}">
            <h:outputText value="��ʼʱ��"/>
            <h:panelGroup>
                <h:inputText value="#{lain_StockBB.startDate}" id="startDate" alt="��ʼʱ��|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
            </h:panelGroup>
            <h:outputText value="����ʱ��"/>
            <h:panelGroup>
                <h:inputText value="#{lain_StockBB.endDate}" id="endDate" alt="����ʱ��|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"/>
            </h:panelGroup>
            <h:commandButton value="��ѯ" action="#{lain_StockBB.queryStockStockItem}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{lain_StockBB.stockList}" var="list" align="center"    id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center, td_middle_center,td_middle_left"
                 styleClass="table03" width="90%" >
         <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.drawPerson}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.drawItemDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.drawSum}"/>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>