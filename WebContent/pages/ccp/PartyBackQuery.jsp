<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    String superId = request.getParameter("superId");
    String setId = "D001";
    String loadflag =CommonFuns.filterNull((String)request.getAttribute("loadflag"));
%>

    <script type="text/javascript">
        function forCancel() {
            if (!checkMutilSelect(document.forms(0).chk)) {
                alert("请选择党组织");
                return false;
            } else {
            	parent.tree.location.reload();
                return true;
            }
        }
        function forAdQry(){
            doAdvanceQuery("D", "PARTY", "110", "Y", "", "D001.D001015%20is%20not%20null%20or%20D001.D001015<>''", "Y", "<%=Constants.DEFAULT_QUERY_DISSPARTY%>", "Y","1");
        }

    </script>

<h:form id="form1">
    <h:inputHidden id="partyList" value="#{ccp_PartyQueryBB.backPartyList}"/>
    <c:verbatim>
    <input type="hidden" name="superId" value="<%=CommonFuns.filterNull(superId)%>">
    <input type="hidden" name="sessionFlag" value="2">
    <input type="hidden" name="setId" value="<%=CommonFuns.filterNull(setId)%>"/>
    <input type="hidden" name="loadflag" value=<%=loadflag%>>
    </c:verbatim>
    <h:panelGrid width="100%" align="center" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="党组织名称："/>
            <h:inputText id="partyName" value="#{ccp_PartyQueryBB.partyName}" size="10"/>
            <h:outputText value=" "/>
            <h:commandButton value="查询" styleClass="button01" action="#{ccp_PartyQueryBB.queryBackPartyInfo}"/>
            <h:outputText value=" "/>
            <h:commandButton value="高级查询" onclick="return forAdQry()" styleClass="button01"/>
        </h:panelGroup>
        <h:panelGrid columns="1" align="right">
            <h:panelGroup>
                <h:commandButton value="撤销恢复" styleClass="button01" onclick="return forCancel()"
                                 action="#{ccp_PartyQueryBB.savePartyBackInfo}"/>
                <h:outputText value=" "/>
                <h:commandButton value="删除" onclick="return forCancel()" styleClass="button01"
                                 action="#{ccp_PartyQueryBB.deleteParty}"/>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="false"/>
        <jsp:param name="isRow" value="true"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
    </c:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
