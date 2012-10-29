<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
  <head>
  <title>
  </title>
  </head>
  <script type="text/javascript">
      function forExport() {
        window.open('/pages/common/ExportToExcel2.jsp');
      }
  </script>   
  <body>
  <x:saveState value="#{wage_PieceSumItemShowBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_PieceSumItemShowBB.pageInit}"/>
   
  <table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title">
          <h:outputText value="发薪单位：#{wage_PieceSumItemShowBB.unitName}"/>
        </td>
        <td align="right" class="td_title">
            <h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01"/>
            &nbsp;&nbsp;
            <h:outputText value="部门过滤" />
            <h:selectOneMenu onchange="submit()" value="#{wage_PieceSumItemShowBB.dept}" valueChangeListener="#{wage_PieceSumItemShowBB.changeDept}">
               <c:selectItems value="#{wage_PieceSumItemShowBB.deptList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="返回" onclick="window.close()"></h:commandButton>
        </td>
    </tr>
  </table>
  <br>
      <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
          <jsp:param name="hasOperSign" value="true"/>
          <jsp:param name="operSignType" value="checkbox"/>
          <jsp:param name="hasEdit" value="false"/>
          <jsp:param name="isEditList" value="false"/>
          <jsp:param name="isCheckRight" value="false"/>
      </jsp:include>
</h:form>
</body>
</html>