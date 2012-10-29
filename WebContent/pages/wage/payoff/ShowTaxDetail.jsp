<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   <c:verbatim><base target="_self"></c:verbatim>
    <script type="text/javascript">
    </script>

  <x:saveState value="#{self_querypaybb}"/>
  <h:form id="form1">
      <h:inputHidden value="#{self_querypaybb.showDetail}"/>
      <c:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" height=5>
       </c:verbatim>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value="纳税申报明细"/>
      <c:verbatim>
              </td>
              <td class="td_title" align="right" height=5>
       </c:verbatim>
                  <h:commandButton type="button" value="导出" onclick="return ExportShowTable();" styleClass="button01"></h:commandButton>
<c:verbatim>
              </td>
          </tr>
          <tr><td colspan=2 height=5></td></tr>
          <tr>
              <td colspan=2>
                  <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                      <jsp:param name="para" value="true"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
  </c:verbatim>
  </h:form>
