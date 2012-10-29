<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	return forsubmit(document.forms(0)); 
}
</script>

<x:saveState value="#{resumeAducationBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{resumeAducationBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="subid" value="#{resumeAducationBB.subid}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 简历管理 ->学历编辑 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="学历"></h:outputText>
              	<h:panelGroup>
				<h:inputText styleClass="input" id="degree" code="" dict="yes" dict_num="0365"
                     readonly="true" value="#{resumeAducationBB.eductionbo.a004005}" alt="学历|0|s|50||"/>
                <h:commandButton type="button"  onclick="PopUpCodeDlgOneControl('form1:degree')" styleClass="button_select"/>
				</h:panelGroup>
				<h:outputText value="专业类别"></h:outputText>
              	<h:panelGroup>
				<h:inputText styleClass="input" id="a004010" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{resumeAducationBB.eductionbo.a004010}"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:a004010')" />
				</h:panelGroup>
				<h:outputText value="专业名称"></h:outputText>
               <h:inputText value="#{resumeAducationBB.eductionbo.a004012}"></h:inputText>
               <h:outputText value="毕业院校"></h:outputText>
               <h:inputText value="#{resumeAducationBB.eductionbo.a004035}"></h:inputText>
              	<h:outputText value="入学时间"></h:outputText>
               <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{resumeAducationBB.eductionbo.a004015}"
                             readonly="true"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
            	<h:outputText value="毕业时间"></h:outputText>
               		<h:panelGroup>
                	<h:inputText styleClass="input" id="endDate" value="#{resumeAducationBB.eductionbo.a004030}"
                             readonly="true"/>
               		<c:verbatim>
                  	<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                	</c:verbatim>
            	</h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save"  action="#{resumeAducationBB.save}"   styleClass="button01" rendered="#{resumeAducationBB.method=='0'}" onclick="javascript:return forSave()"/>
              <h:commandButton value="保存" id="update"  action="#{resumeAducationBB.update}"   styleClass="button01" rendered="#{resumeAducationBB.method=='1'}" onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
