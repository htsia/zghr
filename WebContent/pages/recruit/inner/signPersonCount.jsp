<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp" %>
   
      <script type="text/javascript">
         function checkDateNull(){
             if(document.all("form1:needcount").value=="")
              {
            	  alert("����д��������");
                  return false;
              }
              return true;
           }
          
      </script>
 <x:saveState value="#{recruit_innerBB}" />
 <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recruit_innerBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ƹ���� -> ���������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="100%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                <h:outputText value="��λ����"></h:outputText>
                <h:inputText value="#{recruit_innerBB.innerBo.postname}" readonly="true"></h:inputText>
               	<h:outputText value="����ʱ��"></h:outputText>
               	<h:inputText value="#{recruit_innerBB.innerBo.publishdate}" readonly="true"></h:inputText>
				<h:outputText value="��Ҫ����"></h:outputText>
               	<h:inputText id="needcount" value="#{recruit_innerBB.innerBo.needCount}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" onclick="return checkDateNull();"  action="#{recruit_innerBB.save}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>


