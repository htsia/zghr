<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
   
    <title></title>
</head>

<body>
<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossBB.beginMonthInput}"></h:inputHidden>
    <h:inputHidden id="curYearMonth" value="#{wage_grossBB.curYearMonth}"></h:inputHidden>
    <%
        String[]  field=(String[])session.getAttribute("GrossField");
        String[]  orgId=(String[])session.getAttribute("OrgIDs");
        HashMap rs=(HashMap)session.getAttribute("GrossTable");
    %>

    <table width="98%">
        <tr><td align="right">
            <h:commandButton styleClass="button01" value="ȷ��" action="#{wage_grossBB.saveMonthInput}"   />
            <h:commandButton styleClass="button01" type="button" value="ȡ��" onclick="window.close()"/>
        </td></tr>
    </table>

    <c:verbatim escape="false">
     <br>
     <br>
        <%
            if (orgId != null && field != null) {
                int col = field.length;
                int row = orgId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td colspan="<%=col+3%>" nowrap class="td_top">��ѡ������б�&nbsp&nbsp<%out.print("����"+row+"��");%></td>
            </tr>

            <tr>
                <td nowrap class="td_top">�������</td>
                <td nowrap class="td_top">��������</td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, field[j]) + "</td>");
                    }
                %>
            </tr>
            <%
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    OrgBO pb = SysCacheTool.findOrgById(orgId[i]);
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top>" + pb.getOrgCode() + "</td>");
                            out.println("<td class=td_top>" + pb.getName() + "</td>");
                        } else {
                            String fldname = orgId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("", field[j]);
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                String value = rs.get(fldname)==null?"":CommonFuns.filterNullToZero((String) (rs.get(fldname)));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'></td>");
                            } else {
                                String value = rs.get(fldname)==null?"":CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|f'></td>");
                            }
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
</body>
</html>