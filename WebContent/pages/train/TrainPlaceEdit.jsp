<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
    
     
      <script type="text/javascript">
          function chkDate(){
          	if(document.all('form1:placeName').value=="" || document.all('form1:placeLocate').value=="")
             {
             alert("����д������Ϣ��");
             return false;
             }
             return true;
          }
          function forBack(form){
             window.close();
          }
      </script>
 


  <x:saveState value="#{train_placeeditbb}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{train_placeeditbb.initEdit}"></h:inputHidden>
      <h:inputHidden id="createOrg" value="#{train_placeeditbb.placebo.createOrg}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��ѵ���� -> ��ѵ��������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��ѵ��������"></h:outputText>
               <h:inputText id="placeName" value="#{train_placeeditbb.placebo.placeName}"></h:inputText>
			
               <h:outputText value="�����ص�"></h:outputText>
               <h:inputText id="placeLocate"  value="#{train_placeeditbb.placebo.placeLocate}"></h:inputText>

               <h:outputText value="��ѵ��������"></h:outputText>
               <h:inputText id="placeMemo"  value="#{train_placeeditbb.placebo.placeMemo}"></h:inputText>

               <h:outputText value="Ӧ�÷�Χ"></h:outputText>
               <h:selectOneMenu value="#{train_placeeditbb.placebo.placeOrg}">
                      <c:selectItems value="#{train_placeeditbb.orgList}"></c:selectItems>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01" onclick="return chkDate()" action="#{train_placeeditbb.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
