<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

  <x:saveState value="#{emp_AddressBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_AddressBB.pageInit}"/>
      <c:verbatim>
      <table width="98%" height=96%>
          <tr>
          <td class=td_title height=1>
              <img src="/images/tips.gif" >������ѯ ->  ͨѶ¼
          </td></tr>

          <tr><td height=1 align="right">
      </c:verbatim>
              <h:outputText value="��ѡ��ͨѶ¼"></h:outputText>
              <h:selectOneMenu value="#{emp_AddressBB.bookID}">
                  <c:selectItems value="#{emp_AddressBB.bookList}"></c:selectItems>
              </h:selectOneMenu>
              <h:outputText value="  ������Ա��������:"></h:outputText>
              <h:inputText value="#{emp_AddressBB.name}"></h:inputText>
              <h:commandButton value="��ѯ" styleClass="button01" action="#{emp_AddressBB.queryAdd}"></h:commandButton>

              <h:selectBooleanCheckbox value="#{emp_AddressBB.orderByName}" onclick="submit()" valueChangeListener="#{emp_AddressBB.changeOrder}"></h:selectBooleanCheckbox>
              <h:outputText value="����������"></h:outputText>
              <h:commandButton type="button" value="�ر�" styleClass="button01" onclick="window.close();"></h:commandButton>
<c:verbatim>
          </td></tr>

          <tr><td>
              <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                  <jsp:param name="hasOperSign" value="true"/>
                  <jsp:param name="operSignType" value="checkbox"/>
                  <jsp:param name="hasEdit" value="false"/>
                  <jsp:param name="isEditList" value="false"/>
                  <jsp:param name="isCheckRight" value="false"/>
              </jsp:include>
          </td></tr>
      </table>
 </c:verbatim>
</h:form>
