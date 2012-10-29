<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" src="../../js/xys_funs.js"></script>
<script type="text/javascript">
    function checkForm() {
        if (!checkValidate(document.all('form1:weight'), '总分', 'f', '', 0)) {
            return false;
        } else if (!checkValidate(document.all('form1:hiValue'), '打分高限', 'f', '', 0)) {
            return false;
        }else if(!checkValidate(document.all('form1:lowValue'), '打分低限', 'f', '', 0)){
             return false;
        } else {
            return true;
        }

    }
</script>
<x:saveState value="#{xys_360TempBB}"/>
<h:form id="form1">
    <h:inputHidden id="initEdit" value="#{xys_360TempBB.initItem}"></h:inputHidden>
    <h:inputHidden id="setType" value="#{xys_360TempBB.setType}"></h:inputHidden>
    <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif"/>
            <h:outputText value=" 绩效管理 ->360模版设置"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="1" width="98%" align="left">
        <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="选择指标"></h:outputText>
            <h:panelGroup>
                <h:inputText id="itemName" readonly="true" value="#{xys_360TempBB.itemBO.itemName}"/>
                <h:inputHidden id="keyId" value="#{xys_360TempBB.itemBO.keyId}"/>
                <h:commandButton type="button" styleClass="button_select"
                   onclick="Sel360Key(document.all('form1:keyId'),document.all('form1:itemName'),document.all('form1:setType'))"/>
            </h:panelGroup>
            <h:outputText value="权重（%）"></h:outputText>
            <h:inputText id="weight" value="#{xys_360TempBB.itemBO.weight}"></h:inputText>
            <h:outputText value="打分高限"></h:outputText>
            <h:inputText id="hiValue" value="#{xys_360TempBB.itemBO.hiValue}"></h:inputText>
            <h:outputText value="打分低限"></h:outputText>
            <h:inputText id="lowValue" value="#{xys_360TempBB.itemBO.lowValue}"></h:inputText>
            <h:outputText value="打分说明" rendered="#{xys_360TempBB.editType=='update'}"></h:outputText>
            <h:inputTextarea value="#{xys_360TempBB.itemBO.itemDesc}" rows="8" cols="80" rendered="#{xys_360TempBB.editType=='update'}"></h:inputTextarea>
        </h:panelGrid>

        <h:panelGrid align="right">
            <h:commandButton value="保存" styleClass="button01" action="#{xys_360TempBB.saveItem}"
                             onclick="return checkForm();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>