<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
        return null;
    }
</script>


<x:saveState value="#{sys_surveyQueryBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_surveyQueryBB.resultInit}"/>
    <c:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
    </c:verbatim>
    <h:commandButton styleClass="button01" value="µ¼³öµ½Excel" type="button" onclick="return forExport();"/>
	<c:verbatim>
    </td></tr>

    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="keyName" value="title"/>
        </jsp:include>
    </td></tr>
    </table>
</c:verbatim>           
</h:form>
