<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <x:saveState value="#{self_surveyprocessBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{self_surveyprocessBB.showInput}"/>
      <c:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td  class="td_title" height=8>
</c:verbatim>
              <h:graphicImage value="/images/tips.gif" />
               <f:verbatim>
				   <%=LanguageSupport.getResource( "XTGL-1399", "查看结果")%>
			   </f:verbatim>
<c:verbatim>
              </td>
          </tr>

          <tr>
              <td  height=8>
 </c:verbatim>
                  <h:selectOneMenu value="#{self_surveyprocessBB.inputQuestion}" style="width:320px">
                       <c:selectItems value="#{self_surveyprocessBB.inputQuestionList}"></c:selectItems>
                  </h:selectOneMenu>
                  <h:commandButton id="count" value="查询" styleClass="button01" action="#{self_surveyprocessBB.doQuery}"></h:commandButton>
                  <h:commandButton id="export" value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
                  <h:commandButton value="关闭" styleClass="button01" onclick="window.close()"></h:commandButton>
<c:verbatim>
              </td>
          </tr>

          <tr><td>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
</c:verbatim>
  </h:form>
