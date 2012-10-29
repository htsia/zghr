<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
   <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>


<x:saveState value="#{wage_setInitBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_setInitBB.pageInit}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套" />
            <h:outputText  value="#{wage_setInitBB.setName}" />

            <h:outputText value="选择公式"/>
            <h:selectOneMenu value="#{wage_setInitBB.wageinit.formularId}">
                <c:selectItems value="#{wage_setInitBB.formulaList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="顺序" />
            <h:inputText id="rank" value="#{wage_setInitBB.wageinit.seq}" alt="顺序|0" size="20" maxlength="20"/>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_setInitBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
