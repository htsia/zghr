<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>
<x:saveState value="#{eva_selectioncaclBB}"/>
<h:form id="form1">
    <h:inputHidden id="initEdit" value="#{eva_selectioncaclBB.initEdit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 投票计算设置"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name"  value="#{eva_selectioncaclBB.setbo.setName}" />
            <h:outputText value="选择统计项"/>
            <h:selectManyCheckbox value="#{eva_selectioncaclBB.gradeItems}">
				<c:selectItems value="#{eva_selectioncaclBB.gradeItemList}"/>            
            </h:selectManyCheckbox>
        </h:panelGrid>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eva_selectioncaclBB.saveSet}"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>