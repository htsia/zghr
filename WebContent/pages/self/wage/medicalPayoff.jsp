<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
  <head>
  <title></title>
   <base target="_self">
    <script type="text/javascript">

    </script>
  </head>

  <body>
  <x:saveState value="#{self_medicalPayoffBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{self_medicalPayoffBB.pageInit}"></h:inputHidden>
      <table  width="98%" height=98% border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
          <tr >
              <td class="td_title"  height=8>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" ����ҽ�Ƹ����ʻ���ѯ"/>
              </td>
              <td class="td_title">
                   <h:commandButton id="export" value="����" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
              </td>
          </tr>

          <tr>
              <td height=8 colspan=2>
                   <h:outputText value="    ����:#{self_medicalPayoffBB.age}"> </h:outputText>
                   <h:outputText value="    ��������˺ŵ�λ�ɷѱ���:#{self_medicalPayoffBB.medPayBO.unitRate}%"> </h:outputText>
                   <h:outputText value="    ���˽ɷѱ���:#{self_medicalPayoffBB.medPayBO.personRate}%"> </h:outputText>
                   <h:outputText value="    �ϼ�:#{self_medicalPayoffBB.medPayBO.sumRate}%"> </h:outputText>
              </td>
          </tr>

          <tr>
              <td height=8 colspan=2>
                   <h:outputText escape="false" value="    <strong>ע��:</strong>���Ͻ������ο���δ����֧ȡ����Ϣ"> </h:outputText>
              </td>
          </tr>

          <tr>
              <td height=8 colspan=2>
          </tr>

          <tr><td colspan=2>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
  </h:form>
  </body>
</html>