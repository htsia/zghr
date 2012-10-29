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
 
<h:form id="form1">
    <br><br>
    <table width="95%" border="1" cellpadding="0" cellspacing="0" class="table03" align="center">
        <%
            if (list == null || list.size() == 0) {
            } else {
                for (int i = 0; i < list.size(); i++) {
                    String[] val = ((String) list.get(i)).split("\\|");
        %>
        <tr>
            <td class=td_middle align="center" onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this) onclick="parent.forPersonList(parent.form1.setid.value,parent.form1.stype.value,'<%=val[0]%>','<%=val[1]%>')">
                <%=val[1]%>
            </td>
        </tr>
        <%
                }
            }
        %>
        <tr></tr>
    </table>
</h:form>
 