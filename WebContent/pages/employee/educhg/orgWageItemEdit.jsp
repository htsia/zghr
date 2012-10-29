<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<x:saveState value="#{empEduChangeMgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{empEduChangeMgrBB.initOrgWageItemEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              		<f:verbatim>
				<%=LanguageSupport.getResource("RYGL-0300",
									"��Ա���� ")%>->
                  <%=LanguageSupport.getResource("RYGL-2237",
									"н�ʹ����趨")%>
			</f:verbatim>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <f:verbatim>
				   <%=LanguageSupport.getResource("RYGL-2042", "ָ������ ")%> 
			   </f:verbatim>
               <h:inputText value="#{empEduChangeMgrBB.orgEdeWagebo.wageItemDes}" readonly="true"></h:inputText>
                <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1002", "���� ")%> 
			   </f:verbatim>
               <h:selectOneRadio value="#{empEduChangeMgrBB.orgEdeWagebo.wageType}">
               		<c:selectItem itemLabel="����" itemValue="1"/>
               		<c:selectItem itemLabel="��ʽ" itemValue="2"/>
               		<c:selectItem itemLabel="�׸ļ���" itemValue="9"/>
               </h:selectOneRadio>
                <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1157", "˳�� ")%> 
			   </f:verbatim>
               <h:inputText value="#{empEduChangeMgrBB.orgEdeWagebo.wageOrder}" readonly="true"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{empEduChangeMgrBB.saveOrgWageItem}"   styleClass="button01" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
