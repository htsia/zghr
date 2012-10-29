<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_ConstBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_ConstBB.pageInit}"/>
    <h:inputHidden id="setID" value="#{wage_ConstBB.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_ConstBB.dateId}"/>
    <h:inputHidden id="setName" value="#{wage_ConstBB.setName}"/>
    
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{wage_ConstBB.wcbo.constName}" alt="名称|0" size="40" maxlength="40"/>

            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="#{wage_ConstBB.wcbo.desc}" cols="40" rows="5"/>

            <h:outputText value="关联帐套" />
            <h:selectOneMenu id="setCess" value="#{wage_ConstBB.wcbo.setid}" >
               <c:selectItems value="#{wage_ConstBB.setList}"/>            
            </h:selectOneMenu>

            <h:outputText value="当前值" />
            <h:inputText id="curname" value="#{wage_ConstBB.wcbo.constValue}" alt="名称|0" size="40" maxlength="40"/>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_ConstBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>