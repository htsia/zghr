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
  <x:saveState value="#{train_orgeditbb}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{train_orgeditbb.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 培训管理 -> 培训机构管理"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="培训机构名称"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.orgName}"></h:inputText>

               <h:outputText value="机构描述"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.orgDescription}"></h:inputText>

               <h:outputText value="联系人"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.contactPerson}"></h:inputText>

               <h:outputText value="联系电话"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.contactTel}"></h:inputText>

               <h:outputText value="传真"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.fax}"></h:inputText>

               <h:outputText value="联系地址"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.contactAddress}"></h:inputText>

               <h:outputText value="邮政编码"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.postcode}"></h:inputText>

               <h:outputText value="eMail"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.contactEMail}"></h:inputText>

               <h:outputText value="网址"></h:outputText>
               <h:inputText value="#{train_orgeditbb.orgbo.website}"></h:inputText>

               <h:outputText value="应用范围"></h:outputText>
               <h:selectOneMenu value="#{train_orgeditbb.orgbo.orgScope}">
                      <c:selectItems value="#{train_orgeditbb.orgList}"></c:selectItems>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save"  action="#{train_orgeditbb.save}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
  </body>
</html>