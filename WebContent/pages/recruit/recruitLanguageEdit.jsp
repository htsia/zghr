<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	return forsubmit(document.forms(0)); 	
}
</script>

<x:saveState value="#{recuLanguageBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recuLanguageBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="subid" value="#{recuLanguageBB.subid}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" �������� ->���������༭ "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="����"></h:outputText>
              	<h:panelGroup>
				<h:inputText styleClass="input" id="a842701" code="" dict="yes" dict_num="0383"
                     readonly="true" value="#{recuLanguageBB.languagebo.a842701}"
                     alt="����|0|s|50||"/>
                <h:commandButton type="button"  onclick="PopUpCodeDlgOneControl('form1:a842701')" styleClass="button_select"/>
				</h:panelGroup>
               <h:outputText value="��˵�����̶�"></h:outputText>
               <h:inputText value="#{recuLanguageBB.languagebo.a842702}"></h:inputText>
              <h:outputText value="��д�����̶�"></h:outputText>
               <h:inputText value="#{recuLanguageBB.languagebo.a842708}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{recuLanguageBB.save}"   styleClass="button01"  onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

