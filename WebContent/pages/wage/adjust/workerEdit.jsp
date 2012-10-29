<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	forsubmit(document.forms(0)); 	
}
</script>

<x:saveState value="#{wageReformJobSetBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{wageReformJobSetBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 工资套改->套改岗位工资标准 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="工人技术等级"></h:outputText>
               	<h:panelGroup>
               		<h:inputText styleClass="input" id="A081701" code="" dict="yes" dict_num="0350"
                     readonly="true" value="#{wageReformJobSetBB.jobWageBo.sourceCode}"
                     alt="工人技术等级|0|s|50||"/>
                     <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A081701')">
                     </c:verbatim>
               	</h:panelGroup>
               <h:outputText value="岗位工资级别"></h:outputText>
              <h:panelGroup>
               		<h:inputText styleClass="input" id="A750701" code="" dict="yes" dict_num="2215"
                     readonly="true" value="#{wageReformJobSetBB.jobWageBo.desCode}"
                     alt="岗位工资级别|0|s|50||"/>
                     <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A750701')">
                     </c:verbatim>
               	</h:panelGroup>
               
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{wageReformJobSetBB.saveWorker}"   styleClass="button01"  onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>

