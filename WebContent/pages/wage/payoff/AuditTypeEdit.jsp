<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:name").value==""){
                alert("请录入名称!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{wage_aduitItemBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_aduitItemBB.editType}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">

            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{wage_aduitItemBB.typeBO.itemName}" />

            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="#{wage_aduitItemBB.typeBO.itemDes}" cols="40" rows="5"/>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_aduitItemBB.saveType}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
