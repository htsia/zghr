<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_grossauditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossauditBB.initShowDetail}"></h:inputHidden>
<c:verbatim>
    <br>
    <table width=95%>
        <tr><td align="right">
            <input type="button" value="关闭" class="button01" onclick="window.close();">
        </td></tr>
    </table>
    <br>

    <table  width=95% class="appForm" align="center">
      <tr>
      <td><strong>申请日期</strong></td>
      <td height=8>
</c:verbatim>
         <h:outputText value="#{wage_grossauditBB.wb.applyDate}"></h:outputText>
<c:verbatim>
      </td>
    <td><strong>申请单位</strong></td>
    <td height=8 >
  </c:verbatim>
       <h:outputText value="#{wage_grossauditBB.wb.orgName}"></h:outputText>
  <c:verbatim>
    </td>
    </tr>

    <tr>
      <td><strong>申请项目</strong></td>
      <td height=8 >
    </c:verbatim>
         <h:outputText value="#{wage_grossauditBB.wb.fieldName}"></h:outputText>
    <c:verbatim>
      </td>

    <td><strong>申请额度</strong></td>
    <td height=8 align="right">
  </c:verbatim>
       <h:outputText value="#{wage_grossauditBB.wb.applySum}"></h:outputText>
  <c:verbatim>
    </td>
      </tr>

      <tr>
      <td height=80 ><strong>申请原因</strong></td>
      <td height=80 colspan=3>
</c:verbatim>
         <h:outputText value="#{wage_grossauditBB.wb.applyReason}"></h:outputText>
<c:verbatim>
      </td>
      </tr>

    <tr>
      <td><strong>审批人</strong></td>
      <td height=8 >
    </c:verbatim>
         <h:outputText value="#{wage_grossauditBB.wb.auditorName}"></h:outputText>
    <c:verbatim>
      </td>

    <td><strong>审批时间</strong></td>
    <td height=8 align="right">
  </c:verbatim>
       <h:outputText value="#{wage_grossauditBB.wb.auditDate}"></h:outputText>
  <c:verbatim>
    </td>
      </tr>

      <tr>
      <td><strong>申请结果</strong></td>
      <td height=8 colspan=3>
</c:verbatim>
       <h:outputText value="#{wage_grossauditBB.wb.auditResultDes}"></h:outputText>
<c:verbatim>
      </td>
      </tr>

    <tr>
    <td height=80 ><strong>说明</strong></td>
    <td height=80 colspan=3>
  </c:verbatim>
    <h:outputText value="#{wage_grossauditBB.wb.auditResult}"></h:outputText>
  <c:verbatim>
    </td>
    </tr>

     </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

