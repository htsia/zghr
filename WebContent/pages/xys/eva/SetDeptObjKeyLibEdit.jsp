<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" src="../../js/xys_funs.js"></script>
<x:saveState value="#{xys_KpiDeptSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{xys_KpiDeptSetBB.initLibEdit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">

            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{xys_KpiDeptSetBB.libB0.objLibName}"/>
            <h:outputText value="显示顺序"/>
            <h:inputText id="orderby" value="#{xys_KpiDeptSetBB.libB0.orderby}"/>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{xys_KpiDeptSetBB.saveLib}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
