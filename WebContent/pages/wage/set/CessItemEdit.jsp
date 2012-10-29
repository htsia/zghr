<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageCessItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>

<x:saveState value="#{wage_cessitemBB}"/>
<h:inputHidden value="#{wage_cessitemBB.pageInit}"></h:inputHidden>
<h:inputHidden value="#{wage_cessitemBB.cessID}"></h:inputHidden>
<h:form id="form1">
    <h:panelGrid align="right" columns="1" width="95%" >
        <h:panelGroup>
          <h:commandButton styleClass="button01" value="保存" action="#{wage_cessitemBB.save}"   />
          <h:commandButton styleClass="button01" type="button" value="取消并返回" onclick="window.close()"/>
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim escape="false">
     <br>
     <br>
        <%
            String[] field = (String[]) session.getAttribute("field");
            List rs = (List) session.getAttribute("data");
            if (rs != null && field != null) {
                int col = field.length;
                int row = rs.size();
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" +  field[j] + "</td>");
                    }
                %>
            </tr>
            <%
                for (int i = 0; i < row; i++) {
                    WageCessItemBO wi = (WageCessItemBO) rs.get(i);
                    out.println("<tr>");

                    out.println("<td class=td_middle>" + wi.getShowseq() + "</td>");
                    String fldname = wi.getItemID()+field[1] ;
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + CommonFuns.filterNull(wi.getLow()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID()+field[2];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + CommonFuns.filterNull(wi.getHigh()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID()+field[3];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + CommonFuns.filterNull(wi.getRate()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID()+field[4];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + CommonFuns.filterNull(wi.getDeduction()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
