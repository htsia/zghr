<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
             if(!checkValidate(form1.all('form1:weightKpi'), 'KPIȨ��', 'i','',0)){
                return false;
             }else if(!checkValidate(form1.all('form1:weight360'), '360Ȩ��', 'i','',0)){
                 return false;
             }else if(!checkValidate(form1.all('form1:weightXspj'), '��������Ȩ��', 'i')){
                return false;
             }else{
                return true;
             }

       }
   </script>
  <x:saveState value="#{xys_PlanPostMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_PlanPostMgrBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"></h:inputHidden>
      <h:inputHidden id="postId" value="#{xys_PlanPostMgrBB.postId}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� ->�༭����ģ��"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <h:outputText value="KPIȨ�أ�%��"/>
              <h:inputText id="weightKpi" value="#{xys_PlanPostMgrBB.setBO.weightKpi}" />
               <h:outputText value="360Ȩ�أ�%��"/>
              <h:inputText id="weight360" value="#{xys_PlanPostMgrBB.setBO.weight360}" />
               <h:outputText value="��������Ȩ�أ�%��"/>
              <h:inputText id="weightXspj" value="#{xys_PlanPostMgrBB.setBO.weightXspj}" />
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{xys_PlanPostMgrBB.saveMode}" onclick="return chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>