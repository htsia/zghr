<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{sys_showstaticBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_showstaticBB.pageInit}"></h:inputHidden>
<c:verbatim><br></c:verbatim>

<h:panelGrid id="dateList" columns="2" width="80%"  columnClasses="td_form01,td_form02" align="center" styleClass="table03">
    <h:outputText value="列名称"/>
    <h:outputText  value="#{sys_showstaticBB.colName}" />

    <h:outputText value="数据类型"/>
    <h:outputText  value="#{sys_showstaticBB.colType}" />

    <h:outputText value="数据格式"/>
    <h:outputText  value="#{sys_showstaticBB.colPre}" />

    <h:outputText value="记录数"/>
    <h:outputText  value="#{sys_showstaticBB.count}" />

    <h:outputText value="合计"/>
    <h:outputText  value="#{sys_showstaticBB.sum}" />

    <h:outputText value="平均值"/>
    <h:outputText  value="#{sys_showstaticBB.avg}" />

    <h:outputText value="最大值"/>
    <h:outputText  value="#{sys_showstaticBB.max}" />

    <h:outputText value="最小值"/>
    <h:outputText  value="#{sys_showstaticBB.min}" />

</h:panelGrid>

</h:form>    
