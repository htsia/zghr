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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
  </head>

  <body>
  <x:saveState value="#{wage_PieceOrgSumItemShowBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_PieceOrgSumItemShowBB.pageInit}"/>
   
  <table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title">
          <h:outputText value="发薪单位：#{wage_PieceOrgSumItemShowBB.unitName}"/>
        </td>
        <td align="right" class="td_title">
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