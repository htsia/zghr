<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_computeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden  value="#{wage_computeBB.initMaskQuestion}"/>
    <c:verbatim>
    <table width=98% align="center">
        <tr><td align="right">
    </c:verbatim>
            <h:commandButton  styleClass="button01" value="保存" action="#{wage_computeBB.doMaskQuestion}"/>
            <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
<c:verbatim>
        </td></tr>
        <tr>
            <td>
</c:verbatim>
                <h:outputText value="人员:#{wage_computeBB.manyPersonName}"></h:outputText>
<c:verbatim>
            </td>
        </tr>
        <tr>
            <td>
                <strong>存在问题：</strong><br>
</c:verbatim>
                <h:inputTextarea rows="20" cols="60" value="#{wage_computeBB.question}"></h:inputTextarea>
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>    
</h:form>
