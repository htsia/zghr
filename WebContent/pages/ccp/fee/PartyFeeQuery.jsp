<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    String superId = CommonFuns.filterNull(request.getParameter("superId"));
    String setId = "D015";
%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript">
        function forAdQry(){
            doAdvanceQuery("D", "PARTY", "110", "Y", "","", "Y", "<%=Constants.DEFAULT_QUERY_PARTYFEE%>", "Y","1");
        }
        function forExport() {
            windowOpen("/pages/common/ExportToExcel.jsf", "", "status=yes,toolbar=no,menubar=yes,location=no", "700", "600");
        }
    </script>
<h:form id="form1">
    <h:inputHidden id="feeList" value="#{ccp_PartyFeeListBB.feeList}"/>
    <f:verbatim>
    <input type="hidden" name="superId" value="<%=superId%>">
    <input type="hidden" name="sessionFlag" value="2">
    <input type="hidden" name="setId" value="<%=setId%>">
    </f:verbatim>
    <h:panelGrid width="100%" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="业务时间："/>
            <h:inputText id="leaveSDate" value="#{ccp_PartyFeeListBB.leaveSDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveSDate');return false;"/>
            <h:outputText value=" "/>
            <h:outputText value="至"/>
            <h:outputText value=" "/>
            <h:inputText id="leaveEDate" value="#{ccp_PartyFeeListBB.leaveEDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveEDate');return false;"/>
            <h:outputText value=" "/>
            <h:commandButton value=" 查询 " styleClass="button01" action="#{ccp_PartyFeeListBB.queryAllPartyFee}"/>
            <h:outputText value=" "/>
            <h:commandButton value="高级查询" onclick="return forAdQry()" styleClass="button01"/>
        </h:panelGroup>
        <h:panelGrid columns="1" align="right">
            <h:commandButton value="导出到Excel" type="button" onclick="return forExport()" styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
    <f:verbatim><br>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="false"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="isForward" value="false"/>
        <jsp:param name="isRow" value="false"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
    </f:verbatim>
</h:form>
