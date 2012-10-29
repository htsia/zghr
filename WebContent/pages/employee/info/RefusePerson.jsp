<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
</script>

<x:saveState value="#{empResverPersonMgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{empResverPersonMgrBB.initExcEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-0332","���˲Ź���") %> ->
                <%=LanguageSupport.getResource("RYGL-2388","�˳����˲�") %> 
              </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2049","��Ա����") %> 
               </f:verbatim>
               <h:inputText value="#{empResverPersonMgrBB.name}"></h:inputText>
                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2264","�˳�ԭ��") %> 
               </f:verbatim>
               <h:inputTextarea value="#{empResverPersonMgrBB.reason}" cols="50" rows="5">
               </h:inputTextarea>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="�˳�" id="save" action="#{empResverPersonMgrBB.deleteItem}"   styleClass="button01" onclick="javascript:return confirm('ȷ��Ҫ�˳���')"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

