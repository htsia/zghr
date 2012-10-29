<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
</script>

<x:saveState value="#{recuorgEmailmgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recuorgEmailmgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="邮件服务器"></h:outputText>
               <h:inputText value="#{recuorgEmailmgrBB.emailbo.pop3}"></h:inputText>
               <h:outputText value="用户名"></h:outputText>
               <h:inputText value="#{recuorgEmailmgrBB.emailbo.userName}"></h:inputText>
               <h:outputText value="密码"></h:outputText>
               <h:inputText value="#{recuorgEmailmgrBB.emailbo.password}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{recuorgEmailmgrBB.save}"   styleClass="button01" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

