<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{sys_showstaticBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_showstaticBB.showProperty}"></h:inputHidden>
<h:inputHidden id="setId" value="#{sys_showstaticBB.setId}"></h:inputHidden>
<c:verbatim><br></c:verbatim>

<h:panelGrid id="dateList" columns="2" width="80%"  columnClasses="td_form01,td_form02" align="center" styleClass="table03">
    <h:outputText value="��Ŀ����"/>
    <h:outputText  escape="false" value="#{sys_showstaticBB.typeDes}" />

    <h:outputText value="����"/>
    <h:panelGroup>
        <h:commandButton id="view" styleClass="button01" type="button" rendered="#{sys_showstaticBB.type=='1'}" value="�鿴��ʽ" onclick="return viewFormula('#{sys_showstaticBB.linkId}')" />
        <h:commandButton id="viewStandard" styleClass="button01" type="button" rendered="#{sys_showstaticBB.type=='0'}" value="�鿴��׼��" onclick="return viewStandard('#{sys_showstaticBB.linkId}')" />
        <h:commandButton id="viewTax" styleClass="button01"  type="button" rendered="#{sys_showstaticBB.field=='A815714'}" value="�鿴��˰����" onclick="return viewTax();" />
        <h:commandButton id="viewYearTax" styleClass="button01"  type="button" rendered="#{sys_showstaticBB.field=='A815756'}" value="�鿴��˰����" onclick="return viewYearTax();" />
    </h:panelGroup>

</h:panelGrid>

</h:form>    
