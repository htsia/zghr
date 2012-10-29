<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>

<x:saveState value="#{ccp_queryPersonbBB}" />
<h:form id="form1">
<h:inputHidden value="#{ccp_queryPersonbBB.pageInit}"></h:inputHidden>
<f:verbatim><br></f:verbatim>
<h:panelGrid width="95%" border="0" align="center" cellpadding="0" cellspacing="0" columns="2">
    <h:panelGroup>
         <h:outputText value="本单位转入  "   styleClass="f04"/>
        <h:outputText value="姓名："/>
        <h:inputText id="personName" value="#{ccp_queryPersonbBB.personName}" size="20"/>
        <h:outputText value=" "/>
        <h:outputText value="开始日期："/>
        <h:inputText id="stDate" value="#{ccp_queryPersonbBB.stDate}" size="12"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:stDate');return false;"/>
        <h:outputText value=" "/>
        <h:outputText value="至"/>
        <h:outputText value=" "/>
        <h:inputText id="enEDate" value="#{ccp_queryPersonbBB.enEDate}" size="12"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:enEDate');return false;"/>
        <h:outputText value=" "/>
        <h:commandButton id="qry" value="查询" styleClass="button01" action="#{ccp_queryPersonbBB.queryPersonInfo}"/>
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:dataTable width="95%" value="#{ccp_queryPersonbBB.relationvo}" var="list" id="dateList"
             headerClass="td_top" rowClasses="td_middle_center" styleClass="table03" border="1" align="center">
    <h:column>
        <f:facet name="header"><h:outputText value="姓名"/></f:facet>
        <h:outputText value="#{list.personName}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="性别"/></f:facet>
        <h:outputText value="#{list.personGender}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="出生日期"/></f:facet>
        <h:outputText value="#{list.personBirthday}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="政治面貌"/></f:facet>
        <h:outputText value="#{list.partyFigure}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="所在党组织"/></f:facet>
        <h:outputText value="#{list.partyUnit}"/>
    </h:column>
    <h:column >
        <f:facet name="header"><h:outputText value="所属机构"/></f:facet>
        <h:outputText value="#{list.sendUnit}"/>
    </h:column>
    <h:column  >
        <f:facet name="header"><h:outputText value="转入日期"/></f:facet>
        <h:outputText value="#{list.comeDate}"/>
    </h:column>
    
    <h:column  >
        <f:facet name="header"><h:outputText value="转入类型"/></f:facet>
        <h:outputText value="#{list.comeType}"/>
    </h:column>
</h:dataTable>
 
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>

</h:form>
