<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }
      </script>

  <x:saveState value="#{emp_pieceEditBB}" />
  <h:inputHidden value="#{emp_pieceEditBB.pageInit}"/>
  <h:form id="form1">
      <h:panelGrid columns="2" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:outputText value="��λ��#{emp_pieceEditBB.unitName}"/>
              <c:verbatim>&nbsp;</c:verbatim>
              <h:outputText value="���ף�#{emp_pieceEditBB.setName}"/>
              <c:verbatim>&nbsp;</c:verbatim>
              <h:outputText value="��нʱ�䣺#{emp_pieceEditBB.payoffDate}"/>
              <c:verbatim>&nbsp;</c:verbatim>
           </h:panelGroup>

          <h:panelGroup>
              <h:outputText value="��������:" />
              <h:inputText  id="nameStr" value="#{emp_pieceEditBB.nameStr}" style="width:140"/>
              <h:commandButton value="��ѯ" id="addMany" styleClass="button01" action="#{emp_pieceEditBB.addMany}" />
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="2"  width="98%" align="center">
          <h:panelGroup>
              <h:outputText value="��ѡ��"></h:outputText>
              <h:selectOneMenu value="#{emp_pieceEditBB.code}" onchange="submit()" valueChangeListener="#{emp_pieceEditBB.changePerson}">
                  <c:selectItems value="#{emp_pieceEditBB.pids}"></c:selectItems>
              </h:selectOneMenu>
          </h:panelGroup>

          <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{emp_pieceEditBB.saveManyAdd}" style="display:none"/>
           </h:panelGrid>
      </h:panelGrid>

      <h:panelGrid columns="8" width="98%" align="center">
           <h:inputHidden value="#{emp_pieceEditBB.personID}"></h:inputHidden>
           <h:outputText value="Ա����ţ�#{emp_pieceEditBB.code}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="Ա��������#{emp_pieceEditBB.name}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="���ڲ��ţ�#{emp_pieceEditBB.dept}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="н�ʲ��ţ�#{emp_pieceEditBB.wageDept}"/>
      </h:panelGrid>

      <c:verbatim><br></c:verbatim>

      <jsp:include page="/pages/common/activepage/ActiveDetail.jsp?tableId=A002&flag=1&setId=A002&isEdit=true">
          <jsp:param name="hasOperSign" value="true"/>
          <jsp:param name="operSignType" value="checkbox"/>
          <jsp:param name="isCheckRight" value="true"/>
          <jsp:param name="hasFuncBnt" value="true"/>
      </jsp:include>
  </h:form>