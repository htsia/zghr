<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
    	
   </script>   
  <x:saveState value="#{emptitleapplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{emptitleapplyBB.initItemEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 职称管理 -> 分配学科"/>
          </h:panelGroup>
      </h:panelGrid>
      <c:verbatim>
		   	<br><br>
		   </c:verbatim>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="姓名"></h:outputText>
               <h:outputText value="#{emptitleapplyBB.titleItembo.personName}"></h:outputText>
               <h:outputText value="拟申报等级"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{emptitleapplyBB.titleItembo.applyLevel}"
                     alt="职称级别|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select" disabled="true"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" />
               </h:panelGroup>
               <h:outputText value="申报专业"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="applyMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{emptitleapplyBB.titleItembo.applyMajor}"
                     alt="专业|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select" disabled="true" onclick="PopUpCodeDlgOneControl('form1:applyMajor')" />
               </h:panelGroup>
               <h:outputText value="申报资格"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{emptitleapplyBB.titleItembo.applyTitle}"
                     alt="性别|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select" disabled="true" onclick="PopUpCodeDlgOneControl('form1:applyTitle')" />
               </h:panelGroup>
               <h:outputText value="学科"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="majorClass" code="" dict="yes" dict_num="2236"
                     readonly="true" value="#{emptitleapplyBB.titleItembo.majorClass}"
                     alt="专业类别|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:majorClass')" />
               </h:panelGroup>
           </h:panelGrid>
		   <c:verbatim>
		   	<br><br>
		   </c:verbatim>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" styleClass="button01"  action="#{emptitleapplyBB.saveItem}" onclick="return forsubmit(document.forms(0));"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>