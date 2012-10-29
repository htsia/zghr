<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<script type="text/javascript">
    function doSetCode(){
        if (document.all("form1:code").value!="")      document.contentFrame.location.href=document.all("form1:code").value;
    }
</script>
<x:saveState value="#{lead_surveyAnaBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{lead_surveyAnaBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    <table width="100%" height="98%">
        <tr><td height=8 align="left">
    </c:verbatim>
    <h:outputText value="请选择分析模型："></h:outputText>
    <h:selectOneMenu id="code">
        <c:selectItems value="#{lead_surveyAnaBB.codeList}"></c:selectItems>
    </h:selectOneMenu>
    <h:commandButton value="刷新" styleClass="button01" onclick="doSetCode();" type="button"></h:commandButton>
    <c:verbatim>
        </td></tr>
        <tr><td>
            <iframe id="contentFrame" name="contentFrame" frameborder="0" height="100%" width="100%"></iframe>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
     doSetCode();
</script>
