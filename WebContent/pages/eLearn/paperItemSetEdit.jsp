<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{eLearn_paperLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_paperLibBB.inititemset}"/>
    <h:panelGrid align="center" width="90%" columns="1">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="˳��"/>
            <h:inputText id="showSeq" value="#{eLearn_paperLibBB.itemsetbo.showSeq}" />

            <h:outputText value="����"/>
            <h:inputText id="name" value="#{eLearn_paperLibBB.itemsetbo.setName}" />

            <h:outputText value="����"/>
            <h:selectOneMenu value="#{eLearn_paperLibBB.itemsetbo.setType}">
                <c:selectItem itemValue="-1" itemLabel="--ѡ������--"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="��ѡ"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="��ѡ"></c:selectItem>
                <c:selectItem itemValue="3" itemLabel="�ʴ�"></c:selectItem>
                <c:selectItem itemValue="5" itemLabel="�ж�"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="�ܷ�"/>
            <h:inputText id="totalscore" value="#{eLearn_paperLibBB.itemsetbo.totalscore}" />

            <h:outputText value="��Ŀ����"/>
            <h:inputText id="questioncount" value="#{eLearn_paperLibBB.itemsetbo.questioncount}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{eLearn_paperLibBB.SaveItemSet}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

