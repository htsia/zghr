<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doCheck(){
        if (document.all("form1:itemID").value=="" || document.all("form1:itemID").value=="-1"){
            alert("请选择项目!");
            return false;
        }
        return true;
    }
</script>
 
<x:saveState value="#{wage_inputPowerBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_inputPowerBB.pageInit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套"/>
            <h:outputText value="#{wage_inputPowerBB.setName}"></h:outputText>

            <h:outputText value="姓名" />
            <h:outputText id="name" value="#{wage_inputPowerBB.personName}"/>

            <h:outputText value="有权限项目" />
            <h:selectOneMenu value="#{wage_inputPowerBB.wbo.itemID}" id="itemID">
                <c:selectItems value="#{wage_inputPowerBB.itemList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_inputPowerBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
