<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">

</script>
<x:saveState value="#{self_PersonKpiSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="initEdit" value="#{self_PersonKpiSetBB.initAudit}"></h:inputHidden>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            <tr>
                <td class="td_title" height="10px"><img src="/images/tips.gif">
                    ��Ч���� ->����KPI����
                </td>
            </tr>
        </table>
        <table height=90% width=100% align="center">
        <tr>
        <td height=8 align="right">
    </c:verbatim>
    <h:commandButton styleClass="button01" value="ͨ��" action="#{self_PersonKpiSetBB.auditPass}"/>
    <h:outputText value="  "></h:outputText>
    <h:commandButton styleClass="button01" value="�˻�" action="#{self_PersonKpiSetBB.auditOut}"/>
    <c:verbatim>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </td>
        </tr>
        <tr>
            <td>
                <%
                    String objId = (String) session.getAttribute("objId");
                %>
                <iframe id="two" width="100%" height="500" frameBorder=0 scrolling=yes
                        src="/pages/xys/eva/PreviewDeptKpi.jsp?objId=<%=objId%>"></iframe>
            </td>
        </tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>