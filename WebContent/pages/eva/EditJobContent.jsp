<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }
      </script>
  <x:saveState value="#{eva_jobEstimateEditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{eva_jobEstimateEditBB.pageInit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� -> ������λְ�𿼺�"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��������"></h:outputText>
               <h:inputText value="#{eva_jobEstimateEditBB.evaJobContentBO.content}"></h:inputText>

               <h:outputText value="Ȩ��"></h:outputText>
               <h:inputText value="#{eva_jobEstimateEditBB.evaJobContentBO.preview}"></h:inputText>

               <h:outputText value="������"></h:outputText>
               <h:inputText value="#{eva_jobEstimateEditBB.evaJobContentBO.selfScore}"></h:inputText>
               
               <h:outputText value="������"></h:outputText>
               <h:inputText value="#{eva_jobEstimateEditBB.evaJobContentBO.result}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{eva_jobEstimateEditBB.updateJobPlan}" />
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
