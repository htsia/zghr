<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
</script>

<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_dateBB.initRptSet}"></h:inputHidden>
    <h:inputHidden value="#{wage_dateBB.contentID}"></h:inputHidden>
    <c:verbatim>
        <table>
        <tr><td>
    </c:verbatim>
        <h:outputText escape="false" value="<strong>请选择适用帐套:</strong>"></h:outputText>
    <c:verbatim>
        </td></tr>

        <tr><td>
    </c:verbatim>
    <h:selectManyCheckbox value="#{wage_dateBB.selectWageSetList}" layout="pageDirection">
         <c:selectItems value="#{wage_dateBB.wageSetList}"></c:selectItems>
     </h:selectManyCheckbox>
    <c:verbatim>
        </td></tr>

        <tr><td align="right">
    </c:verbatim>
             <h:commandButton value="保存" styleClass="button01" action="#{wage_dateBB.saveRptSet}"></h:commandButton>
             <h:commandButton value="关闭" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
    <c:verbatim>
        </td></tr>
        <table>
    </c:verbatim>
    
</h:form>
