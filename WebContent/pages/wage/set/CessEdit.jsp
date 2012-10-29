<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>

<x:saveState value="#{wage_cesslistBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_cesslistBB.pageInit}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:inputTextarea id="desc" value="#{wage_cesslistBB.wcbo.description}" cols="35" rows="5"/>

            <h:outputText value="����" />
            <h:inputText id="rank" value="#{wage_cesslistBB.wcbo.rank}" alt="����|0" size="20" maxlength="20"/>

            <h:outputText value="������" />
            <h:inputText id="taxbegin" value="#{wage_cesslistBB.wcbo.taxBegin}" alt="������|0" size="20" maxlength="20"/>

            <h:outputText value="����" />
            <h:selectOneRadio value="#{wage_cesslistBB.wcbo.taxType}">
                 <c:selectItem itemLabel="��˰����" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="����˰����" itemValue="1"></c:selectItem>
            </h:selectOneRadio>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{wage_cesslistBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

