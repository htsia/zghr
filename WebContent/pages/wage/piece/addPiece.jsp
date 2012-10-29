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
              <h:outputText value="单位：#{emp_pieceEditBB.unitName}"/>
              <c:verbatim>&nbsp;</c:verbatim>
              <h:outputText value="帐套：#{emp_pieceEditBB.setName}"/>
              <c:verbatim>&nbsp;</c:verbatim>
              <h:outputText value="发薪时间：#{emp_pieceEditBB.payoffDate}"/>
              <c:verbatim>&nbsp;</c:verbatim>
           </h:panelGroup>

          <h:panelGroup>
              <h:outputText value="姓名或编号:" />
              <h:inputText  id="nameStr" value="#{emp_pieceEditBB.nameStr}" style="width:140"/>
              <h:commandButton value="查询" id="addMany" styleClass="button01" action="#{emp_pieceEditBB.addMany}" />
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="2"  width="98%" align="center">
          <h:panelGroup>
              <h:outputText value="请选择："></h:outputText>
              <h:selectOneMenu value="#{emp_pieceEditBB.code}" onchange="submit()" valueChangeListener="#{emp_pieceEditBB.changePerson}">
                  <c:selectItems value="#{emp_pieceEditBB.pids}"></c:selectItems>
              </h:selectOneMenu>
          </h:panelGroup>

          <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{emp_pieceEditBB.saveManyAdd}" style="display:none"/>
           </h:panelGrid>
      </h:panelGrid>

      <h:panelGrid columns="8" width="98%" align="center">
           <h:inputHidden value="#{emp_pieceEditBB.personID}"></h:inputHidden>
           <h:outputText value="员工编号：#{emp_pieceEditBB.code}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="员工姓名：#{emp_pieceEditBB.name}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="所在部门：#{emp_pieceEditBB.dept}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="薪资部门：#{emp_pieceEditBB.wageDept}"/>
      </h:panelGrid>

      <c:verbatim><br></c:verbatim>

      <jsp:include page="/pages/common/activepage/ActiveDetail.jsp?tableId=A002&flag=1&setId=A002&isEdit=true">
          <jsp:param name="hasOperSign" value="true"/>
          <jsp:param name="operSignType" value="checkbox"/>
          <jsp:param name="isCheckRight" value="true"/>
          <jsp:param name="hasFuncBnt" value="true"/>
      </jsp:include>
  </h:form>