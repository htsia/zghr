<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
    	function chkData(){
             return forsubmit(document.forms(0));
         }
    	</script>   
  <x:saveState value="#{titleContentSetBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{titleContentSetBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ְ�ƹ��� -> ������������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="ģ������"></h:outputText>
               <h:inputText  value="#{titleContentSetBB.tempbo.templateName}"></h:inputText>
			   <h:outputText value="�ܷ�"></h:outputText>
               <h:inputText  value="#{titleContentSetBB.tempbo.totalScore}"></h:inputText>
               <h:outputText value="�ȼ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{titleContentSetBB.tempbo.levelId}"
                     alt="ְ�Ƽ���|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" />
               </h:panelGroup>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{titleContentSetBB.saveTemp}" onclick="chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>