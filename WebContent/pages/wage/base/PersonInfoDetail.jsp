<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
        function forsave(form) {
            if (forsubmit(form)) {
                document.all("form1:save").click();
            }
        }
        function forBack() {
            document.all("form1:back").click();
        }
    </script>

<x:saveState value="#{wage_persMgrBB}"/>
<h:inputHidden value="#{wage_persMgrBB.pageInit}"/>
<h:form id="form1">
    <h:commandButton action="#{wage_persMgrBB.savePersSetInfo}" style="display:none" id="save"/>
    <h:commandButton action="#{wage_persMgrBB.listPersSetInfo}" style="display:none" id="back"/>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
        <jsp:param name="isEdit" value="true"/>
        <jsp:param name="tableId" value="DetailInfo"/>
    </jsp:include>
    </c:verbatim>
</h:form>
