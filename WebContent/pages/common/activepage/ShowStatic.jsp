<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{sys_showstaticBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_showstaticBB.pageInit}"></h:inputHidden>
<c:verbatim><br></c:verbatim>

<h:panelGrid id="dateList" columns="2" width="80%"  columnClasses="td_form01,td_form02" align="center" styleClass="table03">
    <h:outputText value="������"/>
    <h:outputText  value="#{sys_showstaticBB.colName}" />

    <h:outputText value="��������"/>
    <h:outputText  value="#{sys_showstaticBB.colType}" />

    <h:outputText value="���ݸ�ʽ"/>
    <h:outputText  value="#{sys_showstaticBB.colPre}" />

    <h:outputText value="��¼��"/>
    <h:outputText  value="#{sys_showstaticBB.count}" />

    <h:outputText value="�ϼ�"/>
    <h:outputText  value="#{sys_showstaticBB.sum}" />

    <h:outputText value="ƽ��ֵ"/>
    <h:outputText  value="#{sys_showstaticBB.avg}" />

    <h:outputText value="���ֵ"/>
    <h:outputText  value="#{sys_showstaticBB.max}" />

    <h:outputText value="��Сֵ"/>
    <h:outputText  value="#{sys_showstaticBB.min}" />

</h:panelGrid>

</h:form>    
