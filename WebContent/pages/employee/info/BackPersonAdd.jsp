<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }
      </script>

  <x:saveState value="#{emp_backpersonListBB}" />
  <h:form id="form1">
      <h:panelGrid columns="2" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-2260"," Ա������")%>->
                <%=LanguageSupport.getResource("RYGL-2261","  ���Ӻ��˲�")%>
              </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <c:verbatim>
          <table width=98% align="center">
          <tr><td>
      </c:verbatim>
          <h:panelGroup>
               <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-2262","������������")%> :
              </f:verbatim>
              <h:inputText  id="nameStr" value="#{emp_backpersonListBB.nameStrs}" style="width:140px"/>
              <h:commandButton value="��ѯ" styleClass="button01" id="addMany" action="#{emp_backpersonListBB.addMany}" />
          </h:panelGroup>

          <h:panelGroup>
               <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-2263","��ѡ��")%> :
              </f:verbatim>
              <h:selectOneMenu value="#{emp_backpersonListBB.personID}" onchange="submit()" valueChangeListener="#{emp_backpersonListBB.changePerson}">
                  <c:selectItems value="#{emp_backpersonListBB.pids}"></c:selectItems>
              </h:selectOneMenu>
          </h:panelGroup>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{emp_backpersonListBB.saveManyAdd}" style="display:none"/>
           </h:panelGrid>

           <h:panelGroup>
                <f:verbatim>
               <%=LanguageSupport.getResource("XTGL-1042","Ա�����")%> :
              </f:verbatim>
               <h:outputText value="#{emp_backpersonListBB.code}"/>
               <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-2136","Ա������")%> :
              </f:verbatim>
               <h:outputText value="#{emp_backpersonListBB.name}"/>
               <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-2063","���ڲ���")%> :
              </f:verbatim>
               <h:outputText value="#{emp_backpersonListBB.dept}"/>
          </h:panelGroup>
    <c:verbatim>
      </td></tr>

      <tr><td>
          <jsp:include page="../../common/activepage/ActiveDetail.jsp">
              <jsp:param name="isEdit" value="true"/>
              <jsp:param name="setId" value="A067"/>
              <jsp:param name="flag" value="1"/>
              <jsp:param name="tableId" value="A067"/>
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="isCheckRight" value="true"/>
              <jsp:param name="hasFuncBnt" value="true"/>
          </jsp:include>
       </td></tr>

      </table>
     </c:verbatim>
  </h:form>
