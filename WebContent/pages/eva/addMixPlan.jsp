<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>

</c:verbatim>
<script type="text/javascript">
</script>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{eva_planExecuteBB.initEdit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 虚拟计划"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="计划"/>
            <h:selectOneMenu value="#{eva_planExecuteBB.mixBo.mixPlan}">
            	<c:selectItems value="#{eva_planExecuteBB.exePlanList}"/>
            </h:selectOneMenu>
            <h:outputText value="权重(%)"/>
           	<h:inputText id="purview"  value="#{eva_planExecuteBB.mixBo.purview}" />
        </h:panelGrid>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eva_planExecuteBB.saveMixBo}"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>