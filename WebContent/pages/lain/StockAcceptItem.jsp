<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{lain_StockAcceptGatherBB}"/>
<h:form id="form1">
    <h:inputHidden id="stockDrawItemInit" value="#{lain_StockAcceptGatherBB.stockAcceptItemInit}"/>
    <h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="  物资管理->  物资领用明细"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"  align="center" >
        <h:outputText value="物资名称：#{lain_StockAcceptGatherBB.stockBo.stockName}"/>
    </h:panelGrid>

    <h:dataTable value="#{lain_StockAcceptGatherBB.stockAceptList}" var="list" align="center"    id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center, td_middle_center,td_middle_center,td_middle_left,td_middle_left,td_middle_left"
                 styleClass="table03" width="90%" >
         <h:column>
            <c:facet name="header"><h:outputText value="供货编号"/></c:facet>
            <h:outputText value="#{list.acceptCode}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="入库时间"/></c:facet>
            <h:outputText value="#{list.supplyDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="供货商"/></c:facet>
            <h:outputText value="#{list.supName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="单价(￥)"/></c:facet>
            <h:outputText value="#{list.acceptPrice}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="数量"/></c:facet>
            <h:outputText value="#{list.acceptSum}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="总价"/></c:facet>
            <h:outputText value="#{list.acceptTotal}"/>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>