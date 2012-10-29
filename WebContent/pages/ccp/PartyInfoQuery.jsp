<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page import="java.util.List"%>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String superId = request.getParameter("superId");

    int orgr = 1;
    int conr = 1;
    User user = (User)session.getAttribute(Constants.USER_INFO);
    List list = user.getPmsOperateList();
    if (list != null && list.size() > 0){
        for (int i=0;i<list.size();i++){
            OperateBO o = (OperateBO)list.get(i);
            if (o.getOperateId().equals("0134")){
                orgr = 0;
            }
            if (o.getOperateId().equals("0135")){
                conr = 0;
            }
        }
    }
%>
    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/ccp/PartyEditIndex.jsf?pk=" + id + "&type=" + type, "aa", "status=no,toolbar=no,menubar=no,location=no", "1100", "600", "no");
        }
        function forPartyFee(form, id, type) {
            var chkflag = <%=orgr%>;
             if (chkflag == "0"){
                var flag = form.flag.value;
                windowOpen("/ccp/PartyFeeDetailList.jsf?setId=D015&flag=" + flag + "&fk=" + id + "&type=" + type, "aa", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
             }else{
                alert("对不起，您没有权限");
            }
        }
        function forPartyConfirm(form, id, type) {
            var chkflag = <%=conr%>;
            if (chkflag == "0"){
                var flag = form.flag.value;
                windowOpen("/ccp/PartyConfirmDetailList.jsf?setId=D015&flag=" + flag + "&fk=" + id + "&type=" + type, "aa", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
            }else{
                alert("对不起，您没有权限");
            }
        }
        function forAdQry() {
            doAdvanceQuery("D", "PARTY", "110", "Y", "", "D001.D001015%20is%20null%20or%20D001.D001015=''", "Y", "<%=Constants.DEFAULT_QUERY_PARTY%>", "Y","1");
        }
        function forExport() {
            windowOpen("/pages/common/ExportToExcel.jsf", "", "status=yes,toolbar=no,menubar=no,location=no", "700", "600");
        }
    </script>

<h:form id="form1">
    <h:inputHidden id="partyList" value="#{ccp_PartyQueryBB.partyList}"/>
    <c:verbatim>
        <input type="hidden" name="superId" value="<%=CommonFuns.filterNull(superId)%>">
        <input type="hidden" name="flag" value="2">
        <input type="hidden" name="sessionFlag" value="2">
    </c:verbatim>
    <h:panelGrid width="100%" align="center" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="党组织名称："/>
            <h:inputText id="partyName" value="#{ccp_PartyQueryBB.partyName}" size="10"/>
            <h:outputText value=" "/>
            <h:commandButton value=" 查询 " id="queryParty" styleClass="button01" action="#{ccp_PartyQueryBB.queryPartyInfo}"/>
            <h:outputText value=" "/>
            <h:commandButton value="高级查询" styleClass="button01" onclick="return forAdQry()"/>
        </h:panelGroup>
        <h:panelGrid columns="1" align="right">
            <h:commandButton value="导出到Excel" type="button" onclick="return forExport()" styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="false"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="false"/>
        <jsp:param name="editName" value="维护党费信息"/>
        <jsp:param name="editFuncName" value="forPartyFee"/>
        <jsp:param name="editFuncName" value="forPartyConfirm"/>
        <jsp:param name="isRow" value="true"/>
        <jsp:param name="rowFuncName" value="forView"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
    </c:verbatim>
</h:form>