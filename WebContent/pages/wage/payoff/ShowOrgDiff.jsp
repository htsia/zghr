<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

  <h:form>
      <x:saveState value="#{wage_diffBB}"></x:saveState>
      <h:inputHidden value="#{wage_diffBB.initOrgDiff}"/>
      <h:inputHidden value="#{wage_diffBB.currentdateID}"/>
      <h:inputHidden value="#{wage_diffBB.currentPayoffDate}"/>
<c:verbatim>
      <table height=98% width=98%>
          <tr height=8><td>
</c:verbatim>
          <h:panelGrid columns="4">
              <h:outputText value="当前机构：#{wage_diffBB.unitName}"></h:outputText>

              <h:selectOneMenu value="#{wage_diffBB.dateID}">
                  <c:selectItems value="#{wage_diffBB.monthList}"></c:selectItems>
              </h:selectOneMenu>

              <h:selectOneMenu value="#{wage_diffBB.itemType}" >
                  <c:selectItems value="#{wage_diffBB.itemTypeList}"></c:selectItems>
              </h:selectOneMenu>

              <h:panelGroup>
                  <h:commandButton value="开始比较" styleClass="button01" action="#{wage_diffBB.showOrgDiff}"></h:commandButton>
                  <h:commandButton value="导出" styleClass="button01" onclick="doExport2()"></h:commandButton>
                  <h:commandButton value="返回" styleClass="button01" onclick="window.close()"></h:commandButton>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
      </td></tr>
      <tr><td>
      <jsp:include page="/pages/common/activepage/ShowTable.jsp">
          <jsp:param name="para" value="true"/>
      </jsp:include>
     </td></tr>
      </table>
</c:verbatim>      
  </h:form>
