<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
      <c:verbatim>
<script type="text/javascript">
    // pk ��ԱID
    // type=1 ֻ��
    function forView(form, id, type) {
        windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
    }
</script>
      </c:verbatim>
  <x:saveState value="#{emp_surveyByCodeBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_surveyByCodeBB.showDetail}"/>
      <c:verbatim>
      <table width="98%" height="98%" cellspacing="0">
      <tr >
          <td class="td_title"  height=2>
              <img src="/images/tips.gif">
                <%=LanguageSupport.getResource("RYGL-2293","   ���ݷ���") %>  
          </td>
          <td align="right" class="td_title" height=2>
              <input type="button" onclick="window.close();" value="<%=LanguageSupport.getResource("RYGL-2116","�ر�") %> " class="button01">
          </td>
      </tr>
      <tr><td colspan=2 height=8></td></tr>
      <tr><td colspan=2 valign="top">
          <jsp:include page="../../common/activepage/ActiveList.jsp">
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="hasEdit" value="true"/>
              <jsp:param name="isEditList" value="false"/>
              <jsp:param name="isCheckRight" value="false"/>
              <jsp:param name="isForward" value="true"/>
              <jsp:param name="isRow" value="true"/>
              <jsp:param name="isPage" value="true"/>
              <jsp:param name="rowFuncName" value="forView"/>
          </jsp:include>
      </td></tr>
      </table>
</c:verbatim>
  </h:form>
