<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
  <head>
  <title></title>
      <script type="text/javascript">
     </script>
  </head>

  <body>
  <x:saveState value="#{ins_busiqueryBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{ins_busiqueryBB.initDetail}"></h:inputHidden>
      <table  border="0"  height=98% width=98% align="center" cellSpacing=0 id=main>
          <tr >
             <td class="td_title" height=2>
                 <h:graphicImage value="/images/tips.gif" />
                 <h:outputText value="显示明细"/>
             </td>
              <td align="right" class="td_title" height=2>
                  <h:commandButton value="导出excel" type="button" styleClass="button01" onclick="doExport2();" />
              </td>
         </tr>
          <tr><td colspan=2 height=5></td></tr>
          <tr><td colspan=2 valign="top">
              <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
                  <jsp:param name="hasOperSign" value="true"/>
                  <jsp:param name="operSignType" value="checkbox"/>
                  <jsp:param name="hasEdit" value="false"/>
                  <jsp:param name="isEditList" value="false"/>
                  <jsp:param name="isCheckRight" value="false"/>
              </jsp:include></td>
          </tr>
      </table>
      
  </h:form>
  </body>
</html>