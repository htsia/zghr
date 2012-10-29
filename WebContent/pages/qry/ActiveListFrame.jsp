<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    String desktop="";
    if ("true".equals(request.getParameter("DeskTop"))){
        desktop="true";
%>
        <link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
<%}else{%>
        <link href="/css/style.css" rel="stylesheet" type="text/css"/>
<%}%>
<script type="text/javascript">
    function forView(form, id, type) {
        windowOpen("<%=Constants.LEAD_SHOW_PERSONURL%>?DeskTop=<%=desktop%>&fk="+id, "aa", "", "1000", "600", "auto","10","1","yes");
    }
</script>

<h:form>
     <h:inputHidden value="#{qry_querySettingBB.initShowResult}"/>
<c:verbatim>
    <jsp:include page="../common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="true"/>
        <jsp:param name="isRow" value="true"/>
        <jsp:param name="rowFuncName" value="forView"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
</c:verbatim>
</h:form>