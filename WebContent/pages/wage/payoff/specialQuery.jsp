<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <x:saveState value="#{wage_speicalQueryBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_speicalQueryBB.pageInit}"/>
      <h:inputHidden value="#{wage_speicalQueryBB.setId}"/>
<c:verbatim>
      <table  width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
             <td align="right" class="td_title">
</c:verbatim>
                 <h:commandButton value="µ¼³ö" type="button" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
                 <h:commandButton value="¹Ø±Õ" type="button" styleClass="button01" onclick="window.close()"></h:commandButton>
<c:verbatim>
             </td>
          </tr>
          <tr>
              <td >
                  <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                      <jsp:param name="para" value="true"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
</c:verbatim>
  </h:form>
