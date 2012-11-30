<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 50;
            $("iframe[name=main]").height(mainHeight);
       }
    </script>

  <x:saveState value="#{emp_surveyBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_surveyBB.pageInit}"/>
  <f:verbatim>
      <table width="98%" cellspacing="0">
      <tr >
          <td class="td_title"  height=2>
  </f:verbatim>
              <h:graphicImage value="/images/common/handtip.gif" />
              <h:outputText value=" #{emp_surveyBB.survey.itemName}"/>
  <f:verbatim>
          </td>
          <td class="td_title" align="right" height=2>
  </f:verbatim>
              <h:commandButton type="button" styleClass="button01" value="导出" onclick="ExportShowTable()"></h:commandButton>
  <f:verbatim>
          </td>
      <tr>
      </table>
      <br>
      <table   width="98%" border="0" align="center" cellpadding="0" cellspacing="0"  id=main>
          <tr><td align="left" height=8>
  </f:verbatim>
              <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2391"," 统计时间") %> :
              </f:verbatim>
             <h:outputText value="#{emp_surveyBB.staticDate}"></h:outputText>
  <f:verbatim>
          </td></tr>

          <tr>
          <td valign="top">
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
          </td>
          </tr>
      </table>
  </f:verbatim>
  </h:form>
