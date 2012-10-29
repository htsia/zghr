<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
 <base target="_self">
  <x:saveState value="#{wage_diffDetailBB}"></x:saveState>
  <h:form>
      <h:inputHidden value="#{wage_diffDetailBB.initDeptDiff}"/>
      <table height=98% width=98%>
      <tr><td height=8>
          <h:panelGrid columns="2">
              <h:outputText value="信息项目:#{wage_diffDetailBB.fieldDes}"></h:outputText>
              <h:panelGrid align="right">
                  <h:commandButton value="返回" styleClass="button01" onclick="window.close()"></h:commandButton>
              </h:panelGrid>
          </h:panelGrid>
      </td></tr>
          
       <tr><td height=10></td></tr>

      <tr><td >
          <jsp:include page="/pages/common/activepage/ShowTable.jsp">
              <jsp:param name="para" value="true"/>
              <jsp:param name="rowFuncName" value="forViewPersonWage"/>
          </jsp:include>
      </td></tr>
      </table>
  </h:form>



















