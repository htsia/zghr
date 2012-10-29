<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    ArrayList list = (ArrayList) session.getAttribute("perlist");
    session.removeAttribute("perlist");
%>


<body>
<h:form id="form1">
    <br>
    <br>
    <table align="center" class="table03" width="100%">
        <%
            if (list == null || list.size() == 0) {
            } else {
                for (int i = 0; i < list.size(); i++) {
                    String[] val = ((String) list.get(i)).split("\\|");
        %>
        <tr>
            <td class="td_top" width="80%">
                <input type=hidden name="perid" value="<%=val[0]%>">
                <a onMouseOver=linkOver(this) onMouseOut=linkOut(this)   style="cursor:hand" onclick="parent.forPersonList(parent.form1.setid.value,parent.form1.stype.value,'<%=val[0]%>','<%=val[1]%>')"><%=val[1]%></a>
            </td>
        </tr>
        <%
                }
            }
        %>
        <tr></tr>
    </table>
</h:form>
