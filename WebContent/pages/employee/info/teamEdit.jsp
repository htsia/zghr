<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{teamMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{teamMgrBB.initset}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                 <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2397","项目团队名称") %>  
                 </f:verbatim>
            <h:inputText id="name" value="#{teamMgrBB.teaminfo.teamName}" />

              <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2398","应用范围") %>  
                 </f:verbatim>
            <h:selectOneMenu value="#{teamMgrBB.teaminfo.teamType}">
                  <c:selectItems value="#{teamMgrBB.orgList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="项目额"></h:outputText>
            <h:inputText id="teamBudget" value="#{teamMgrBB.teaminfo.teamBudget}" />
            
             <h:outputText value="项目级别"></h:outputText>
            <h:inputText id="teamLevel" value="#{teamMgrBB.teaminfo.teamLevel}" />

            <h:outputText value="项目档次"></h:outputText>
            <h:inputText id="teamStep" value="#{teamMgrBB.teaminfo.teamStep}" />
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{teamMgrBB.SaveTeam}" />
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
