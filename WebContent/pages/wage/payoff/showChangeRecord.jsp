<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setID=request.getParameter("SetID");
    String PayoffMonth=request.getParameter("PayoffMonth");
%>
  <x:saveState value="#{wage_showChangeBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_showChangeBB.pageInit}"/>
      <f:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr>
              <td align="center" width="16%" class=tab>&nbsp;<a href="/wage/payoff/showPersonChangeByMonth.jsf?Mode=1&SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">增加情况</a></td>
              <td align="center" width="16%" class=tab>&nbsp;<a href="/wage/payoff/showPersonChangeByMonth2.jsf?Mode=0&SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">减少情况</a></td>
              <td align="center" width="16%" class=activeTab>&nbsp;<a href="showChangeRecord.jsf?SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">变动情况</a></td>
          </tr>

          <tr><td colspan="3">
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
     </f:verbatim>
  </h:form>
