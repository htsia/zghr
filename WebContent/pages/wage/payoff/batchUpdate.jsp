<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_batchUpdateBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_batchUpdateBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{wage_batchUpdateBB.setId}"/>
    <h:inputHidden id="unitName" value="#{wage_batchUpdateBB.unitName}"/>
    <h:inputHidden id="unitId" value="#{wage_batchUpdateBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_batchUpdateBB.setName}"/>
    <c:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;</c:verbatim>
    <h:outputText value="帐套:#{wage_batchUpdateBB.setName}"></h:outputText>
    <c:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;</c:verbatim>
    <h:outputText value="单位:#{wage_batchUpdateBB.unitName}"></h:outputText>

    <h:panelGrid columns="2" width="98%" columnClasses="td_form01,td_form02" align="center">
        <h:outputText value="结果设置"></h:outputText>
        <h:panelGroup>
             <h:selectOneMenu id="resultField" value="#{wage_batchUpdateBB.resultField}">
                 <c:selectItems value="#{wage_batchUpdateBB.inputList}"></c:selectItems>
             </h:selectOneMenu>

            <h:selectOneMenu id="oper" value="#{wage_batchUpdateBB.oper}">
                <c:selectItem itemValue="=" itemLabel="等于"></c:selectItem>
                <c:selectItem itemValue="+" itemLabel="增加"></c:selectItem>
                <c:selectItem itemValue="*" itemLabel="倍数"></c:selectItem>
            </h:selectOneMenu>

             <h:inputText id="resultValue" value="#{wage_batchUpdateBB.resultValue}" ></h:inputText>
        </h:panelGroup>

        <h:outputText value="条件设置"></h:outputText>
        <h:panelGroup>
            <h:selectOneMenu id="condField" value="#{wage_batchUpdateBB.condField}">
                <c:selectItems value="#{wage_batchUpdateBB.allList}"></c:selectItems>
            </h:selectOneMenu>
            <h:selectOneMenu value="#{wage_batchUpdateBB.cond}">
                <c:selectItem itemValue="=" itemLabel="等于"></c:selectItem>
                <c:selectItem itemValue="<>" itemLabel="不等于"></c:selectItem>
                <c:selectItem itemValue=">" itemLabel="大于"></c:selectItem>
                <c:selectItem itemValue=">=" itemLabel="大于等于"></c:selectItem>
                <c:selectItem itemValue="<" itemLabel="小于"></c:selectItem>
                <c:selectItem itemValue="<=" itemLabel="小于等于"></c:selectItem>
            </h:selectOneMenu>
            <h:inputText id="condValue" value="#{wage_batchUpdateBB.condValue}" ></h:inputText>
        </h:panelGroup>

         <h:outputText value="操作"></h:outputText>
         <h:panelGrid columns="2" align="right">
             <h:commandButton value="操作" styleClass="button01" onclick="return confirm('确定要修改数据吗？')" action="#{wage_batchUpdateBB.update}"></h:commandButton>
             <h:commandButton value="返回" styleClass="button01" onclick="window.close()"></h:commandButton>
         </h:panelGrid>
    </h:panelGrid>
</h:form>