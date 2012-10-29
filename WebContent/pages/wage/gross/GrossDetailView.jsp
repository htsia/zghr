<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<html>
<script type="text/javascript">
    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp');
    }
</script>
<title>查看发放明细</title>
<f:view>
<h:form id="form1">
<f:verbatim><br></f:verbatim>
    <h:inputHidden value="#{wage_grossBB.pageInit}"/>
<h:panelGrid columns="2" align="center" width="96%" border="0">
    <h:outputText value="#{wage_grossBB.deptName}"/>
    <h:commandButton value="导出到Excel" onclick="forExport();" styleClass="button01"/>
</h:panelGrid>
    <f:verbatim>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="false"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isForward" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="isPage" value="false"/>
            <jsp:param name="target" value="<%=Constants.OBJECT%>"/>
        </jsp:include>
    </f:verbatim>
</h:form>
</f:view>
</html>