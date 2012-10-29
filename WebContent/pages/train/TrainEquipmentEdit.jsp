<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 
      
     	<script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }

          function checkDateNull(){
              if(document.all("form1:equipmentName").value=="")
              {
                  alert("«Î ‰»Î∆˜≤ƒ√˚≥∆");
                   return false;
              }
              return true;
           }
          
      </script>
 

  <body>
  <x:saveState value="#{train_equipmenteditbb}" />
  <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{train_equipmenteditbb.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ≈‡—µπ‹¿Ì -> ≈‡—µ∆˜≤ƒπ‹¿Ì"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="≈‡—µ∆˜≤ƒ√˚≥∆"></h:outputText>
               <h:inputText id="equipmentName" value="#{train_equipmenteditbb.bo.equipmentName}"></h:inputText>
               
               <h:outputText value="∆˜≤ƒ√Ë ˆ"></h:outputText>
               <h:inputText value="#{train_equipmenteditbb.bo.equipmentMemo}"></h:inputText>

               <h:outputText value="”¶”√∑∂Œß"></h:outputText>
               <h:selectOneMenu value="#{train_equipmenteditbb.bo.equipmentOrg}">
                        <c:selectItems value="#{train_equipmenteditbb.equipmentOrgList}"></c:selectItems>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="±£¥Ê" id="save" onclick="return checkDateNull();"  action="#{train_equipmenteditbb.save}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
 
  </body>

