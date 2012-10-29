<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<html>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <head>
      <title></title>
      
      <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }
      </script>
  </head>

  <body>
  <x:saveState value="#{lain_EditSupplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{lain_EditSupplyBB.initEdit}"></h:inputHidden>
      <h:inputHidden   value="#{lain_EditSupplyBB.supplyBO.createOrg}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" �ͱ����� -> ��Ӧ�̹���"/>
          </h:panelGroup>
      </h:panelGrid>
      
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��Ӧ������"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.supName}"></h:inputText>

               <h:outputText value="��ʾ˳��"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.showSeq}"></h:inputText>

               <h:outputText value="��ϵ��"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.contactPerson}"></h:inputText>

               <h:outputText value="��ϵ�绰"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.contactTel}"></h:inputText>

               <h:outputText value="����"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.fax}"></h:inputText>

               <h:outputText value="��ϵ��ַ"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.contactAdres}"></h:inputText>

               <h:outputText value="��������"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.postCode}"></h:inputText>

               <h:outputText value="eMail"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.email}"></h:inputText>

               <h:outputText value="��ַ"></h:outputText>
               <h:inputText value="#{lain_EditSupplyBB.supplyBO.webSite}"></h:inputText>

               <h:outputText value="������Χ"></h:outputText>
               <h:selectOneMenu value="#{lain_EditSupplyBB.supplyBO.orgScoppe}">
                      <c:selectItems value="#{lain_EditSupplyBB.orgList}"></c:selectItems>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save"  action="#{lain_EditSupplyBB.saveOrUpdateSupplyBO}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
  </body>
</html>