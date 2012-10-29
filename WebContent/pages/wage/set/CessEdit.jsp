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
            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="#{wage_cesslistBB.wcbo.description}" cols="35" rows="5"/>

            <h:outputText value="级数" />
            <h:inputText id="rank" value="#{wage_cesslistBB.wcbo.rank}" alt="级数|0" size="20" maxlength="20"/>

            <h:outputText value="起征点" />
            <h:inputText id="taxbegin" value="#{wage_cesslistBB.wcbo.taxBegin}" alt="起征点|0" size="20" maxlength="20"/>

            <h:outputText value="属性" />
            <h:selectOneRadio value="#{wage_cesslistBB.wcbo.taxType}">
                 <c:selectItem itemLabel="含税所得" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="不含税所得" itemValue="1"></c:selectItem>
            </h:selectOneRadio>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_cesslistBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

