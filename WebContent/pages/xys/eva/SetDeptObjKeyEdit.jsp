<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
         function checkForm(){
             if(!checkValidate(document.all('form1:weight'), 'Ȩ��', 'f','',0)){
                return false;
             }else{
                 return true;
             }

         }
   </script>
  <x:saveState value="#{xys_KpiDeptSetBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_KpiDeptSetBB.initKey}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� ->KPIָ������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="ָ������"></h:outputText>
               <h:inputText value="#{xys_KpiDeptSetBB.keyBo.keyName}"/>
               <h:outputText value="Ŀ��ֵ"></h:outputText>
               <h:inputText value="#{xys_KpiDeptSetBB.keyBo.aimValue}"/>
               <h:outputText value="������Դ"></h:outputText>
               <h:inputText value="#{xys_KpiDeptSetBB.keyBo.dataSource}"/>
               <h:outputText value="ָ��Ȩ�أ�%��"></h:outputText>
               <h:inputText id="weight" value="#{xys_KpiDeptSetBB.keyBo.weight}"/>
               <h:outputText value="��ָ���"></h:outputText>
               <h:inputText value="#{xys_KpiDeptSetBB.keyBo.hiValue}"/>
               <h:outputText value="��ֵ���"></h:outputText>
               <h:inputText value="#{xys_KpiDeptSetBB.keyBo.lowValue}"/>
               <h:outputText value="��ֱ�׼"></h:outputText>
               <h:inputTextarea value="#{xys_KpiDeptSetBB.keyBo.gradeStd}" rows="5" cols="50"></h:inputTextarea>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{xys_KpiDeptSetBB.saveKey}" onclick="return checkForm();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>